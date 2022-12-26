<?php

if (!defined('NV_IS_MOD_NEWS')) {
  exit('Stop!!!');
}

$action = $nv_Request->get_string('action', 'post');
$resp = array(
  'status' => 0
);
if (!empty($action) && function_exists($action)) {
  $action();
}

echo json_encode($resp);
die();

function thanhtoan() {
  global $db, $resp, $nv_Request, $_SESSION;

  $data = $nv_Request->get_array('data', 'post');

  $sql = "select id from pos_hoadon order by id desc limit 1";
  $hang = $db->fetch($sql);
  $mahoadon = "HD" . fillzero(($hang['id'] ? $hang['id'] : 0) + 1);
  $thoigian = time();
  
  $sql = "select userid from pet_users_session where session = '$_SESSION[session]'";
  $session = $db->fetch($sql);

  $idkhach = $data['khachhang']['id'];
  // thu ưu tiên chuyển khoản và điểm, phần còn lại là tiền mặt
  $tienmat = $data['thanhtoan'][0];
  $chuyenkhoan = $data['thanhtoan'][1];
  $doidiem = $data['thanhtoan'][2];
  $thukhach = $tienmat + $chuyenkhoan + $doidiem;
  $no = 0;
  $thoigian = time();
  $tongtien = 0;

  // tính tích điểm
  // cứ 10k/điểm
  // công thức: điểm = (tổng tiền - giảm giá * 10) / 10000
  // cần làm: trả hàng trừ tích điểm
  if ($data['thanhtien'] < 0) {
    $doidiem = 0;
    $thukhach = 0;
    $diem = floor($data['thanhtien'] / 10000);
    $tongtien = $data['thanhtien'];

    $sql = "select * from pos_loaithuchi where ten = 'Chi tiền trả khách' and loai = 1";
    if (empty($loaithuchi = $db->fetch($sql))) {
      $sql = "insert into pos_loaithuchi (loai, ten) values(1, 'Chi tiền trả khách')";
      $db->query($sql);
      $loaithuchi = ['loai' => 1, 'id' => $db->insertid];
    }
  }
  else {
    $diem = intval(($data['tonghang'] - ($data['tonghang'] - $data['thanhtien'] + $doidiem) * 100) / 10000);
    if ($diem < 0) $diem = 0;

    $thanhtoantrutien = $data['thanhtien'] - $chuyenkhoan - $doidiem;
    if ($tienmat >= $thanhtoantrutien) {
      $tienmat = $thanhtoantrutien;
      $data['thanhtoan'][0] = $tienmat;
      $thukhach = $tienmat + $chuyenkhoan + $doidiem;
    }
    else {
      // nợ tiền
      $no = $data['thanhtien'] - $tienmat - $chuyenkhoan - $doidiem;
    }

    foreach ($data['thanhtoan'] as $loai => $sotien) {
      if ($sotien) $tongtien += $sotien;
    }
  
    $sql = "select * from pos_loaithuchi where ten = 'Thu tiền khách trả' and loai = 0";
    if (empty($loaithuchi = $db->fetch($sql))) {
      $sql = "insert into pos_loaithuchi (loai, ten) values(0, 'Thu tiền khách trả')";
      $db->query($sql);
      $loaithuchi = ['loai' => 0, 'id' => $db->insertid];
    }
  }

  if ($idkhach && ($doidiem || $diem || $no)) {
    $doidiem = floor($doidiem / 100);
    $sql = "update pos_khachhang set tienno = tienno + $no, diem = diem + $diem - $doidiem where id = $idkhach";
    $db->query($sql);
  }

  $sql = "select id from pos_thuchi order by id desc limit 1";
  $thuchi = $db->fetch($sql);
  if (empty($thuchi)) $thuchi = ['id' => 0];
  $idthuchi = $thuchi['id'];
  $mathuchi = "TC" . fillzero(++ $idthuchi);
  $sql = "insert into pos_thuchi (mathuchi, idloaithuchi, idkhachhang, sotien, thoigian, ghichu) values('$mathuchi', $loaithuchi[id], $idkhach, $tongtien, $thoigian, '')";

  $idthuchi = $db->insertid($sql);

  $sql = "insert into pos_hoadon (mahoadon, idnguoiban, idnguoiratoa, idkhach, thoigian, soluong, tongtien, giamgiatien, giamgiaphantram, thanhtien, thanhtoan, ghichu) values('$mahoadon', $data[nguoiban], $session[userid], $idkhach, $thoigian, $data[soluong], $data[tongtien], $data[giamgiatien], $data[giamgiaphantram], $data[thanhtien], $thukhach, '$data[ghichu]')";
  $id = $db->insertid($sql);

  $loinhuan = 0;
  if (count($data['hanghoa'])) {
    // tính lợi nhuận
    // đếm lợi nhuận từng mặt hàng
    foreach ($data['hanghoa'] as $hanghoa) {
      $loinhuan += ($hanghoa['giaban'] - $hanghoa['gianhap']) * $hanghoa['soluong'];

      $sql = "insert into pos_chitiethoadon (idhoadon, idhang, gianhap, dongia, giamgiatien, giamgiaphantram, giaban, soluong, thanhtien, soluongthuc) values($id, $hanghoa[id], $hanghoa[gianhap], $hanghoa[dongia], $hanghoa[giamgiatien], $hanghoa[giamgiaphantram], $hanghoa[giaban], $hanghoa[soluong], ". ($hanghoa['giaban'] * $hanghoa['soluong']) .", $hanghoa[soluong])";
      $db->query($sql);

      $sql = "update pos_hanghoa set soluong = soluong - $hanghoa[soluong] where id = $hanghoa[id]";
      $db->query($sql);
    }
    if ($data['trangthaitrahang']) {
      if ($data['thanhtien'] > 0) $loinhuan = floor($loinhuan * (1 - $data['thanhtoan'][2] / $data['thanhtien']));
    }
    else {
      $loinhuan = floor($loinhuan * ($data['thanhtoan'][0] + $data['thanhtoan'][1]) / $data['thanhtien'] - $data['thanhtoan'][2]);
    }
  }

  if (count($data['hangtra'])) {
    foreach ($data['hangtra'] as $hanghoa) {
      // thêm mặt hàng khách trả
      $thanhtienhanghoa = $hanghoa['soluong'] * $hanghoa['giaban'];
      $loinhuan -= ($hanghoa['giaban'] - $hanghoa['gianhap']) * $hanghoa['soluong'];
      $sql = "insert into pos_chitiettrahang (idhoadon, idhang, soluong, giaban, thanhtien, loinhuan) values($id, $hanghoa[id], $hanghoa[soluong], $hanghoa[giaban], $thanhtienhanghoa, $loinhuan)";
      $db->query($sql);
      
      // cập nhật số lượng hàng hóa khách trả
      $sql = "update pos_hanghoa set soluong = soluong + $hanghoa[soluong] where id = $hanghoa[id]";
      $db->query($sql);
    }
  }

  $sql = "insert into pos_machitietthuchi (idthuchi, mahoadon, sotien, loinhuan) values($idthuchi, '$mahoadon', $data[thanhtien], $loinhuan)";
  $db->query($sql);

  if ($data['thanhtien'] > 0) {
    foreach ($data['thanhtoan'] as $loai => $sotien) {
      if ($sotien) {
        $sql = "insert into pos_chitietthuchi(idthuchi, loai, sotien) values($idthuchi, $loai, $sotien)";
        $db->query($sql);
      }
    }
  }
  else {
    $sql = "insert into pos_chitietthuchi(idthuchi, loai, sotien) values($idthuchi, 0, $data[thanhtien])";
    $db->query($sql);
  }

  $resp['status'] = 1;
  $resp['html'] = inhoadon($id);
  $resp['messenger'] = "Đã thanh toán";
}

