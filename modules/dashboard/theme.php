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

  $filter = $nv_Request->get_array('filter', 'post');
  $query = array();
  if (empty($filter['page'])) $filter['page'] = 1;

  if (!empty($filter['tukhoa'])) $query []= "tenhang like '%$filter[tukhoa]%'";
  if (!empty($filter['loaihang'])) $query []= "loaihang = $filter[loaihang]";
  if (count($query)) $query = " and " . implode(' and ', $query);
  else $query = '';

  $sql = "select count(id) as count from pos_hanghoa where kichhoat = 1 $query";
  $total = $db->fetch($sql)['count']; 

  $sql = "select * from pos_hanghoa where kichhoat = 1 $query order by id desc limit 10 offset ". ($filter['page'] - 1) * 10;
  $list = $db->all($sql);

  foreach ($list as $row) {
    $hinhanh = explode(',', $row['hinhanh']);
    if (count($hinhanh) && !empty($hinhanh[0])) $hinhanh = $hinhanh[0];
    else $hinhanh = '/assets/images/noimage.png';
    $xtpl->assign('hinhanh', $hinhanh);
    $xtpl->assign('id', $row['id']);
    $xtpl->assign('mahang', $row['mahang']);
    $xtpl->assign('tenhang', $row['tenhang']);
    $xtpl->assign('donvi', $row['donvi']);
    $xtpl->assign('gianhap', number_format($row['gianhap']));
    $xtpl->assign('giaban', number_format($row['giaban']));
    $xtpl->assign('soluong', number_format($row['soluong']));
    $xtpl->parse('main.row');
  }
  $xtpl->assign('navbar', navbar($filter['page'], $total, 20, 'onclick="timkiem({p})"'));
  $xtpl->parse('main');
  return $xtpl->text();
}

function danhsachnhaphang() {
  global $db, $nv_Request;

  $filter = $nv_Request->get_array('filter', 'post');
  if (empty($filter['page'])) $filter['page'] = 1;
  if (empty($filter['batdau'])) $filter['batdau'] = strtotime(date('Y/m/1'));
  else $filter['batdau'] = datetotime($filter['batdau']);
  if (empty($filter['ketthuc'])) $filter['ketthuc'] = strtotime(date('Y') .'/'. (date('m') + 1) . '/1') - 1;
  else $filter['ketthuc'] = datetotime($filter['ketthuc']);

  $sql = "select count(*) as count from pos_nhaphang where thoigian between $filter[batdau] and $filter[ketthuc] order by thoigian desc";
  $count = $db->fetch($sql)['count'];

  $sql = "select * from pos_nhaphang where thoigian between $filter[batdau] and $filter[ketthuc] order by thoigian desc";
  $danhsach = $db->all($sql);

  $lf = ($filter['page'] - 1) * 20;
  $lt = $lf + 20;
  $trangthai = array(0 => 'Phiếu tạm', 'Hoàn thành');
  $xtpl = new XTemplate('danhsach.tpl', UPATH . '/purchase/');
  foreach ($danhsach as $i => $row) {
    $sql = "select * from pos_chitietnhaphang a inner join pos_hanghoa b on a.idhang = b.id and idnhaphang = $row[id] and (tenhang like '%$filter[tukhoa]%' or mahang like '%$filter[tukhoa]%')";
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
        if ($row['trangthai'] == 0) $xtpl->parse('main.row.update');
        $xtpl->parse('main.row');
      }
    }
  }
  $xtpl->assign('navbar', navbar($filter['page'], $count, 20, 'onclick="timkiem({p})"'));
  $xtpl->parse('main');
  return $xtpl->text();
}

