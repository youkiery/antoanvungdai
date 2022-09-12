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

// item, hanghoa
function xoahoadon() {
  global $db, $nv_Request, $resp;

  $id = $nv_Request->get_string('id', 'post');
  // cập nhật số lượng hàng
  $sql = "select * from pos_chitiethoadon where idhoadon = $id";
  $chitiethoadon = $db->all($sql);

  foreach ($chitiethoadon as $key => $chitiet) {
    $sql = "update pos_hanghoa set soluong = soluong + $chitiet[soluongthuc] where id = $chitiet[idhang]";
    $db->query($sql);
  }
  // xóa chi tiết hóa đơn
  $sql = "delete from pos_chitiethoadon where idhoadon = $id";
  $db->query($sql);
  // xóa hóa đơn
  $sql = "delete from pos_hoadon where id = $id";
  $db->query($sql);

  $resp['status'] = 1;
  $resp['messenger'] = "Đã xóa hóa đơn";
  $resp['danhsach'] = danhsachhoadon();
}

function inhoadon() {
  global $db, $nv_Request, $resp;

  $xtpl = new XTemplate('inhoadon.tpl', UPATH);
  $id = $nv_Request->get_string('id', 'post');

  $sql = "select * from pos_hoadon where id = $id";
  $hoadon = $db->fetch($sql);

  $sql = "select first_name from pet_users where userid = $hoadon[idnguoiban]";
  $nguoiban = $db->fetch($sql);

  if (!$row['idkhach']) $khachhang = ['ten' => 'Khách lẻ', 'diachi' => '', 'dienthoai' => ''];
  else {
    $sql = "select * from pos_khachhang where id = $row[idkhach]";
    $khachhang = $db->fetch($sql);
  }

  $xtpl->assign('mahoadon', $hoadon['mahoadon']);
  $xtpl->assign('nguoiban', $nguoiban['first_name']);
  $xtpl->assign('khachhang', $khachhang['ten']);
  $xtpl->assign('diachi', $khachhang['diachi']);
  $xtpl->assign('dienthoai', $khachhang['dienthoai']);
  $xtpl->assign('thoigian', date('d/m/Y H:i:s'));

  $sql = "select * from pos_chitiethoadon where idhoadon = $id";
  $danhsachchitiet = $db->all($sql);

  foreach ($danhsachchitiet as $chitiet) {
    $sql = "select * from pos_hanghoa where id = $chitiet[idhang]";
    $hanghoa = $db->fetch($sql);

    $xtpl->assign('tenhang', $hanghoa['tenhang']);
    if ($chitiet['giaban'] != $chitiet['dongia']) $xtpl->assign('dongia', number_format($chitiet['dongia']));
    else $xtpl->assign('dongia', '');
    $xtpl->assign('giaban', number_format($chitiet['giaban']));
    $xtpl->assign('soluong', number_format($chitiet['soluong']));
    $xtpl->assign('thanhtien', number_format($chitiet['thanhtien']));
  }

  if ($hoadon['giamgia']) {
    $xtpl->assign('tongtien', number_format($chitiet['soluong']));
    $xtpl->assign('giamgia', number_format($chitiet['giamgia']));
    $xtpl->parse('main.giamgia');
  }
  $xtpl->assign('thanhtien', number_format($chitiet['thanhtien']));
  $xtpl->parse('main.row');
  $xtpl->parse('main');

  $resp['status'] = 1;
  $resp['html'] = $xtpl->text();
}

function taihoadon() {
  global $db, $resp, $nv_Request;

  $resp['status'] = 1;
  $resp['danhsach'] = danhsachhoadon();
}