function thuno() {
  global $db, $resp, $nv_Request, $crypt;

  $data = $nv_Request->get_array('data', 'post');
  $tongtien = 0;
  $thoigian = time();
  foreach ($data['thanhtoan'] as $loai => $sotien) {
    if ($sotien) $tongtien += $sotien;
  }

  $sql = "select * from pos_loaithuchi where ten = 'Thu nợ khách trả' and loai = 0";
  if (empty($loaithuchi = $db->fetch($sql))) {
    $sql = "insert into pos_loaithuchi (loai, ten) values(0, 'Thu nợ khách trả')";
    $db->query($sql);
    $loaithuchi = ['id' => $db->insertid];
  }

  $khachhang = $data['khachhang'];
  $sql = "select id from pos_thuchi order by id desc limit 1";
  $thuchi = $db->fetch($sql);
  if (empty($thuchi)) $thuchi = ['id' => 0];
  $idthuchi = $thuchi['id'];
  $mathuchi = "TC" . fillzero(++ $idthuchi);
  $sql = "insert into pos_thuchi (mathuchi, idloaithuchi, idkhachhang, sotien, thoigian, ghichu) values('$mathuchi', $loaithuchi[id], $khachhang[id], $tongtien, $thoigian, '')";
  $idthuchi = $db->insertid($sql);

  $dautien = true;
  foreach ($data['hoadon'] as $hoadon) {
    // tính lợi nhuận
    // đếm lợi nhuận từng mặt hàng
    // tính phần trăm theo số tiền thu trên tổng hóa đơn
    $sql = "select b.* from pos_hoadon a inner join pos_chitiethoadon b on a.mahoadon = '$hoadon[mahoadon]' and a.id = b.idhoadon";
    $chitiethoadon = $db->all($sql);
    $tongtien = 0;
    $loinhuan = 0;

    foreach ($chitiethoadon as $chitiet) {
      $tongtien += $chitiet['thanhtien'];
      $loinhuan += ($chitiet['giaban'] - $chitiet['gianhap']) * $chitiet['soluongthuc'];
    }
    $loinhuan = floor($loinhuan * $hoadon['thuthem'] / $tongtien);
    if ($dautien) {
      $dautien = false;
      $loinhuan -= $data['thanhtoan'][2];
    }

    $sql = "insert into pos_machitietthuchi (idthuchi, mahoadon, sotien, loinhuan) values($idthuchi, '$hoadon[mahoadon]', $hoadon[thuthem], $loinhuan)";
    $db->query($sql);

    $sql = "update pos_hoadon set thanhtoan = thanhtoan + $hoadon[thuthem] where id = $hoadon[id]";
    $db->query($sql);
  }
  $sql = "update pos_khachhang set tienno = tienno - $tongtien where id = $khachhang[id]";
  $db->query($sql);

  foreach ($data['thanhtoan'] as $loai => $sotien) {
    if ($sotien) {
      $sql = "insert into pos_chitietthuchi(idthuchi, loai, sotien) values($idthuchi, $loai, $sotien)";
      $db->query($sql);
    }
  }

  $resp['messenger'] = 'Đã thu toa nợ';
  $resp['status'] = 1;
}

