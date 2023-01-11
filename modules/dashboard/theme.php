<?php

if (!defined('NV_IS_MOD_NEWS')) {
  exit('Stop!!!');
}

function option($list, $name, $value) {
  $xtpl = new XTemplate('option.tpl', UPATH);
  foreach ($list as $row) {
    $xtpl->assign('name', $row[$name]);
    $xtpl->assign('value', $row[$value]);
    $xtpl->parse('main');
  }
  return $xtpl->text();
}

function danhsachhang() {
  global $db, $nv_Request;
  $xtpl = new XTemplate('danhsach.tpl', UPATH . '/item/');

  $gioihan = 10;
  $filter = $nv_Request->get_array('filter', 'post');
  $query = array();
  if (empty($filter['page'])) $filter['page'] = 1;

  if (!empty($filter['tukhoa'])) $query []= "(tenhang like '%$filter[tukhoa]%' or mahang like '%$filter[tukhoa]%' or gioithieu like '%$filter[tukhoa]%')";
  if (!empty($filter['loaihang'])) $query []= "loaihang = $filter[loaihang]";
  if (count($query)) $query = " and " . implode(' and ', $query);
  else $query = '';

  $sql = "select count(id) as count from pos_hanghoa where kichhoat = 1 $query";
  $total = $db->fetch($sql)['count']; 

  $sql = "select * from pos_hanghoa where kichhoat = 1 $query order by id desc limit $gioihan offset ". ($filter['page'] - 1) * $gioihan;
  $list = $db->all($sql);

  $quyensua = quyennhanvien(213);
  $quyenxoa = quyennhanvien(214);
  $quyengia = quyennhanvien(215);
  if ($quyengia) $xtpl->parse('main.gianhap');

  foreach ($list as $row) {
    $hinhanh = explode(',', $row['hinhanh']);
    if (count($hinhanh) && !empty($hinhanh[0])) $hinhanh = $hinhanh[0];
    else $hinhanh = '/assets/images/noimage.png';
    $xtpl->assign('hinhanh', $hinhanh);
    $xtpl->assign('id', $row['id']);
    $xtpl->assign('mahang', $row['mahang']);
    $xtpl->assign('tenhang', $row['tenhang'] . (strlen($row['donvi']) ? " ($row[donvi])" : ''));
    $xtpl->assign('donvi', $row['donvi']);
    $xtpl->assign('gianhap', number_format($row['gianhap']));
    $xtpl->assign('giaban', number_format($row['giaban']));
    $xtpl->assign('soluong', number_format($row['soluong']));
    if ($quyensua) $xtpl->parse('main.row.sua');
    if ($quyenxoa) $xtpl->parse('main.row.xoa');
    if ($quyengia) $xtpl->parse('main.row.gianhap2');
    $xtpl->parse('main.row');
  }
  $xtpl->assign('navbar', navbar($filter['page'], $total, $gioihan, 'onclick="timkiem({p})"'));
  $xtpl->parse('main');
  return $xtpl->text();
}