function chitiethoadon() {
  global $db, $resp, $nv_Request;

  $id = $nv_Request->get_int('id', 'post');
  $xtpl = new XTemplate('chitiet.tpl', UPATH . '/bill/');

  $sql = "select * from pos_hoadon where id = $id";
  $hoadon = $db->fetch($sql);

  if (!$hoadon['idkhach']) $khachhang = ['ten' => 'Khách lẻ'];
  else {
    $sql = "select * from pos_khachhang where id = $hoadon[idkhach]";
    $khachhang = $db->fetch($sql);
  }

  $sql = "select * from pos_chitiethoadon where idhoadon = $id";
  $danhsach = $db->all($sql);

  $soluong = 0;
  foreach ($danhsach as $chitiet) {
    $soluong += $chitiet['soluong'];
    $sql = "select * from pos_hanghoa where id = $chitiet[idhang]";
    $hanghoa = $db->fetch($sql);
    $xtpl->assign('mahang', $hanghoa['mahang']);
    $xtpl->assign('tenhang', $hanghoa['tenhang']);
    $xtpl->assign('soluong', number_format($chitiet['soluong']));
    $xtpl->assign('dongia', number_format($chitiet['dongia']));
    $xtpl->assign('giamgia', number_format($chitiet['giamgia']));
    $xtpl->assign('giaban', number_format($chitiet['giaban']));
    $xtpl->assign('thanhtien', number_format($chitiet['thanhtien']));

    $xtpl->parse('main.row');
  }

  $sql = "select first_name from pet_users where userid = $hoadon[idnguoiban]";
  $banhang = $db->fetch($sql);
  $sql = "select first_name from pet_users where userid = $hoadon[idnguoiratoa]";
  $ratoa = $db->fetch($sql);

  $xtpl->assign('id', $id);
  $xtpl->assign('mahoadon', $hoadon['mahoadon']);
  $xtpl->assign('ghichu', $hoadon['ghichu']);
  $xtpl->assign('thoigian', date('d/m/Y H:i'));
  $xtpl->assign('khachhang', $khachhang['ten']);
  $xtpl->assign('ratoa', $ratoa['first_name']);
  $xtpl->assign('banhang', $banhang['first_name']);
  $xtpl->assign('sohang', number_format($soluong));
  $xtpl->assign('tongtien', number_format($hoadon['tongtien']));
  $xtpl->assign('giamgia', number_format($hoadon['giamgia']));
  $xtpl->assign('thanhtien', number_format($hoadon['thanhtien']));
  $xtpl->assign('datra', number_format($hoadon['thanhtoan']));
  $xtpl->assign('ghichu', '');

  $xtpl->parse('main');

  $resp['status'] = 1;
  $resp['html'] = $xtpl->text();
}

function thongtinhang() {
  global $db, $resp, $nv_Request;

  $id = $nv_Request->get_int('id', 'post');
  $sql = "select * from pos_hanghoa where id = $id";
  $hang = $db->fetch($sql);

  $hang['hinhanh'] = explode(',', $hang['hinhanh']);
  if (count($hang['hinhanh']) == 1 && empty($hang['hinhanh'][0])) $hang['hinhanh'] = array('');
  $hang['gianhap'] = number_format($hang['gianhap']);
  $hang['giaban'] = number_format($hang['giaban']);

  $resp['status'] = 1;
  $resp['data'] = $hang;
}

function themhang() {
  global $db, $resp, $nv_Request;

  $data = $nv_Request->get_array('data', 'post');
  $vitri = $nv_Request->get_string('vitri', 'post');
  // kiểm tra xem có mã hàng chưa, nếu chưa thì lấy id hàng làm mã hàng
  // nếu rồi, kiểm tra xem mã có trùng không
  if (empty($data['mahang'])) {
    $sql = "select id from pos_hanghoa order by id desc limit 1";
    $hang = $db->fetch($sql);
    $mahang = fillzero(($hang['id'] ? $hang['id'] : 0) + 1);
    $data['mahang'] = "SP$mahang";
  }
  else {
    $sql = "select mahang from pos_hanghoa where mahang = '$data[mahang]'";
    if (!empty($db->fetch($sql))) {
      $resp['messenger'] = 'Mã hàng đã tồn tại';
      return 0;
    }
  }
  // bỏ dấu cách giá bán
  $data['giaban'] = str_replace(',', '', $data['giaban']);
  $data['gianhap'] = str_replace(',', '', $data['gianhap']);
  // parseimage
  $data['hinhanh'] = parseimage($data['hinhanh']);
  // thêm 
  $sql = "insert into pos_hanghoa (mahang, tenhang, loaihang, giaban, gianhap, soluong, hinhanh, gioithieu, donvi) values('$data[mahang]', '$data[tenhang]', $data[loaihang], $data[giaban], $data[gianhap], 0, '$data[hinhanh]', '$data[gioithieu]', '$data[donvi]')";
  $id = $db->insertid($sql);
  $resp['status'] = 1;
  $data['dongia'] = $data['gianhap'];
  $data['id'] = $id;
  if ($vitri == 'nhaphang') $resp['data'] = $data;
  else $resp['danhsach'] = danhsachhang();
  $resp['messenger'] = 'Đã thêm hàng hóa';
}

