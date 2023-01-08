<?php

if (!defined('NV_IS_MOD_NEWS')) {
  exit('Stop!!!');
}

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

function xuatfilenhaphang() {
  global $db, $nv_Request, $resp, $xr;

  include(NV_ROOTDIR .'/includes/plugin/PHPExcel/IOFactory.php');
  $fileType = 'Excel2007'; 
  $objPHPExcel = PHPExcel_IOFactory::load(UPATH . 'FileMauXuatNhapHang.xlsx');
  $objPHPExcel->setActiveSheetIndex(0);

  $filter = $nv_Request->get_array('filter', 'post');
  if (empty($filter['page'])) $filter['page'] = 1;
  if (empty($filter['batdau'])) $filter['batdau'] = strtotime(date('Y/m/1'));
  else $filter['batdau'] = datetotime($filter['batdau']);
  if (empty($filter['ketthuc'])) $filter['ketthuc'] = strtotime(date('Y/m/t')) + 60 * 60 * 24 - 1;
  else $filter['ketthuc'] = datetotime($filter['ketthuc']) + 60 * 60 * 24 - 1;

  $sql = "select * from pos_nhaphang where thoigian between $filter[batdau] and $filter[ketthuc] order by thoigian desc";
  $danhsach = $db->all($sql);
  $i = 2;
  $thutu = 1;
  $trangthai = [0 => 'Phiếu tạm', 'Đã hoàn thành'];
  
  foreach ($danhsach as $nhaphang) {
    $j = 0;
    $sql = "select * from pos_nguoncung where id = $nhaphang[idnguoncung]";
    $nguoncung = $db->fetch($sql);

    $sql = "select count(*) as number from pos_chitietnhaphang where idnhaphang = $nhaphang[id]";
    $somathang = $db->fetch($sql);

    $sql = "select sum(soluong) as number from pos_chitietnhaphang where idnhaphang = $nhaphang[id]";
    $sohang = $db->fetch($sql);

    $objPHPExcel
      ->setActiveSheetIndex(0)
      ->setCellValue($xr[$j ++] . $i, $thutu++)
      ->setCellValue($xr[$j ++] . $i, $nhaphang['manhap'])
      ->setCellValue($xr[$j ++] . $i, date('d/m/Y H:i:s', $nhaphang['thoigian']))
      ->setCellValue($xr[$j ++] . $i, $nguoncung['ten'])
      ->setCellValue($xr[$j ++] . $i, number_format($somathang['number']))
      ->setCellValue($xr[$j ++] . $i, number_format($sohang['number']))
      ->setCellValue($xr[$j ++] . $i, number_format($nhaphang['tongtien']))
      ->setCellValue($xr[$j ++] . $i, $trangthai[$nhaphang['trangthai']]);
    $i ++;
  }

  $outFile = '/uploads/excel/FileMauXuatNhapHang-'. time() .'.xlsx';
  $objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, $fileType);
  $objWriter->save(NV_ROOTDIR . $outFile);
  $objPHPExcel->disconnectWorksheets();
  unset($objWriter, $objPHPExcel);
  $resp['status'] = 1;
  $resp['link'] = $outFile;
}

function danhsachchitietnhaphang() {
  global $db, $nv_Request, $resp, $xr;

  $id = $nv_Request->get_string('id', 'post', 0);
  $sql = "select a.soluong, b.mahang, b.tenhang from pos_chitietnhaphang a inner join pos_hanghoa b on a.idhang = b.id and a.idnhaphang = $id";
  $resp['status'] = 1;
  $resp['danhsach'] = $danhsach = $db->all($sql);
}