function danhsachthuchi() {
  global $db, $nv_Request;
  $xtpl = new XTemplate('danhsach.tpl', UPATH . '/cash/');

  $gioihan = 10;
  $filter = $nv_Request->get_array('filter', 'post');
  $query = array();
  if (empty($filter['page'])) $filter['page'] = 1;
  if (empty($filter['batdau'])) $filter['batdau'] = date('d/m/Y');
  if (empty($filter['ketthuc'])) $filter['ketthuc'] = date('d/m/Y');
  if (isset($filter['loaitien']) && $filter['loaitien'] < 3) $query []= "b.loai = $filter[loaitien]";
  $filter['batdau'] = datetotime($filter['batdau']);
  $filter['ketthuc'] = datetotime($filter['ketthuc']) + 60 * 60 * 24 - 1;

  $query []= "(a.thoigian between $filter[batdau] and $filter[ketthuc])";
  $query = implode(' and ', $query);

  $sql = "select count(b.id) as count from pos_thuchi a inner join pos_chitietthuchi b on a.id = b.idthuchi where $query";
  $total = $db->fetch($sql)['count']; 

  $sql = "select a.mathuchi, a.idloaithuchi, a.idkhachhang, a.thoigian, b.loai, b.sotien from pos_thuchi a inner join pos_chitietthuchi b on a.id = b.idthuchi where $query order by b.id desc limit $gioihan offset ". ($filter['page'] - 1) * $gioihan;
  $list = $db->all($sql);

  $loaithanhtoan = [0 => 'Tiền mặt', 'Chuyển khoản', 'Điểm'];

  foreach ($list as $row) {
    $sql = "select * from pos_loaithuchi where id = $row[idloaithuchi]";
    $loaithuchi = $db->fetch($sql);

    $sql = "select * from pos_khachhang where id = $row[idkhachhang]";
    if (empty($doituong = $db->fetch($sql))) $doituong = ['tenkhach' => ''];

    $xtpl->assign('id', $row['id']);
    $xtpl->assign('loaithuchi', $loaithuchi['ten']);
    $xtpl->assign('loaithanhtoan', $loaithanhtoan[$row['loai']]);
    $xtpl->assign('doituong', $doituong['tenkhach']);
    $xtpl->assign('mathuchi', $row['mathuchi']);
    $xtpl->assign('thoigian', date('d/m/Y H:i'));
    $xtpl->assign('sotien', number_format($row['sotien']));
    $xtpl->parse('main.row');
  }
  $xtpl->assign('navbar', navbar($filter['page'], $total, $gioihan, 'onclick="timkiem({p})"'));
  $xtpl->parse('main');
  return $xtpl->text();
}

function danhsachnhaphang() {
  global $db, $nv_Request;

  $gioihan = 10;
  $filter = $nv_Request->get_array('filter', 'post');
  if (empty($filter['page'])) $filter['page'] = 1;
  if (empty($filter['batdau'])) $filter['batdau'] = strtotime(date('Y/m/1'));
  else $filter['batdau'] = datetotime($filter['batdau']);
  if (empty($filter['ketthuc'])) $filter['ketthuc'] = strtotime(date('Y/m/t')) + 60 * 60 * 24 - 1;
  else $filter['ketthuc'] = datetotime($filter['ketthuc']) + 60 * 60 * 24 - 1;

  $sql = "select * from pos_nhaphang where (thoigian between $filter[batdau] and $filter[ketthuc]) and trangthai = 1 and thanhtoan = 1 order by thoigian desc limit $gioihan offset ". ($filter['page'] - 1) * $gioihan;
  $danhsach = $db->all($sql);

  $quyensua = quyennhanvien(63);
  $quyenxoa = quyennhanvien(64);

  $lf = ($filter['page'] - 1) * $gioihan;
  $lt = $lf + $gioihan;
  $trangthai = array(0 => 'Phiếu tạm', 'Hoàn thành');
  $thanhtoan = array(0 => 'Chưa thanh toán', 'Đã thanh toán');
  $xtpl = new XTemplate('danhsach.tpl', UPATH . '/purchase/');
  $count = 0;
  foreach ($danhsach as $i => $row) {
    $sql = "select * from pos_chitietnhaphang a inner join pos_hanghoa b on a.idhang = b.id and idnhaphang = $row[id] and (b.tenhang like '%$filter[tukhoa]%' or b.mahang like '%$filter[tukhoa]%')";
    if (!empty($db->fetch($sql))) {
      $count ++;
      if ($i >= $lf && $i < $lt) {
        $thoigian = date('d/m/Y', $row['thoigian']);
        $sql = "select * from pos_nguoncung where id = $row[idnguoncung]";
        $nguoncung = $db->fetch($sql);
        $xtpl->assign('id', $row['id']);
        $xtpl->assign('manhap', $row['manhap']);
        $xtpl->assign('thoigian', $thoigian);
        $xtpl->assign('nguoncung', $nguoncung['ten']);
        $xtpl->assign('tongtien', number_format($row['tongtien']));
        $xtpl->assign('trangthai', $trangthai[$row['trangthai']]);
        if ($quyensua) $xtpl->parse('main.row.sua');
        if ($quyenxoa) $xtpl->parse('main.row.xoa');
        $xtpl->parse('main.row');
      }
    }
  }
  if (!$count) $xtpl->parse('main.khongco');
  $xtpl->assign('navbar', navbar($filter['page'], $count, $gioihan, 'onclick="timkiem({p})"'));
  
  $sql = "select * from pos_nhaphang where (thoigian < $filter[batdau] and trangthai = 0 and thanhtoan = 1) or thanhtoan = 0 order by thoigian desc";
  $danhsach = $db->all($sql);
  $count = 0;

  foreach ($danhsach as $i => $row) {
    $count ++;
    $thoigian = date('d/m/Y', $row['thoigian']);
    $sql = "select * from pos_nguoncung where id = $row[idnguoncung]";
    $nguoncung = $db->fetch($sql);
    $xtpl->assign('id', $row['id']);
    $xtpl->assign('manhap', $row['manhap']);
    $xtpl->assign('thoigian', $thoigian);
    $xtpl->assign('nguoncung', $nguoncung['ten']);
    $xtpl->assign('tongtien', number_format($row['tongtien']));
    $xtpl->assign('thanhtoan', $thanhtoan[$row['thanhtoan']]);
    $xtpl->assign('trangthai', $trangthai[$row['trangthai']]);
    
    if (!$row['thanhtoan']) $xtpl->assign('classthanhtoan', 'pw-bad');
    else $xtpl->assign('classthanhtoan', ''); 
    if (!$row['trangthai']) $xtpl->assign('classtrangthai', 'pw-bad');
    else $xtpl->assign('classtrangthai', ''); 
    $xtpl->parse('main.phieutam.row');
  }
  if ($count) $xtpl->parse('main.phieutam');
  
  $xtpl->parse('main');
  return $xtpl->text();
}