function timhang() {
  global $db, $resp, $nv_Request, $crypt;

  $tukhoa = $nv_Request->get_string('tukhoa', 'post');
  $sql = "select id, mahang as ma, tenhang as ten, giaban, gianhap, soluong, hinhanh, donvi from pos_hanghoa where tenhang like '%$tukhoa%' or mahang like '%$tukhoa%' order by id desc limit 20";
  $danhsach = $db->all($sql);

  foreach ($danhsach as $thutu => $hang) {
    $danhsach[$thutu]['hinhanh'] = getimage($hang['hinhanh']);
  }

  $resp['danhsach'] = $danhsach;
  $resp['status'] = 1;
}

function timkhach() {
  global $db, $resp, $nv_Request, $crypt;

  $tukhoa = $nv_Request->get_string('tukhoa', 'post');
  $sql = "select * from pos_khachhang where tenkhach like '%$tukhoa%' or makhach like '%$tukhoa%' order by id desc limit 20";
  $danhsach = $db->all($sql);

  $resp['danhsach'] = $danhsach;
  $resp['status'] = 1;
}

function timkhachthuno() {
  global $db, $resp, $nv_Request, $crypt;

  $tukhoa = $nv_Request->get_string('tukhoa', 'post');
  $sql = "select * from pos_khachhang where tenkhach like '%$tukhoa%' or makhach like '%$tukhoa%' and tienno > 0 order by id desc limit 20";
  $danhsach = $db->all($sql);

  $resp['danhsach'] = $danhsach;
  $resp['status'] = 1;
}

function thongtinthuno() {
  global $db, $resp, $nv_Request;

  $id = $nv_Request->get_string('id', 'post');
  $xtpl = new XTemplate('chitiet.tpl', UPATH . '/main');

  $sql = "select * from pos_hoadon where thanhtoan < thanhtien and idkhach = $id";
  $danhsachhoadon = $db->all($sql);

  $sql = "select * from pos_khachhang where id = $id";
  $khachhang = $db->fetch($sql);

  $dulieu = ['khachhang' => [
    'id' => $id,
    'diem' => $khachhang['diem'],
    'tienno' => $khachhang['tienno']
  ], 'hoadon' => [], 'suathanhtoan' => 0, 'thanhtoan' => [[], [], []]];


  foreach ($danhsachhoadon as $i => $hoadon) {
    $dulieutam = [
      'id' => $hoadon['id'],
      'mahoadon' => $hoadon['mahoadon'],
      'conno' => $hoadon['thanhtien'] - $hoadon['thanhtoan'],
      'thuthem' => 0
    ];
    $dulieu['hoadon'][$i] = $dulieutam;
    $xtpl->assign('i', $i);
    $xtpl->assign('thoigian', date('d/m/Y', $hoadon['thoigian']));
    $xtpl->assign('mahoadon', $hoadon['mahoadon']);
    $xtpl->assign('dathu', number_format($hoadon['thanhtoan']));
    $xtpl->assign('conno', number_format($hoadon['thanhtien'] - $hoadon['thanhtoan']));
    $xtpl->parse('main.row');
  }
  
  $xtpl->parse('main');
  $resp['dulieu'] = $dulieu;
  $resp['noidung'] = $xtpl->text();
  $resp['status'] = 1;
}

// function signin() {
//   global $db, $resp, $nv_Request, $crypt;

//   $username = $nv_Request->get_string('username', 'post');
//   $password = $nv_Request->get_string('password', 'post');

//   $sql = "select * from pet_users where username = '$username'";
//   if (empty($user = $db->fetch($sql))) {
//     $resp['msg'] = 'Tài khoản không tồn tại';
//   }
//   else if (!$crypt->validate_password($password, $user['password'])) {
//     $resp['msg'] = 'Sai mật khẩu';
//   }
//   else {
//     login($user['userid']);
//     $resp['status'] = 1;
//   }
// }
