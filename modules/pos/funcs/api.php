<?php

if (!defined('NV_IS_MOD_NEWS')) {
  exit('Stop!!!');
}

error_reporting(E_ALL);
ini_set('display_errors', 1);
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
  $mahoadon = "HP" . fillzero(($hang['id'] ? $hang['id'] : 0) + 1);
  $thoigian = time();
  
  $sql = "select userid from pet_users_session where session = '$_SESSION[session]'";
  $session = $db->fetch($sql);

  $idkhach = $data['khachhang']['id'];
  // thu ưu tiên chuyển khoản và điểm, phần còn lại là tiền mặt
  $tienmat = $data['thanhtoan'][0];
  $chuyenkhoan = $data['thanhtoan'][1];
  $diem = $data['thanhtoan'][2];
  $thukhach = $tienmat + $chuyenkhoan + $diem;
  $no = 0

  $thanhtoantrutien = $data['thanhtien'] - $chuyenkhoan - $diem;
  if ($tienmat > $thanhtoantrutien) {
    $tienmat = $thanhtoantrutien;
    $data['thanhtoan'][0] = $tienmat;
    $thukhach = $tienmat + $chuyenkhoan + $diem;
  }
  else {
    // nợ tiền
    $no = $data['thanhtien'] - $tienmat - $chuyenkhoan - $diem;
    $sql = "update pos_khachhang set tienno = tienno + $no where id = $idkhach";
    $db->query($sql);
  }

  $sql = "select id from pos_thuchi order by id desc limit 1";
  $thuchi = $db->fetch($sql);
  if (empty($thuchi)) $thuchi = ['id' => 0];
  $idthuchi = $thuchi['id'];

  $thoigian = time();
  foreach ($data['thanhtoan'] as $loai => $sotien) {
    if ($sotien) {
      $mathuchi = "TC" . fill_zero(++ $idthuchi);
      $sql = "insert into pos_thuchi (mathuchi, loaithuchi, loaitien, sotien, thoigian) values('$mathuchi', 0, $loai, $sotien, $thoigian)";
      $db->query($sql);
    }
  }
 
  $sql = "insert into pos_hoadon (mahoadon, idnguoiban, idnguoiratoa, idkhach, thoigian, soluong, tongtien, giamgiatien, giamgiaphantram, thanhtien, thanhtoan, ghichu) values('$mahoadon', $data[nguoiban], $session[userid], $idkhach, $thoigian, $data[soluong], $data[tongtien], $data[giamgiatien], $data[giamgiaphantram], $data[thanhtien], $thukhach, '$data[ghichu]')";
  $id = $db->insertid($sql);

  foreach ($data['hanghoa'] as $hanghoa) {
    $sql = "insert into pos_chitiethoadon (idhoadon, idhang, dongia, giamgiatien, giamgiaphantram, giaban, soluong, thanhtien, soluongthuc) values($id, $hanghoa[id], $hanghoa[dongia], $hanghoa[giamgiatien], $hanghoa[giamgiaphantram], $hanghoa[giaban], $hanghoa[soluong], ". ($hanghoa['giaban'] * $hanghoa['soluong']) .", $hanghoa[soluong])";
    $db->query($sql);

    $sql = "update pos_hanghoa set soluong = soluong - $hanghoa[soluong] where id = $hanghoa[id]";
    $db->query($sql);
  }

  $resp['status'] = 1;
  $resp['html'] = inhoadon($id);
  $resp['messenger'] = "Đã thanh toán";
}

function timhang() {
  global $db, $resp, $nv_Request, $crypt;

  $tukhoa = $nv_Request->get_string('tukhoa', 'post');
  $sql = "select id, mahang as ma, tenhang as ten, giaban, soluong, hinhanh, donvi from pos_hanghoa where tenhang like '%$tukhoa%' or mahang like '%$tukhoa%' order by id desc limit 20";
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
  $sql = "select * from pos_khachhang where ten like '%$tukhoa%' or ma like '%$tukhoa%' order by id desc limit 20";
  $danhsach = $db->all($sql);

  $resp['danhsach'] = $danhsach;
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