function danhsachnguoncung() {
  global $db, $nv_Request;

  $gioihan = 10;
  $filter = $nv_Request->get_array('filter', 'post');
  if (empty($filter['page'])) $filter['page'] = 1;
  if (empty($filter['tukhoa'])) $filter['tukhoa'] = '';

  $sql = "select count(id) as count from pos_nguoncung where kichhoat = 1 and (manguoncung like '%$filter[tukhoa]%' or ten like '%$filter[tukhoa]%' or diachi like '%$filter[tukhoa]%' or dienthoai like '%$filter[tukhoa]%')";
  $count = $db->fetch($sql)['count']; 

  $sql = "select * from pos_nguoncung where  kichhoat = 1 and (manguoncung like '%$filter[tukhoa]%' or ten like '%$filter[tukhoa]%' or diachi like '%$filter[tukhoa]%' or dienthoai like '%$filter[tukhoa]%') order by id desc limit $gioihan offset ". ($filter['page'] - 1) * $gioihan;
  $danhsach = $db->all($sql);

  $xtpl = new XTemplate('danhsach.tpl', UPATH . '/source/');
  foreach ($danhsach as $i => $row) {
    $xtpl->assign('id', $row['id']);
    $xtpl->assign('ten', $row['ten']);
    $xtpl->assign('manguon', $row['manguoncung']);
    $xtpl->assign('dienthoai', rutgondienthoai($row['dienthoai'], 455));
    $xtpl->assign('diachi', $row['diachi']);
    if (quyennhanvien(453)) $xtpl->parse('main.row.sua');
    if (quyennhanvien(454)) $xtpl->parse('main.row.xoa');
    $xtpl->parse('main.row');
  }
  $xtpl->assign('navbar', navbar($filter['page'], $count, $gioihan, 'onclick="timkiem({p})"'));
  $xtpl->parse('main');
  return $xtpl->text();
}

