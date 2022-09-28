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
$x = array();
$xr = array(0 => 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'AA', 'AB', 'AC', 'AD', 'AE', 'AF', 'AG', 'AH', 'AI', 'AJ', 'AK', 'AM', 'AN', 'AO', 'AP', 'AQ', 'AR', 'AS', 'AT', 'AU', 'AV', 'AW', 'AX', 'AY', 'AZ', 'BA', 'BB', 'BC', 'BD', 'BE', 'BF', 'BG', 'BH', 'HI', 'BJ', 'BK', 'BL', 'BM', 'BN', 'BO');
foreach ($xr as $key => $value) {
  $x[$value] = $key;
}

if (!empty($action) && function_exists($action)) {
  $action();
}

echo json_encode($resp);
die();

function importhanghoa() {
  global $db, $nv_Request, $resp, $_FILES, $x, $xr;

  $raw = $_FILES['file']['tmp_name'];
  include(NV_ROOTDIR .'/includes/plugin/PHPExcel/IOFactory.php');
  $inputFileType = PHPExcel_IOFactory::identify($raw);
  $objReader = PHPExcel_IOFactory::createReader($inputFileType);
  $objReader->setReadDataOnly(true);
  $objPHPExcel = $objReader->load($raw);
  
  $sheet = $objPHPExcel->getSheet(0); 
  $highestRow = $sheet->getHighestRow(); 
  $highestColumn = $sheet->getHighestColumn();

  $array = [
    'Mã Hàng' => -1, 'Tên Hàng' => -1, 'Đơn vị' => -1, 'Loại hàng' => -1, 'Giá nhập' => -1, 'Giá bán' => -1, 'Số lượng' => -1, 'Hình ảnh' => -1, 'Giới thiệu' => -1, 'Hoạt động' => -1,
  ];
  $rev = [
    'Mã Hàng' => 'mahang', 'Tên Hàng' => 'tenhang', 'Đơn vị' => 'donvi', 'Loại hàng' => 'loaihang', 'Giá nhập' => 'gianhap', 'Giá bán' => 'giaban', 'Số lượng' => 'soluong', 'Hình ảnh' => 'hinhanh', 'Giới thiệu' => 'gioithieu', 'Hoạt động' => 'hoatdong',
  ];
  $arr = [];
  for ($j = 0; $j <= $x[$highestColumn]; $j ++) {
    $arr [$j]= $sheet->getCell($xr[$j] . '1')->getValue();
  }

  foreach ($arr as $key => $val) {
    if (isset($array[$val])) {
      $array[$val] = $key;
    }
  }

  $check = false;
  foreach ($array as $val) {
    if ($val < 0) $check = true;
  }
  if ($check) {
    $resp['messenger'] = "File thiếu cột dữ liệu";
    return 0;
  }

  for ($i = 0; $i <= $x[$highestRow]; $i ++) {
    $dulieu = [];
    foreach ($array as $key => $value) {
      $val = $sheet->getCell($xr[$value] . ($i + 2))->getValue();
      if ($val !== 0 && empty($val)) $val = '';
      $dulieu[$rev[$key]] = trim($val);
    }
    // kiếm tra loại hàng, nếu có thì thôi, nếu không thì cập nhật, nếu để trống thì cho vô mặc định
    $dulieu['gianhap'] = preg_replace('/\D/', '', $dulieu['gianhap']);
    $dulieu['giaban'] = preg_replace('/\D/', '', $dulieu['giaban']);
    $loaihang = mb_strtolower($dulieu['loaihang']);
    $sql = "select * from pos_phanloai where module = 'hanghoa' and kichhoat = 1 and LOWER(ten) = '$loaihang'";
    if (empty($phanloai = $db->fetch($sql))) {
      $sql = "insert into pos_phanloai (ten, module, kichhoat, thutu) values('$dulieu[loaihang]', 'hanghoa', 1, 0)";
      $phanloai = ['id' => $db->insertid($sql)];
    }
    // kiếm tra mã hàng, nếu có cập nhật, nếu không thì thêm
    $sql = "select id from pos_hanghoa where mahang = '$dulieu[mahang]'";
    if (empty($hanghoa = $db->fetch($sql))) {
      if (empty($dulieu['mahang'])) {
        $sql = "select id from pos_hanghoa order by id desc limit 1";
        $hang = $db->fetch($sql);
        $mahang = fillzero(($hang['id'] ? $hang['id'] : 0) + 1);
        $dulieu['mahang'] = "SP$mahang";
      }
      $sql = "insert into pos_hanghoa (mahang, tenhang, loaihang, giaban, gianhap, soluong, hinhanh, gioithieu, donvi) values('$dulieu[mahang]', '$dulieu[tenhang]', $phanloai[id], $dulieu[giaban], $dulieu[gianhap], $dulieu[soluong], '$dulieu[hinhanh]', '$dulieu[gioithieu]', '$dulieu[donvi]')";
    }
    else {
      $sql = "update pos_hanghoa set tenhang = '$dulieu[tenhang]', loaihang = $phanloai[id], giaban = $dulieu[giaban], gianhap = $dulieu[gianhap], soluong = $dulieu[soluong], hinhanh = '$dulieu[hinhanh]', gioithieu = '$dulieu[gioithieu]', donvi = '$dulieu[donvi]' where id = $hanghoa[id]";
    }
    $db->query($sql);
  }
  $resp['status'] = 1;
  $resp['messenger'] = 'Đã import file, tải lại trang để xem kết quả';
}

