<?php

/**
 * @Project Petcoffee-tech
 * @Chistua (hchieuthua@gmail.com)
 * @Copyright (C) 2019
 * @Createdate 21-03-2019 13:15
 */

if (!defined('PREFIX')) {
  die('Stop!!!');
}

$buy_sex = array('Sao cũng được', 'Đực', 'Cái');

define('GIOIHAN', 12);

function danhsachthucung() {
  global $db, $nv_Request, $module_file;

  $xtpl = new XTemplate("danhsachthucung.tpl", PATH .'/main/');

  $tukhoa = $nv_Request->get_string('tukhoa', 'post', '');
  $trang = $nv_Request->get_string('trang', 'post', '1');
  if (empty($tukhoa)) $xtra = "";
  else $xtra = " where b.ten like '%$tukhoa%' or b.micro like '%$tukhoa%'";

  // gom tất cả idthucung lại, sort theo thời gian
  $sql = "select a.id, b.ten, b.id as idthucung, b.idgiong, b.idchu, b.hinhanh from ". PREFIX ."_tiemphong a inner join ". PREFIX ."_tiemphong_thucung b on a.idthucung = b.id $xtra group by idthucung order by thoigiantiem desc, a.id desc limit ". GIOIHAN . " offset ". ($trang - 1) * GIOIHAN;
  $danhsach = $db->all($sql);
  $sql = "select count(a.id) as tongtruong from ". PREFIX ."_tiemphong a inner join ". PREFIX ."_tiemphong_thucung b on a.idthucung = b.id $xtra";
  if (empty($tong = $db->fetch($sql))) $tong = 0;
  else $tong = $tong['tongtruong'];

  foreach ($danhsach as $thucung) {
    $hinhanh = kiemtrahinhanh($thucung['hinhanh']);
    $xtpl->assign('id', $thucung['idthucung']);
    $xtpl->assign('image', $hinhanh);
    $xtpl->assign('name', $thucung['ten']);
    $xtpl->assign('micro', $thucung['micro']);
    $xtpl->assign('chuho', laythongtinchu($thucung['idchu']));
    $xtpl->assign('species', laytengiongloai($thucung['idgiong']));
    $xtpl->parse("main.thucung");
  }
  
  $xtpl->assign('danhsachtrang', phantrang($trang, $tong, GIOIHAN, 'dentrang'));
  $xtpl->parse("main");
  return $xtpl->text();
}

function phantrang($trang, $tong, $gioihan, $chucnang = '') {
  $xtpl = new XTemplate('phantrang.tpl', PATH);
  $tongtrang = floor($tong / $gioihan) + (fmod($tong, $gioihan) ? 1 : 0);
  if (!$tongtrang) $tongtrang = 1;
  for ($i = 1; $i <= $tongtrang; $i++) {
    if ($trang == $i) $xtpl->assign('active', 'btn-info');
    else $xtpl->assign('active', 'btn-default');
    if (!empty($chucnang)) $xtpl->assign('chucnang', 'onclick="'. $chucnang .'('. $i .')"');
    else $xtpl->assign('chucnang', '');
    $xtpl->assign('trang', $i);
    $xtpl->parse('main.row');
  }
  $xtpl->parse('main');
  return $xtpl->text();
}