function danhsachkhach() {
  global $db, $nv_Request;

  $gioihan = 10;
  $filter = $nv_Request->get_array('filter', 'post');
  if (empty($filter['page'])) $filter['page'] = 1;
  if (empty($filter['tukhoa'])) $filter['tukhoa'] = '';

  $xtratienno = khoangsosanh('tienno', $filter['khachnotu'], $filter['khachnoden']);
  if (!empty($xtratienno)) $xtra = " and $xtratienno";
  else $xtra = '';

  $sql = "select * from pos_khachhang where kichhoat = 1 and (tenkhach like '%$filter[tukhoa]%' or diachi like '%$filter[tukhoa]%' or dienthoai like '%$filter[tukhoa]%' or makhach like '%$filter[tukhoa]%') $xtra order by id desc";
  $danhsachtam = $db->all($sql);
  $danhsach = [];

  $xtrathoigian = khoangsosanh('thoigian', chuyenthoigian($filter['thoigiantu']), chuyenthoigian($filter['thoigianden']));
  if (!empty($xtrathoigian)) $xtra = " and $xtrathoigian";
  else $xtra = '';

  $thutu = 0;
  if (!empty($filter['khachmuatu'])) $thutu += 1;
  if (!empty($filter['khachmuaden'])) $thutu += 2;

  foreach ($danhsachtam as $khachhang) {
    $sql = "select sum(thanhtoan) as tongtien from pos_hoadon where idkhach = $khachhang[id] $xtra";
    $tongtien = $db->fetch($sql);
    if (empty($tongtien)) $khachhang['tongtien'] = 0;
    else $khachhang['tongtien'] = $tongtien['tongtien'];
    switch ($thutu) {
      case 0:
        $danhsach []= $khachhang;
        break;
      case 1:
        if ($khachhang['tongtien'] > $filter['khachmuatu']) $danhsach []= $khachhang;
        break;
      case 2:
        if ($khachhang['tongtien'] < $filter['khachmuaden']) $danhsach []= $khachhang;
        break;
      case 3:
        if ($khachhang['tongtien'] < $filter['khachmuaden'] && $khachhang['tongtien'] > $filter['khachmuatu']) $danhsach []= $khachhang;
        break;
    }
  }

  $quyensua = quyennhanvien(413);
  $quyenxoa = quyennhanvien(414);
  $quyendienthoai = quyennhanvien(415);

  $xtpl = new XTemplate('danhsach.tpl', UPATH . '/customer/');
  $chaydencuoi = $filter['page'] * $gioihan;
  $count = count($danhsach);
  $demchay = 0;
  for ($i = ($filter['page'] - 1) * $gioihan; $i < $chaydencuoi; $i++) { 
    $row = $danhsach[$i];
    if (empty($row)) continue;
    $demchay ++;
    $xtpl->assign('id', $row['id']);
    $xtpl->assign('makhach', $row['makhach']);
    $xtpl->assign('ten', $row['tenkhach']);
    $xtpl->assign('dienthoai', rutgondienthoai($row['dienthoai'], 415));
    $xtpl->assign('muahang', number_format($row['tongtien']));
    $xtpl->assign('tienno', number_format($row['tienno']));
    if ($quyensua) $xtpl->parse('main.row.sua');
    if ($quyenxoa) $xtpl->parse('main.row.xoa');
    $xtpl->parse('main.row');
  }
  if (empty($demchay)) $xtpl->parse('main.khongkhach');
  $xtpl->assign('navbar', navbar($filter['page'], $count, $gioihan, 'onclick="timkiem({p})"'));
  $xtpl->parse('main');
  return $xtpl->text();
}

function rutgondienthoai($dienthoai, $quyen) {
  // nếu không có quyền điền thoại thì rút gọn
  if (!quyennhanvien($quyen)) {
    // nếu < 6 rút được 1 số đầu cuối
    // còn lại rút được 2 số đầu cuối
    $chieudai = strlen($dienthoai);
    $dienthoai = substr($dienthoai, 0, 1) . '[..]' . substr($dienthoai, $chieudai - 3);
    // if ($chieudai <= 6) 
    // else $dienthoai = substr($dienthoai, 0, 2) . '[..]' . substr($dienthoai, $chieudai - 2);
  }
  return $dienthoai;
}