function xuatfilechitietnhaphang() {
  global $db, $nv_Request, $resp, $xr;

  include(NV_ROOTDIR .'/includes/plugin/PHPExcel/IOFactory.php');
  $fileType = 'Excel2007'; 
  $objPHPExcel = PHPExcel_IOFactory::load(UPATH . 'FileChiTietNhapHang.xlsx');
  $objPHPExcel->setActiveSheetIndex(0);

  $id = $nv_Request->get_string('id', 'post', 0);
  $sql = "select * from pos_chitietnhaphang where idnhaphang = $id";
  $danhsach = $db->all($sql);
  $i = 2;
  $thutu = 1;

  foreach ($danhsach as $nhaphang) {
    $j = 0;
    $sql = "select * from pos_hanghoa where id = $nhaphang[idhang]";
    $hanghoa = $db->fetch($sql);

    $objPHPExcel
      ->setActiveSheetIndex(0)
      ->setCellValue($xr[$j ++] . $i, $thutu++)
      ->setCellValue($xr[$j ++] . $i, $hanghoa['mahang'])
      ->setCellValue($xr[$j ++] . $i, $hanghoa['tenhang'])
      ->setCellValue($xr[$j ++] . $i, number_format($nhaphang['soluong']))
      ->setCellValue($xr[$j ++] . $i, number_format($nhaphang['gianhap']))
      ->setCellValue($xr[$j ++] . $i, number_format($nhaphang['soluong'] * $nhaphang['gianhap']));
    $i ++;
  }

  $outFile = '/uploads/excel/FileChiTietNhapHang-'. time() .'.xlsx';
  $objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, $fileType);
  $objWriter->save(NV_ROOTDIR . $outFile);
  $objPHPExcel->disconnectWorksheets();
  unset($objWriter, $objPHPExcel);
  $resp['status'] = 1;
  $resp['link'] = $outFile;
}

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

