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

function inhoadon($id) {
  global $db, $resp;

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
  
  return $xtpl->text();
}