function importkhach() {
  global $db, $nv_Request, $resp, $_FILES, $x, $xr;

  $raw = $_FILES['file']['tmp_name'];
  include(NV_ROOTDIR .'/includes/plugin/PHPExcel/IOFactory.php');
  $inputFileType = PHPExcel_IOFactory::identify($raw);
  $objReader = PHPExcel_IOFactory::createReader($inputFileType);
  $objReader->setReadDataOnly(true);
  $objPHPExcel = $objReader->load($raw);
  
  $sheet = $objPHPExcel->getSheet(0); 
  $highestRow = $sheet->getHighestRow(); 
  $highestColumn = $sheet->getHighestColumn();

  $array = [
    'Mã khách' => -1, 'Tên khách' => -1, 'Điện thoại' => -1, 'Địa chỉ' => -1
  ];
  $rev = [
    'Mã khách' => 'makhach', 'Tên khách' => 'tenkhach', 'Điện thoại' => 'dienthoai', 'Địa chỉ' => 'diachi'
  ];
  $arr = [];
  for ($j = 0; $j <= $x[$highestColumn]; $j ++) {
    $arr [$j]= $sheet->getCell($xr[$j] . '1')->getValue();
  }

  foreach ($arr as $key => $val) {
    if (isset($array[$val])) {
      $array[$val] = $key;
    }
  }

  $check = false;
  foreach ($array as $val) {
    if ($val < 0) $check = true;
  }
  if ($check) {
    $resp['messenger'] = "File thiếu cột dữ liệu";
    return 0;
  }

  for ($i = 0; $i <= $x[$highestRow]; $i ++) {
    $dulieu = [];
    foreach ($array as $key => $value) {
      $val = $sheet->getCell($xr[$value] . ($i + 2))->getValue();
      if ($val !== 0 && empty($val)) $val = '';
      $dulieu[$rev[$key]] = trim($val);
    }
    // kiếm tra mã hàng, nếu có cập nhật, nếu không thì thêm
    $sql = "select id from pos_khachhang where makhach = '$dulieu[makhach]' and kichhoat = 1";
    if (empty($khachhang = $db->fetch($sql))) {
      if (empty($dulieu['makhach'])) {
        $sql = "select id from pos_khachhang order by id desc limit 1";
        $khach = $db->fetch($sql);
        $makhach = fillzero(($khach['id'] ? $khach['id'] : 0) + 1);
        $dulieu['makhach'] = "SP$makhach";
      }
      $sql = "insert into pos_khachhang (makhach, tenkhach, diachi, dienthoai, diem, tienno, kichhoat) values('$dulieu[makhach]', '$dulieu[tenkhach]', '$dulieu[diachi]', '$dulieu[dienthoai]', 0, 0, 1)";
    }
    else {
      $sql = "update pos_khachhang set tenkhach = '$dulieu[tenkhach]', diachi = '$dulieu[diachi]', dienthoai = '$dulieu[dienthoai]' where id = $khachhang[id]";
    }
    $db->query($sql);
  }
  $resp['status'] = 1;
  $resp['messenger'] = 'Đã import file, tải lại trang để xem kết quả';
}

// tải file
function download() {
  global $db, $nv_Request, $resp;
  $filemau = [
    'item' => 'FileMauImportHangHoa.xlsx',
    'customer' => 'FileMauImportKhachHang.xlsx',
    'purchase' => 'FileMauImportNhapHang.xlsx'
  ];

  $filename = $nv_Request->get_string('filename', 'post');
  if (isset($filemau[$filename]) && file_exists(UPATH . $filemau[$filename])) {
    $resp['status'] = 1;
    $resp['link'] = URPATH . $filemau[$filename];
  }
  else $resp['messenger'] = 'Lỗi file';
}

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

  if ($row['idkhach']) $xtpl->parse('main.khachhang');

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

  if ($hoadon['giamgiatien'] > 0 || $hoadon['giamgiaphantram'] > 0) {
    $xtpl->assign('tongtien', number_format($hoadon['tongtien']));
    $xtpl->assign('giamgiatienphantram', number_format($hoadon['giamgiaphantram'] * $hoadon['tongtien'] / 100 + $chitiet['giamgiatien']));
    $xtpl->parse('main.giamgia');
  }
  $xtpl->assign('thanhtien', number_format($hoadon['thanhtien']));
  $xtpl->parse('main.row');
  $xtpl->parse('main');

  $resp['status'] = 1;
  $resp['html'] = $xtpl->text();
}