function taihang() {
  global $db, $resp, $nv_Request;

  $resp['status'] = 1;
  $resp['danhsach'] = danhsachhang();
}

function tainhap() {
  global $db, $resp, $nv_Request;

  $resp['status'] = 1;
  $resp['danhsach'] = danhsachnhaphang();
}

function xoahang() {
  global $db, $resp, $nv_Request;

  $id = $nv_Request->get_int('id', 'post');

  $sql = "update pos_hanghoa set kichhoat = 0 where id = $id";
  $db->query($sql);
  $resp['status'] = 1;
  $resp['danhsach'] = danhsachhang();
  $resp['messenger'] = 'Đã xóa hàng hóa';
}

function suahang() {
  global $db, $resp, $nv_Request;

  $id = $nv_Request->get_int('id', 'post');
  $data = $nv_Request->get_array('data', 'post');
  // kiểm tra xem có trùng mã hàng khác không
  $sql = "select id from pos_hanghoa where mahang = '$data[mahang]' and id <> $id order by id desc limit 1";
  if (!empty($hang = $db->fetch($sql))) {
    $resp['messenger'] = 'Mã hàng đã tồn tại';
    return 0;
  }

  // bỏ dấu cách giá bán
  $data['giaban'] = str_replace(',', '', $data['giaban']);
  $data['gianhap'] = str_replace(',', '', $data['gianhap']);
  // parseimage
  $data['hinhanh'] = parseimage($data['hinhanh']);
  // cập nhật 
  $sql = "update pos_hanghoa set mahang = '$data[mahang]', tenhang = '$data[tenhang]', loaihang = $data[loaihang], giaban = $data[giaban], gianhap = $data[gianhap], hinhanh = '$data[hinhanh]', gioithieu = '$data[gioithieu]', donvi = '$data[donvi]' where id = $id";
  $db->query($sql);
  $resp['status'] = 1;
  $resp['danhsach'] = danhsachhang();
  $resp['messenger'] = 'Đã cập nhật hàng hóa';
}

// user, nguoidung

function signin() {
  global $db, $resp, $nv_Request, $crypt;

  $username = $nv_Request->get_string('username', 'post');
  $password = $nv_Request->get_string('password', 'post');

  $sql = "select * from pet_users where username = '$username'";
  if (empty($user = $db->fetch($sql))) {
    $resp['msg'] = 'Tài khoản không tồn tại';
  }
  else if (!$crypt->validate_password($password, $user['password'])) {
    $resp['msg'] = 'Sai mật khẩu';
  }
  else {
    login($user['userid']);
    $resp['status'] = 1;
  }
}

// purchase, nhaphang

function timnhaphang() {
  global $db, $resp, $nv_Request;

  $tukhoa = $nv_Request->get_string('tukhoa', 'get/post', '');
  $sql = "select id, mahang, tenhang, donvi, hinhanh, gianhap as dongia from pos_hanghoa where (tenhang like '%$tukhoa%' or mahang like '%$tukhoa%') and kichhoat = 1 order by id desc limit 10";
  $danhsach = $db->all($sql);

  foreach ($danhsach as $thutu => $hanghoa) {
    $hinhanh = parseimage($hanghoa['hinhanh']);
    if (count($hinhanh) == 1 && empty($hinhanh[0])) $hinhanh = array(0 => '/assets/images/noimage.png');
    $danhsach[$thutu]['hinhanh'] = $hinhanh[0];
  }

  $resp['status'] = 1;
  $resp['danhsach'] = $danhsach;
}