function danhsachhoadon() {
  global $db, $nv_Request;

  $gioihan = 10;
  $filter = $nv_Request->get_array('filter', 'post');
  $xtra = array();
  if (empty($filter['page'])) $filter['page'] = 1;
  if (!empty($filter['hoadon'])) $xtra []= "a.mahoadon like '%$filter[hoadon]%'";
  if (!empty($filter['nguoiban'])) $xtra []= "idnguoiban = $filter[nguoiban]";
  if (!empty($filter['nguoiratoa'])) $xtra []= "idnguoiratoa = $filter[nguoiratoa]";
  if (!empty($filter['ghichu'])) $xtra []= "ghichu like '%$filter[ghichu]%'";
  if (empty($filter['thoigiandau'])) $filter['thoigiandau'] = date('01/m/Y');
  if (empty($filter['thoigiancuoi'])) $filter['thoigiancuoi'] = date('t/m/Y');

  $filter['thoigiandau'] = datetotime($filter['thoigiandau']);
  $filter['thoigiancuoi'] = datetotime($filter['thoigiancuoi']) + 60 * 60 * 24 - 1;
  $xtra []= "(thoigian between $filter[thoigiandau] and $filter[thoigiancuoi])";
  $xtra = "where ". implode(' and ', $xtra);

  if (!empty($filter['hanghoa'])) {
    $sql = "select a.id from pos_hoadon a inner join pos_chitiethoadon b on a.id = b.idhoadon inner join pos_hanghoa c on b.idhang = c.id where (c.mahang like '%$filter[hanghoa]%' or c.tenhang like '%$filter[hanghoa]%')";
    $danhsachid = $db->arr($sql, 'id');
    $xtra .= " and id in (". implode(', ', $danhsachid) .")";
  }

  $sql = "select count(id) as count from pos_hoadon $xtra order by thoigian desc";
  $count = $db->fetch($sql)['count']; 

  $xtpl = new XTemplate('danhsach.tpl', UPATH . '/bill/');
  $sql = "select * from pos_hoadon $xtra order by thoigian desc limit $gioihan offset ". ($filter['page'] - 1) * $gioihan;
  // die($sql);
  $danhsach = $db->all($sql);

  foreach ($danhsach as $i => $row) {
    if (!$row['idkhach']) $khachhang = ['ten' => 'Khách lẻ'];
    else {
      $sql = "select * from pos_khachhang where id = $row[idkhach]";
      $khachhang = $db->fetch($sql);
    }

    $xtpl->assign('id', $row['id']);
    $xtpl->assign('mahoadon', $row['mahoadon']);
    $xtpl->assign('thoigian', date('d/m/Y H:i', $row['thoigian']));
    $xtpl->assign('khachhang', $khachhang['tenkhach']);
    $xtpl->assign('tongtien', number_format($row['tongtien']));
    $xtpl->assign('thanhtien', number_format($row['thanhtien']));
    $xtpl->assign('giamgiatien', number_format($row['giamgiatien']));
    if (!empty($row['giamgiaphantram'])) $xtpl->assign('giamgiaphantram', "+ $row[giamgiaphantram]%");
    else $xtpl->assign('giamgiaphantram', '');

    if ($row['giamgiaphantram'] > 0 || $row['giamgiatien'] > 0) $xtpl->assign('cogiamgia', 'pw-giamgia');
    else $xtpl->assign('cogiamgia', '');
    // $giamgia = $row['tongtien'] - $row['thanhtien'];
    // $xtpl->assign('giamgia', $giamgia);
    if ($row['thanhtien'] != $row['thanhtoan']) $xtpl->assign('classdatra', 'style="color: red;"');
    else $xtpl->assign('classdatra', '');
    $xtpl->assign('datra', number_format($row['thanhtoan']));
    $xtpl->parse('main.row');
  }
  $xtpl->assign('navbar', navbar($filter['page'], $count, $gioihan, 'onclick="timkiem({p})"'));
  $xtpl->parse('main');
  return $xtpl->text();
}