function taisoquy() {
  global $db, $resp, $nv_Request;

  $resp['status'] = 1;
  $resp['danhsach'] = danhsachthuchi();
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
    $xtpl->assign('tenhang', $chitiet['tenhang']);
    $xtpl->assign('soluong', number_format($chitiet['soluong']));
    $xtpl->assign('dongia', number_format($chitiet['dongia']));
    $xtpl->assign('giamgiatien', number_format($chitiet['giamgiatien']));
    if (!empty($chitiet['giamgiaphantram'])) {
      $xtpl->assign('giamgiaphantram', "+ $chitiet[giamgiaphantram]%");
      $xtpl->assign('giamgiatienphantram', "(". (number_format($chitiet['giamgiaphantram'] * $chitiet['dongia'] / 100)) .")");
    } 
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
  $xtpl->assign('giamgiatien', number_format($hoadon['giamgiatien']));
  if (!empty($hoadon['giamgiaphantram'])) {
    $xtpl->assign('giamgiaphantram', "+ $hoadon[giamgiaphantram]%");
    $xtpl->assign('giamgiatienphantram', "(". (number_format($hoadon['giamgiaphantram'] * $hoadon['tongtien'] / 100)) .")");
  } 
  else {
    $xtpl->assign('giamgiaphantram', '');
    $xtpl->assign('giamgiatienphantram', '');
  }
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
    $sql = "select * from pos_khachhang where dienthoai = '$data[dienthoai]'";
    if (!empty($db->fetch($sql))) {
      $resp['status'] = 1;
      $resp['messenger'] = 'Khách hàng đã tồn tại';
      return '';
    }
    else {
      $sql = "select id from pos_khachhang order by id desc limit 1";
      $hang = $db->fetch($sql);
      $ma = "KH" . fillzero(($hang['id'] ? $hang['id'] : 0) + 1);
    
      $sql = "insert into pos_khachhang (makhach, tenkhach, dienthoai, diachi) values('$ma', '$data[ten]', '$data[dienthoai]', '$data[diachi]')";
      $id = $db->insert_id($sql);
      $resp['messenger'] = 'Đã thêm khách hàng';
    }
  }
  else {
    $sql = "update pos_khachhang set makhach = '$data[ma]', tenkhach = '$data[ten]', dienthoai = '$data[dienthoai]', diachi = '$data[diachi]' where id = $id";
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

function themloaithuchi() {
  global $db, $resp, $nv_Request;

  $ten = $nv_Request->get_string('ten', 'post');
  $loai = $nv_Request->get_string('loai', 'post');
  $sql = "insert into pos_loaithuchi (loai, ten) values($loai, '$ten')";
  $id = $db->insertid($sql);

  $sql = "select * from pos_loaithuchi where loai = $loai order by id";
  $danhsachloaithuchi = $db->all($sql);

  $resp['status'] = 1;
  $resp['id'] = $id;
  $resp['html'] = option($danhsachloaithuchi, 'ten', 'id');
}

function themphieuthu() {
  global $db, $resp, $nv_Request;

  $data = $nv_Request->get_array('data', 'post');
  $data['sotien'] = str_replace(',', '', $data['sotien']);
  $thoigian = time();
  $sql = "select id from pos_thuchi order by id desc limit 1";
  $thuchi = $db->fetch($sql);
  if (empty($thuchi)) $thuchi = ['id' => 0];
  $idthuchi = $thuchi['id'];
  $mathuchi = "TC" . fillzero(++ $idthuchi);
  $sql = "insert into pos_thuchi (mathuchi, idloaithuchi, idkhachhang, sotien, thoigian, ghichu) values('$mathuchi', $data[loai], 0, $data[sotien], $thoigian, '$data[ghichu]')";
  $idthuchi = $db->insertid($sql);

  $sql = "insert into pos_chitietthuchi (idthuchi, loai, sotien) values('$idthuchi', 0, $data[sotien])";
  $idthuchi = $db->insertid($sql);
  
  $resp['status'] = 1;
  $resp['messenger'] = 'Đã thêm phiếu thu';
  $resp['html'] = danhsachthuchi();
}

function themphieuchi() {
  global $db, $resp, $nv_Request;

  $data = $nv_Request->get_array('data', 'post');
  $data['sotien'] = str_replace(',', '', $data['sotien']);
  $thoigian = time();
  $sql = "select id from pos_thuchi order by id desc limit 1";
  $thuchi = $db->fetch($sql);
  if (empty($thuchi)) $thuchi = ['id' => 0];
  $idthuchi = $thuchi['id'];
  $mathuchi = "TC" . fillzero(++ $idthuchi);
  $sql = "insert into pos_thuchi (mathuchi, idloaithuchi, idkhachhang, sotien, thoigian, ghichu) values('$mathuchi', $data[loai], 0, -$data[sotien], $thoigian, '$data[ghichu]')";
  $idthuchi = $db->insertid($sql);

  $sql = "insert into pos_chitietthuchi (idthuchi, loai, sotien) values('$idthuchi', 0, -$data[sotien])";
  $idthuchi = $db->insertid($sql);
  
  $resp['status'] = 1;
  $resp['messenger'] = 'Đã thêm phiếu thu';
  $resp['html'] = danhsachthuchi();
}

function xemthongke() {
  global $db, $resp, $nv_Request;

  $resp['status'] = 1;
  $resp['html'] = thongke();
}