function themnhaphang() {
  global $db, $resp, $nv_Request;

  $userid = checkuserid();
  $thoigian = time();
  $id = $nv_Request->get_string('id', 'post');
  $idnguoncung = $nv_Request->get_string('idnguoncung', 'post');
  $trangthai = $nv_Request->get_string('trangthai', 'post', 0);
  $danhsach = $nv_Request->get_array('danhsach', 'post');

  if (empty($id)) {
    $sql = "select id from pos_nhaphang order by id desc limit 1";
    $nhaphang = $db->fetch($sql);
    $manhap = "NH". fillzero($nhaphang['id'] + 1);
    
    $sql = "insert into pos_nhaphang (manhap, tongtien, thoigian, idnguoncung, trangthai, idnguoitao) values('$manhap', 0, $thoigian, $idnguoncung, $trangthai, $userid)";
    $id = $db->insertid($sql);
  }
  else {
    $sql = "update pos_nhaphang set thoigian = $thoigian, idnguoncung = $idnguoncung, trangthai = $trangthai, idnguoitao = $userid";
    $db->query($sql);

    $sql = "delete from pos_chitietnhaphang where idnhaphang = $id";
    $db->query($sql);
  }

  $thanhtien = 0;
  foreach ($danhsach as $hanghoa) {
    $sql = "insert into pos_chitietnhaphang (idnhaphang, idhang, gianhap, soluong) values($id, $hanghoa[id], $hanghoa[dongia], $hanghoa[soluong])";
    $db->query($sql);
    $thanhtien += $hanghoa['dongia'] * $hanghoa['soluong'];

    if ($trangthai == 1) {
      $sql = "update pos_hanghoa set soluong = soluong + $hanghoa[soluong], gianhap = $hanghoa[dongia] where id = $hanghoa[id]";
      $db->query($sql);
    }
  }

  $sql = "update pos_nhaphang set tongtien = $thanhtien where id = $id";
  $db->query($sql);

  $resp['status'] = 1;
  $resp['danhsach'] = danhsachnhaphang();
  $resp['messenger'] = 'Đã thêm phiếu nhập';
}

function xoanhap() {
  global $db, $resp, $nv_Request;

  $id = $nv_Request->get_string('id', 'post');

  $sql = "select * from pos_nhaphang where id = $id";
  $nhaphang = $db->fetch($sql);

  if ($nhaphang['trangthai'] == 1) {
    $sql = "select * from pos_chitietnhaphang where idnhaphang = $id";
    $danhsachchitiet = $db->all($sql);

    foreach ($danhsachchitiet as $chitiet) {
      $sql = "update pos_hanghoa set soluong = soluong - $chitiet[soluong] where id = $chitiet[idhang]";
      $db->query($sql);
    }
  }

  $sql = "delete from pos_chitietnhaphang where idnhaphang = $id";
  $db->query($sql);
  $sql = "delete from pos_nhaphang where id = $id";
  $db->query($sql);

  $resp['status'] = 1;
  $resp['danhsach'] = danhsachnhaphang();
  $resp['messenger'] = 'Đã xóa phiếu nhập';
}