function thongke() {
  global $db, $nv_Request;
  $xtpl = new XTemplate('tongquan.tpl', UPATH . '/statistic/');

  $batdau = $nv_Request->get_string('batdau', 'post');
  $ketthuc = $nv_Request->get_string('ketthuc', 'post');
  if (empty($batdau)) $batdau = date('d/m/Y');
  if (empty($ketthuc)) $ketthuc = date('d/m/Y');
  $batdau = datetotime($batdau);
  $ketthuc = datetotime($ketthuc) + 60 * 60 * 24 - 1;
  $dulieu = [
    'tongthu' => 0,
    'tongchi' => 0,
    'doanhthu' => 0,
    'loinhuan' => 0,
    'nhaphang' => 0,
    'loinhuannhaphang' => 0,
    'tienmat' => 0,
    'tienmat2' => 0,
    'chuyenkhoan' => 0,
    'diem' => 0,
  ];
  $arr = [0 => 'tienmat', 'chuyenkhoan', 'diem'];

  $sql = "select b.* from pos_thuchi a inner join pos_chitietthuchi b on a.id = b.idthuchi where (a.thoigian between $batdau and $ketthuc)";
  $danhsach = $db->all($sql);
  foreach ($danhsach as $thuchi) {
    if ($thuchi['sotien'] > 0) {
      $dulieu['tongthu'] += $thuchi['sotien'];
      $dulieu[$arr[$thuchi['loai']]] += $thuchi['sotien'];
    }
    else $dulieu['tongchi'] += $thuchi['sotien'];
  }

  $dulieu['tongchi'] = $dulieu['tongchi'] * -1;
  $dulieu['doanhthu'] = $dulieu['tongthu'] - $dulieu['tongchi'];
  $dulieu['tienmat'] -= $dulieu['tongchi'];
  $dulieu['tienmat2'] = $dulieu['tienmat'] - $dulieu['diem'] - $dulieu['chuyenkhoan'];

  $sql = "select b.* from pos_thuchi a inner join pos_machitietthuchi b on a.id = b.idthuchi where (a.thoigian between $batdau and $ketthuc)";
  $danhsach = $db->all($sql);
  foreach ($danhsach as $chitiet) {
    $dulieu['loinhuan'] += $chitiet['loinhuan'];
  }

  // comment đoạn tính lợi nhuận theo hóa đơn
  // $sql = "select b.* from pos_hoadon a inner join pos_chitiethoadon b on a.id = b.idhoadon where a.thoigian between $batdau and $ketthuc";
  // $danhsach = $db->all($sql);

  // foreach ($danhsach as $hoadon) {
  //   $dulieu['loinhuan'] += ($hoadon['giaban'] - $hoadon['gianhap']) * $hoadon['soluongthuc'];
  // }

  // lợi nhuận nhập hàng
  $sql = "select * from pos_nhaphang where (thoigian between $batdau and $ketthuc) and thanhtoan = 1";
  $danhsach = $db->all($sql);

  foreach ($danhsach as $nhaphang) {
    $dulieu['nhaphang'] += $nhaphang['tongtien'];
  }

  $dulieu['loinhuannhaphang'] = $dulieu['loinhuan'] - $dulieu['nhaphang'];

  foreach ($dulieu as $ten => $giatri) {
    $xtpl->assign($ten, number_format($giatri));
  }

  $xtpl->parse('main');
  return $xtpl->text();
}

function tuychonnhanvien() {
  global $db, $nv_Request;

  $xtpl = new XTemplate('option.tpl', UPATH);
  $sql = "select * from pet_users where active = 1 order by userid asc";
  $danhsach = $db->all($sql);

  foreach ($danhsach as $nhanvien) {
    $xtpl->assign('name', $nhanvien['first_name']);
    $xtpl->assign('value', $nhanvien['userid']);
    $xtpl->parse('main');
  }
  return $xtpl->text();
}

function danhsachnhanvien() {
  global $db, $nv_Request;

  $xtpl = new XTemplate('danhsach.tpl', UPATH . '/setting/');
  $sql = "select * from pet_users where active = 1 order by userid desc";
  $danhsach = $db->all($sql);
  $thutu = 0;

  foreach ($danhsach as $nhanvien) {
    $xtpl->assign('thutu', ++$thutu);
    $xtpl->assign('userid', $nhanvien['userid']);
    $xtpl->assign('tennhanvien', $nhanvien['first_name']);
    $xtpl->assign('taikhoan', $nhanvien['username']);
    $xtpl->parse('main.nhanvien');
  }
  if (empty($thutu)) $xtpl->parse('main.khongco');
  $xtpl->parse('main');
  return $xtpl->text();
}

function navbar($page, $total, $gioihan, $surfix) {
  $xtpl = new XTemplate('navbar.tpl', UPATH);
  $pagelength = floor($total / $gioihan) + (fmod($total, $gioihan) ? 1 : 0);
  for ($i = 1; $i <= $pagelength; $i++) {
    $s = str_replace('{p}', $i, $surfix);
    if ($page == $i) $xtpl->assign('active', 'class="active"');
    else $xtpl->assign('active', '');
    $xtpl->assign('surfix', $s);
    $xtpl->assign('page', $i);
    $xtpl->parse('main.row');
  }
  $xtpl->parse('main');
  return $xtpl->text();
}