function importnhaphang() {
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

  $array = [ 'Mã Hàng' => -1, 'Tên Hàng' => -1, 'Đơn vị' => -1, 'Đơn giá' => -1, 'Giá bán' => -1, 'Số lượng' => -1];
  $rev = [ 'Mã Hàng' => 'mahang', 'Tên Hàng' => 'tenhang', 'Đơn vị' => 'donvi', 'Đơn giá' => 'dongia', 'Giá bán' => 'giaban', 'Số lượng' => 'soluong'];
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

  $danhsach = [];
  $loi = [];
  for ($i = 0; $i <= $x[$highestRow]; $i ++) {
    $dulieu = [];
    foreach ($array as $key => $value) {
      $val = $sheet->getCell($xr[$value] . ($i + 2))->getValue();
      if ($val !== 0 && empty($val)) $val = '';
      $dulieu[$rev[$key]] = trim($val);
    }
    $sql = "select * from pos_hanghoa where mahang = '$dulieu[mahang]' and kichhoat = 1";
    if (empty($hanghoa = $db->fetch($sql))) {
      // kiểm tra mã hàng, nếu không có, trả lỗi
      $loi []= 'Hàng hóa '. ($i + 1) .' không tồn tại';
    }
    else {
      // nếu có, thêm vào danh sách
      $danhsach []= [
        'id' => $hanghoa['id'],
        'mahang' => $hanghoa['mahang'],
        'tenhang' => $hanghoa['tenhang'],
        'hinhanh' => $hanghoa['hinhanh'],
        'dongia' => $dulieu['dongia'],
        'soluong' => $dulieu['soluong'],
        'thanhtien' => $dulieu['soluong'] * $hanghoa['gianhap'],
      ];
    }
  }
  $resp['status'] = 1;
  if (count($loi)) {
    $resp['loi'] = implode('<br>', $loi);
    return 0;
  }
  $resp['danhsach'] = $danhsach;
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

  $sql = "select * from pos_hoadon where id = $id";
  $hoadon = $db->fetch($sql);

  foreach ($chitiethoadon as $key => $chitiet) {
    $sql = "update pos_hanghoa set soluong = soluong + $chitiet[soluongthuc] where id = $chitiet[idhang]";
    $db->query($sql);
  }
  // xóa chi tiết hóa đơn
  $sql = "delete from pos_chitiethoadon where idhoadon = $id";
  $db->query($sql);
  // xóa chi tiết hóa đơn
  $sql = "select * from pos_machitietthuchi where mahoadon = $hoadon[mahoadon]";
  $chitietthuchi = $db->fetch($sql);

  $sql = "delete from pos_machitietthuchi where mahoadon = $hoadon[mahoadon]";
  $db->query($sql);

  // $sql = "delete from pos_thuchi where id = $chitietthuchi[idthuchi]";
  // $db->query($sql);

  // $sql = "delete from pos_chitietthuchi where idthuchi = $chitietthuchi[idthuchi]";
  // $db->query($sql);

  // $sql = "delete from pos_chitiettrahang where idhoadon = $id";
  // $db->query($sql);

  // xóa tích điểm
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

  $id = $nv_Request->get_string('id', 'post');
  $xtpl = new XTemplate('inhoadon.tpl', UPATH);

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
  $xtpl->assign('khachhang', $khachhang['tenkhach']);
  $xtpl->assign('diachi', $khachhang['diachi']);
  $xtpl->assign('dienthoai', $khachhang['dienthoai']);
  $xtpl->assign('thoigian', date('d/m/Y H:i:s'));

  if ($row['idkhach']) $xtpl->parse('main.khachhang');

  $sql = "select * from pos_chitiettrahang where idhoadon = $id";
  $danhsachchitiet = $db->all($sql);

  if (count($danhsachchitiet)) {
    foreach ($danhsachchitiet as $chitiet) {
      $sql = "select * from pos_hanghoa where id = $chitiet[idhang]";
      $hanghoa = $db->fetch($sql);
  
      $xtpl->assign('tenhang', $hanghoa['tenhang']);
      $xtpl->assign('giaban', number_format($chitiet['giaban']));
      $xtpl->assign('soluong', number_format($chitiet['soluong']));
      $xtpl->assign('thanhtien', '-' . number_format($chitiet['thanhtien']));
      $xtpl->parse('main.trahang.cot');
    }
    $xtpl->parse('main.trahang');
  }

  $sql = "select * from pos_chitiethoadon where idhoadon = $id";
  $danhsachchitiet = $db->all($sql);

  if (count($danhsachchitiet)) {
    foreach ($danhsachchitiet as $chitiet) {
      $sql = "select * from pos_hanghoa where id = $chitiet[idhang]";
      $hanghoa = $db->fetch($sql);
  
      $xtpl->assign('tenhang', $hanghoa['tenhang']);
      if ($chitiet['giaban'] != $chitiet['dongia']) $xtpl->assign('dongia', number_format($chitiet['dongia']));
      else $xtpl->assign('dongia', '');
      $xtpl->assign('giaban', number_format($chitiet['giaban']));
      $xtpl->assign('soluong', number_format($chitiet['soluong']));
      $xtpl->assign('thanhtien', number_format($chitiet['thanhtien']));
      $xtpl->parse('main.banhang.cot');
    }
    $xtpl->parse('main.banhang');
  }

  if ($hoadon['giamgiatien'] > 0 || $hoadon['giamgiaphantram'] > 0) {
    $xtpl->assign('tongtien', number_format($hoadon['tongtien']));
    $xtpl->assign('giamgiatienphantram', number_format($hoadon['giamgiaphantram'] * $hoadon['tongtien'] / 100 + $chitiet['giamgiatien']));
    $xtpl->parse('main.giamgia');
  }
  $xtpl->assign('thanhtien', number_format($hoadon['thanhtien']));
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

  $sql = "select * from pos_chitiettrahang where idhoadon = $id";
  $danhsachtrahang = $db->all($sql);

  if (count($danhsachtrahang)) {
    foreach ($danhsachtrahang as $chitiet) {
      $sql = "select * from pos_hanghoa where id = $chitiet[idhang]";
      $hanghoa = $db->fetch($sql);
      $xtpl->assign('mahang', $hanghoa['mahang']);
      $xtpl->assign('tenhang', $hanghoa['tenhang']);
      $xtpl->assign('soluong', number_format($chitiet['soluong']));
      $xtpl->assign('giaban', number_format($chitiet['giaban']));
      $xtpl->assign('thanhtien', number_format($chitiet['thanhtien']));
      $xtpl->parse('main.hangtra.cot');
    }
    $xtpl->parse('main.hangtra');
  }

  $sql = "select * from pos_chitiethoadon where idhoadon = $id";
  $danhsach = $db->all($sql);

  $soluong = 0;
  if (count($danhsach)) {
    foreach ($danhsach as $chitiet) {
      $soluong += $chitiet['soluong'];
      $sql = "select * from pos_hanghoa where id = $chitiet[idhang]";
      $hanghoa = $db->fetch($sql);
      $xtpl->assign('mahang', $hanghoa['mahang']);
      $xtpl->assign('tenhang', $hanghoa['tenhang']);
      $xtpl->assign('soluong', number_format($chitiet['soluong']));
      $xtpl->assign('dongia', number_format($chitiet['dongia']));
      $xtpl->assign('giamgiatien', number_format($chitiet['giamgiatien']));
      if (!empty($chitiet['giamgiaphantram'])) {
        $xtpl->assign('giamgiaphantram', "+ $chitiet[giamgiaphantram]%");
        $xtpl->assign('giamgiatienphantram', "(". (number_format($chitiet['giamgiaphantram'] * $chitiet['dongia'] / 100)) .")");
      } 
      $xtpl->assign('giaban', number_format($chitiet['giaban']));
      $xtpl->assign('thanhtien', number_format($chitiet['thanhtien']));
      $xtpl->parse('main.hangban.cot');
    }
    $xtpl->parse('main.hangban');
  }
  $sql = "select first_name from pet_users where userid = $hoadon[idnguoiban]";
  $banhang = $db->fetch($sql);
  $sql = "select first_name from pet_users where userid = $hoadon[idnguoiratoa]";
  $ratoa = $db->fetch($sql);

  $xtpl->assign('id', $id);
  $xtpl->assign('mahoadon', $hoadon['mahoadon']);
  $xtpl->assign('ghichu', $hoadon['ghichu']);
  $xtpl->assign('thoigian', date('d/m/Y H:i'), $hoadon['thoigian']);
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

function chitietnhaphang() {
  global $db, $resp, $nv_Request;

  $id = $nv_Request->get_int('id', 'post');
  $xtpl = new XTemplate('chitiet.tpl', UPATH . '/purchase/');

  $sql = "select * from pos_nhaphang where id = $id";
  $nhaphang = $db->fetch($sql);

  $sql = "select * from pos_nguoncung where id = $nhaphang[idnguoncung]";
  $nguoncung = $db->fetch($sql);
  $xtpl->assign('nguoncung', $nguoncung['ten']);

  $sql = "select first_name from pet_users where userid = $nhaphang[idnguoitao]";
  $nhanvien = $db->fetch($sql);
  $xtpl->assign('ratoa', $nhanvien['first_name']);

  $sql = "select * from pos_chitietnhaphang where idnhaphang = $id";
  $danhsach = $db->all($sql);

  $soluong = 0;
  foreach ($danhsach as $chitiet) {
    $soluong += $chitiet['soluong'];
    $sql = "select * from pos_hanghoa where id = $chitiet[idhang]";
    $hanghoa = $db->fetch($sql);

    $xtpl->assign('mahang', $hanghoa['mahang']);
    $xtpl->assign('tenhang', $hanghoa['tenhang']);
    $xtpl->assign('soluong', number_format($chitiet['soluong']));
    $xtpl->assign('gianhap', number_format($chitiet['gianhap']));
    $xtpl->assign('thanhtien', number_format($chitiet['soluong'] * $chitiet['gianhap']));
    $xtpl->parse('main.row');
  }

  $xtpl->assign('id', $id);
  $xtpl->assign('manhaphang', $nhaphang['manhaphang']);
  $xtpl->assign('thoigian', date('d/m/Y H:i'), $nhaphang['thoigian']);
  $xtpl->assign('sohang', number_format($soluong));
  $xtpl->assign('thanhtien', number_format($nhaphang['tongtien']));
  
  $arr = [0 => 'Lưu tạm', 'Đã hoàn thành'];
  $xtpl->assign('trangthai', $arr[$nhaphang['trangthai']]);
  if (!$nhaphang['trangthai']) $xtpl->parse('main.update');
  if (!$nhaphang['thanhtoan']) $xtpl->parse('main.thanhtoan');
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

function themloaihang() {
  global $db, $resp, $nv_Request;

  $loaihang = $nv_Request->get_string('loaihang', 'post');
  $sql = "select * from pos_phanloai where module = 'hanghoa' and ten = '$loaihang'";
  if (!empty($dulieuloaihang = $db->fetch($sql))) {
    $sql = "update pos_phanloai set kichhoat = 1 where id = $dulieuloaihang[id]";
    $db->query($sql);

    $resp['status'] = 1;
    $resp['messenger'] = 'Loại hàng đã tồn tại';
  }
  else {
    $sql = "insert into pos_phanloai (ten, module, kichhoat, thutu) values('$loaihang', 'hanghoa', 1, 1)";
    $id = $db->insertid($sql);

    $sql = "select * from pos_phanloai where module = 'hanghoa' and kichhoat = 1 order by thutu asc, id asc";
    $loaihang = $db->all($sql);
      
    $resp['status'] = 1;
    $resp['id'] = $id;
    $resp['danhsach'] = option($loaihang, 'ten', 'id');
    $resp['messenger'] = 'Đã thêm loại hàng hóa';
  }
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

function thanhtoannhaphang() {
  global $db, $resp, $nv_Request;

  $id = $nv_Request->get_string('id', 'post');

  $sql = "update pos_nhaphang set thanhtoan = 1 where id = $id";
  $db->query($sql);

  $resp['status'] = 1;
  $resp['danhsach'] = danhsachnhaphang();
  $resp['messenger'] = 'Đã xác nhận thanh toán';
}

function themnhaphang() {
  global $db, $resp, $nv_Request;

  $userid = checkuserid();
  $thoigian = time();
  $id = $nv_Request->get_string('id', 'post');
  $idnguoncung = $nv_Request->get_string('idnguoncung', 'post');
  $trangthai = $nv_Request->get_string('trangthai', 'post', 0);
  $thanhtoan = $nv_Request->get_string('thanhtoan', 'post', 0);
  $danhsach = $nv_Request->get_array('danhsach', 'post');

  if (empty($id)) {
    $sql = "select id from pos_nhaphang order by id desc limit 1";
    $nhaphang = $db->fetch($sql);
    $manhap = "NH". fillzero($nhaphang['id'] + 1);
    
    $sql = "insert into pos_nhaphang (manhap, tongtien, thoigian, idnguoncung, trangthai, thanhtoan, idnguoitao) values('$manhap', 0, $thoigian, $idnguoncung, $thanhtoan, $userid)";
    $id = $db->insertid($sql);
  }
  else {
    $sql = "update pos_nhaphang set thoigian = $thoigian, idnguoncung = $idnguoncung, trangthai = $trangthai, thanhtoan = $thanhtoan, idnguoitao = $userid where id = $id";
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
    $sql = "select id from pos_nguoncung order by id desc limit 1";
    $hang = $db->fetch($sql);
    $ma = "NC" . fillzero(($hang['id'] ? $hang['id'] : 0) + 1);

    $sql = "insert into pos_nguoncung (manguoncung, ten, dienthoai, diachi) values('$ma', '$data[ten]', '$data[dienthoai]', '$data[diachi]')";
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
    
      $sql = "insert into pos_khachhang (makhach, tenkhach, dienthoai, diachi) values('$ma', '$data[tenkhach]', '$data[dienthoai]', '$data[diachi]')";
      $id = $db->insert_id($sql);
      $resp['messenger'] = 'Đã thêm khách hàng';
    }
  }
  else {
    $sql = "update pos_khachhang set makhach = '$data[ma]', tenkhach = '$data[tenkhach]', dienthoai = '$data[dienthoai]', diachi = '$data[diachi]' where id = $id";
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

function taimauhoadon() {
  global $db, $resp;

  $sql = "select * from pos_cauhinh where module = 'mauhoadon'";
  if (empty($cauhinh = $db->fetch($sql))) {
    $sql = "insert into pos_cauhinh (module, giatri) values('mauhoadon', '')";
    $db->query($sql);
    $cauhinh = ['giatri' => ''];
  }

  $resp['status'] = 1;
  $resp['html'] = $cauhinh['giatri'];
}

function luumauhoadon() {
  global $db, $resp, $nv_Request;

  $mauin = $nv_Request->get_string('mauin', 'post');
  $sql = "select * from pos_cauhinh where module = 'mauhoadon'";
  if (empty($cauhinh = $db->fetch($sql))) {
    $sql = "insert into pos_cauhinh (module, giatri) values('mauhoadon', '$mauin')";
  }
  else {
    $sql = "update pos_cauhinh set giatri = '$mauin' where id = $cauhinh[id]";
  }
  $db->query($sql);

  $resp['status'] = 1;
  $resp['messenger'] = 'Đã lưu';
}

function themnhanvien() {
  global $db, $resp, $nv_Request, $global_config, $crypt;

  $dulieu = $nv_Request->get_array('dulieu', 'post');
  // kiem tra co nhan vien nao dang active cung ten thi bao loi
  $sql = "select * from pet_users where username = '$dulieu[taikhoan]' and active = 1";
  if (!empty($db->fetch($sql))) $resp['messenger'] = 'Tên tài khoản đã tồn tại';
  else {
    $sql = "select * from pet_users where email = '$dulieu[email]' and active = 1";
    if (!empty($db->fetch($sql))) $resp['messenger'] = 'Tên tài khoản đã tồn tại';
  
    $matkhau = $crypt->hash_password($dulieu['password'], $global_config['hashprefix']);
    $ngaysinh = datetotime($dulieu['sinhnhat']);
    $homnay = time();
    $sql = "insert into pet_users(group_id, username, md5username, password, email, first_name, last_name, gender, photo, birthday, sig, regdate, question, answer, passlostkey, view_mail, remember, in_groups, active, active2step, secretkey, checknum, last_login, last_ip, last_agent, last_openid, last_update, idsite, safemode, safekey, email_verification_time, active_obj) values(4, '$dulieu[taikhoan]', '". md5($dulieu['taikhoan']) ."', '$matkhau', '$dulieu[email]', '$dulieu[hoten]', '', 0, '', $ngaysinh, '', $homnay, '', '', '', 0, 1, '4', 1, 0, '', '', 0, '', '', '', $homnay, 0, 0, '', -1, 'SYSTEM')";
    $db->query($sql);
    $resp['messenger'] = 'Đã thêm tài khoản';
    $resp['danhsach'] = danhsachnhanvien();
  }

  $resp['status'] = 1;
}

function chitietnhanvien() {
  global $db, $resp, $nv_Request;

  $phanquyen = [
    'Hệ Thống' => [
      'Mẫu In' => [
        'Xem',
        'Sửa',
      ],
      'Người Dùng' => [
        'Xem',
        'Thêm',
        'Sửa',
        'Xóa',
        'Export',
      ],
      'Tổng quan'
    ],
    'Hàng Hóa' => [
      'Danh Sách' => [
        'Xem',
        'Thêm',
        'Sửa',
        'Xóa',
        'Giá Nhập',
        'Giá Vốn',
        'Import',
        'Export',
      ]
    ],
    'Giao Dịch' => [
      'Hóa Đơn' => [
        'Xem',
        'Thêm',
        'Sửa',
        'Xóa',
        'Import',
        'Export',
        'Xem Tồn',
        'Sửa Giá Bán',
        'Sửa Giá Vốn',
        'Giảm Giá',
        'Chọn Người Bán',
        'Sao Chép',
        'In Hóa Đơn',
      ],
      'Nhập Hàng' => [
        'Xem',
        'Thêm',
        'Cập Nhật',
        'Xóa',
        'Cập Nhật Hoàn Thành',
        'Xuất',
        'Sao Chép',
      ]
    ],
    'Đối Tác' => [
      'Khách Hàng' => [
        'Xem',
        'Thêm',
        'Sửa',
        'Xóa',
        'Điện Thoại',
        'Import',
        'Export',
      ],
      'Công Nợ Khách' => [
        'Xem',
        'Thêm',
        'Xóa',
        'Cập Nhật',
      ],
      'Thanh Toán Khách' => [
        'Thêm',
        'Xóa',
        'Cập Nhật',
      ],
      'Tích Điểm' => [
        'Xem',
        'Cập Nhật',
      ],
      'Nhà Cung Cấp' => [
        'Xem',
        'Thêm',
        'Sửa',
        'Xóa',
        'Điện Thoại',
        'Import',
        'Export',
      ],
      'Công Nợ Nhà Cung Cấp' => [
        'Xem',
        'Thêm',
        'Sửa',
        'Xóa',
      ],
      'Thanh Toán Nhà Cung Cấp' => [
        'Thêm',
        'Xóa',
        'Cập Nhật',
      ]
    ],
    'Báo Cáo' => [
      'Cuối Ngày' => [
        'Tổng Hợp',
        'Hàng Hóa',
        'Thu Chi',
        'Bán Hàng',
      ]
    ],
      // Bán Hàng
      //   Nhân Viên
      //   Lợi Nhuận
      //   Giảm Giá Hóa Đơn
      //   Trả Hàng
      //   Thời Gian
      // Hàng Hóa
      //   Giá Trị Kho
      //   Hạn Sử Dụng
      //   Khách Theo Hàng Bán
      //   Nhà Cung Cấp Theo Hàng Nhập
      //   Nhân Viên Theo Hàng Bán
      //   Xuất Nhập Tồn
      //   Xuât Nhập Tồn Chi Tiết
      //   Lợi Nhuận
      //   Bán Hàng
      // Khách Hàng
      //   Công Nợ
      //   Hàng Theo Khách
      //   Bán Hàng
      //   Lợi Nhuận
      // Nhà Cung Cấp
      //   Công Nợ
      //   Hàng Nhập Theo Nhà Cung Cấp
      //   Nhập Hàng
      // Nhân Viên
      //   Lợi Nhuận
      //   Hàng Bán Theo Nhân Viên
      //   Bán Hàng
    'Sổ Quỹ' => [
      'Xem',
      'Thêm',
      'Sửa',
      'Xóa',
      'Export',
    ]
    // nhân viên
    // khuyến mãi
    // voucher
    // coupon
  ];

  $id = $nv_Request->get_int('id', 'post');
  $xtpl = new XTemplate('chitiet.tpl', UPATH . '/setting/');
  $xtpl->assign('id', $id);

  $l1 = 0;
  foreach ($phanquyen as $vitri1 => $quyen1) {
    $l2 = 0;
    $l1 ++;
    $xtpl->assign('l1', $l1);
    $xtpl->assign('l1checked', kiemtraphanquyen($id, $l1));
    if (!is_array($quyen1)) {
      $xtpl->assign('header1', $quyen1);
      $xtpl->parse('main.l1a');
    }
    else {
      $xtpl->assign('header1', $vitri1);
      foreach ($quyen1 as $vitri2 => $quyen2) {
        $l3 = 0;
        $l2 ++;
        $xtpl->assign('l2', $l1 . $l2);
        $xtpl->assign('l2checked', kiemtraphanquyen($id, $l1 . $l2));
        if (!is_array($quyen2)) {
          $xtpl->assign('header2', $quyen2);
          $xtpl->parse('main.l1.l2a');
        }
        else {
          $xtpl->assign('header2', $vitri2);
          foreach ($quyen2 as $vitri3) {
            $l3 ++;
            $xtpl->assign('l3', $l1 . $l2 . $l3);
            $xtpl->assign('l3checked', kiemtraphanquyen($id, $l1 . $l2 . $l3));
            $xtpl->assign('header3', $vitri3);
            $xtpl->parse('main.l1.l2.l3');
          }
          $xtpl->parse('main.l1.l2');
        }
      }
      $xtpl->parse('main.l1');
    }
  }

  $xtpl->parse('main');
  $resp['status'] = 1;
  $resp['html'] = $xtpl->text();
}

function luuphanquyen() {
  global $db, $resp, $nv_Request;

  $id = $nv_Request->get_int('id', 'post');
  $dulieu = $nv_Request->get_array('dulieu', 'post');
  $dathem = [];

  foreach ($dulieu as $quyen => $giatri) {
    if ($giatri > 0) {

      $sql = "select * from pos_phanquyen where quyen = $quyen and userid = $id";
      if (empty($db->fetch($sql))) {
        $sql = "insert into pos_phanquyen (quyen, userid) values ($quyen, $id)";
        $db->query($sql);
      }
      $dathem []= $quyen;
    }
  }
  if (count($dathem)) $sql = "delete from pos_phanquyen where quyen not in (". implode(', ', $dathem) .") and userid = $id";
  else $sql = "delete from pos_phanquyen where userid = $id";
  $db->query($sql);
  $resp['status'] = 1;
  $resp['messenger'] = 'Đã lưu phân quyền';
}

function xemthongke() {
  global $db, $resp, $nv_Request;

  $resp['status'] = 1;
  $resp['html'] = thongke();
}