function thongtinnhap() {
  global $db, $resp, $nv_Request;

  $id = $nv_Request->get_string('id', 'post');

  $sql = "select * from pos_nhaphang where id = $id";
  $nhaphang = $db->fetch($sql);

  $sql = "select b.id, b.mahang, b.tenhang, b.hinhanh, a.gianhap as dongia, a.soluong from pos_chitietnhaphang a inner join pos_hanghoa b on a.idhang = b.id where a.idnhaphang = $id";
  $danhsach = $db->all($sql);

  foreach ($danhsach as $thutu => $hanghoa) {
    $hinhanh = parseimage($hanghoa['hinhanh']);
    if (count($hinhanh) == 1 && empty($hinhanh[0])) $hinhanh = array(0 => '/assets/images/noimage.png');
    $danhsach[$thutu]['hinhanh'] = $hinhanh[0];
    $danhsach[$thutu]['thanhtien'] = $hanghoa['soluong'] * $hanghoa['dongia'];
  }

  $sql = "select * from pos_nguoncung where id = $nhaphang[idnguoncung]";
  $nguoncung = $db->fetch($sql);

  $resp['status'] = 1;
  $resp['nguoncung'] = $nguoncung['id'];
  $resp['danhsach'] = $danhsach;
}

// nguon cung, source

function themnguon() {
  global $db, $resp, $nv_Request;

  $data = $nv_Request->get_array('data', 'post');
  $vitri = $nv_Request->get_string('vitri', 'post');
  $id = $nv_Request->get_string('id', 'post');

  if (empty($id)) {
    $sql = "insert into pos_nguoncung (ten, dienthoai, diachi) values('$data[ten]', '$data[dienthoai]', '$data[diachi]')";
    $id = $db->insert_id($sql);
    $resp['messenger'] = 'Đã thêm nguồn cung';
  }
  else {
    $sql = "update pos_nguoncung set ten = '$data[ten]', dienthoai = '$data[dienthoai]', diachi = '$data[diachi]' where id = $id";
    $resp['messenger'] = 'Đã cập nhật nguồn cung';
    $db->query($sql);
  }

  $resp['status'] = 1;
  if ($vitri == 'nhaphang') {
    $sql = "select * from pos_nguoncung where kichhoat = 1 order by ten asc";
    $nguoncung = $db->all($sql);
    $resp['nguoncung'] = option($nguoncung, 'ten', 'id');
    $resp['idnguoncung'] = $id;
  }
  else {
    $resp['danhsach'] = danhsachnguoncung();
  }
}

function xoanguon() {
  global $db, $resp, $nv_Request;
  $id = $nv_Request->get_string('id', 'post');

  $sql = "update pos_nguoncung set kichhoat = 0 where id = $id";
  $db->query($sql);
  $resp['status'] = 1;
  $resp['messenger'] = 'Đã xóa nguồn cung';
  $resp['danhsach'] = danhsachnguoncung();
}

function tainguon() {
  global $db, $resp, $nv_Request;

  $resp['status'] = 1;
  $resp['danhsach'] = danhsachnguoncung();
}

// khach hang, customer

function themkhach() {
  global $db, $resp, $nv_Request;

  $data = $nv_Request->get_array('data', 'post');
  $vitri = $nv_Request->get_string('vitri', 'post');
  $id = $nv_Request->get_string('id', 'post');

  if (empty($id)) {
    $sql = "insert into pos_khachhang (ten, dienthoai, diachi) values('$data[ten]', '$data[dienthoai]', '$data[diachi]')";
    $id = $db->insert_id($sql);
    $resp['messenger'] = 'Đã thêm khách hàng';
  }
  else {
    $sql = "update pos_khachhang set ten = '$data[ten]', dienthoai = '$data[dienthoai]', diachi = '$data[diachi]' where id = $id";
    $db->query($sql);
    $resp['messenger'] = 'Đã cập nhật khách hàng';
  }

  $resp['status'] = 1;
  if ($vitri == 'banhang') {
    $data['id'] = $id;
    $resp['data'] = $data;
  } 
  else $resp['danhsach'] = danhsachkhach();
}

function xoakhach() {
  global $db, $resp, $nv_Request;
  $id = $nv_Request->get_string('id', 'post');

  $sql = "update pos_khachhang set kichhoat = 0 where id = $id";
  $db->query($sql);
  $resp['status'] = 1;
  $resp['messenger'] = 'Đã xóa khách hàng';
  $resp['danhsach'] = danhsachkhach();
}

function taikhach() {
  global $db, $resp, $nv_Request;

  $resp['status'] = 1;
  $resp['danhsach'] = danhsachkhach();
}