function danhsachnguoncung() {
  global $db, $nv_Request;

  $filter = $nv_Request->get_array('filter', 'post');
  if (empty($filter['page'])) $filter['page'] = 1;
  if (empty($filter['tukhoa'])) $filter['tukhoa'] = '';

  $sql = "select count(id) as count from pos_nguoncung where kichhoat = 1 and (ten like '%$filter[tukhoa]%' or diachi like '%$filter[tukhoa]%' or dienthoai like '%$filter[tukhoa]%')";
  $count = $db->fetch($sql)['count']; 

  $sql = "select * from pos_nguoncung where  kichhoat = 1 and (ten like '%$filter[tukhoa]%' or diachi like '%$filter[tukhoa]%' or dienthoai like '%$filter[tukhoa]%') order by id desc";
  $danhsach = $db->all($sql);

  $xtpl = new XTemplate('danhsach.tpl', UPATH . '/source/');
  foreach ($danhsach as $i => $row) {
    $xtpl->assign('id', $row['id']);
    $xtpl->assign('ten', $row['ten']);
    $xtpl->assign('dienthoai', $row['dienthoai']);
    $xtpl->assign('diachi', $row['diachi']);
    $xtpl->parse('main.row');
  }
  $xtpl->assign('navbar', navbar($filter['page'], $count, 20, 'onclick="timkiem({p})"'));
  $xtpl->parse('main');
  return $xtpl->text();
}

function danhsachkhach() {
  global $db, $nv_Request;

  $filter = $nv_Request->get_array('filter', 'post');
  if (empty($filter['page'])) $filter['page'] = 1;
  if (empty($filter['tukhoa'])) $filter['tukhoa'] = '';

  $sql = "select count(id) as count from pos_khachhang where kichhoat = 1 and (ten like '%$filter[tukhoa]%' or diachi like '%$filter[tukhoa]%' or dienthoai like '%$filter[tukhoa]%')";
  $count = $db->fetch($sql)['count']; 

  $sql = "select * from pos_khachhang where  kichhoat = 1 and (ten like '%$filter[tukhoa]%' or diachi like '%$filter[tukhoa]%' or dienthoai like '%$filter[tukhoa]%') order by id desc";
  $danhsach = $db->all($sql);

  $xtpl = new XTemplate('danhsach.tpl', UPATH . '/customer/');
  foreach ($danhsach as $i => $row) {
    $xtpl->assign('id', $row['id']);
    $xtpl->assign('ten', $row['ten']);
    $xtpl->assign('dienthoai', $row['dienthoai']);
    $xtpl->assign('diachi', $row['diachi']);
    $xtpl->parse('main.row');
  }
  $xtpl->assign('navbar', navbar($filter['page'], $count, 20, 'onclick="timkiem({p})"'));
  $xtpl->parse('main');
  return $xtpl->text();
}

function danhsachhoadon() {
  global $db, $nv_Request;

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

  $sql = "select * from pos_hoadon $xtra order by thoigian desc limit 20 offset ". ($filter['page'] - 1) * 20;
  // die($sql);
  $danhsach = $db->all($sql);

  $xtpl = new XTemplate('danhsach.tpl', UPATH . '/bill/');
  foreach ($danhsach as $i => $row) {
    if (!$row['idkhach']) $khachhang = ['ten' => 'Khách lẻ'];
    else {
      $sql = "select * from pos_khachhang where id = $row[idkhach]";
      $khachhang = $db->fetch($sql);
    }

    $xtpl->assign('id', $row['id']);
    $xtpl->assign('mahoadon', $row['mahoadon']);
    $xtpl->assign('thoigian', date('d/m/Y H:i', $row['thoigian']));
    $xtpl->assign('khachhang', $khachhang['ten']);
    $xtpl->assign('tongtien', number_format($row['tongtien']));
    $xtpl->assign('thanhtien', number_format($row['thanhtien']));
    $xtpl->assign('giamgiatien', number_format($row['giamgiatien']));
    if (!empty($row['giamgiaphantram'])) $xtpl->assign('giamgiaphantram', "+ $row[giamgiaphantram]%");
    else $xtpl->assign('giamgiaphantram', '');

    if ($row['giamgiaphantram'] > 0 || $row['giamgiatien'] > 0) $xtpl->assign('cogiamgia', 'pw-giamgia');
    else $xtpl->assign('cogiamgia', '');
    // $giamgia = $row['tongtien'] - $row['thanhtien'];
    // $xtpl->assign('giamgia', $giamgia);
    $xtpl->assign('datra', number_format($row['thanhtoan']));
    $xtpl->parse('main.row');
  }
  $xtpl->assign('navbar', navbar($filter['page'], $count, 20, 'onclick="timkiem({p})"'));
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

function navbar($page, $total, $limit, $surfix) {
  $xtpl = new XTemplate('navbar.tpl', UPATH);
  $pagelength = floor($total / $limit) + (fmod($total, $limit) ? 1 : 0);
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
