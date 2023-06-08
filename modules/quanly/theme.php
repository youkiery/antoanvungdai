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

define('GIOIHAN', 12);

function danhsachphuong() {
  global $db;

  $xtpl = new XTemplate("danhsachphuong.tpl", PATH ."/danhmuc/");

  $sql = "select * from ". PREFIX ."_danhmuc_phuong where kichhoat = 1 order by ten asc";
  $danhsach = $db->all($sql);

  foreach ($danhsach as $phuong) {
    $sql = "select count(id) as tong from ". PREFIX ."_tiemphong_chuho where idphuong = $phuong[id]";
    if (empty($sochuho = $db->fetch($sql))) $sochuho = 0;
    else $sochuho = $sochuho['tong'];
    $sql = "select count(a.id) as tong from ". PREFIX ."_tiemphong_chuho a inner join ". PREFIX ."_tiemphong_thucung b on a.id = b.idchu where a.idphuong = $phuong[id]";
    if (empty($sothucung = $db->fetch($sql))) $sothucung = 0;
    else $sothucung = $sothucung['tong'];

    $xtpl->assign('id', $phuong['id']);
    $xtpl->assign('ten', $phuong['ten']);
    $xtpl->assign('sochuho', $sochuho);
    $xtpl->assign('sothucung', $sothucung);
    $xtpl->parse("main.phuong");
  }
  if (!count($danhsach)) $xtpl->parse('main.trong');
  $xtpl->parse("main");
  return $xtpl->text();
}

function danhsachgiong() {
  global $db;

  $xtpl = new XTemplate("danhsachgiong.tpl", PATH ."/danhmuc/");

  $sql = "select * from ". PREFIX ."_danhmuc_giong where kichhoat = 1 order by loai asc, giong asc";
  $danhsach = $db->all($sql);

  foreach ($danhsach as $giong) {
    $sql = "select count(id) as tong from ". PREFIX ."_tiemphong_thucung where idgiong = $giong[id]";
    if (empty($sothucung = $db->fetch($sql))) $sothucung = 0;
    else $sothucung = $sothucung['tong'];

    $xtpl->assign('id', $giong['id']);
    $xtpl->assign('giong', $giong['giong']);
    $xtpl->assign('loai', $giong['loai']);
    $xtpl->assign('sothucung', $sothucung);
    $xtpl->parse("main.giong");
  }
  if (!count($danhsach)) $xtpl->parse('main.trong');
  $xtpl->parse("main");
  return $xtpl->text();
}

function danhsachthanhvien() {
  global $db;

  $xtpl = new XTemplate("danhsachthanhvien.tpl", PATH ."/thanhvien/");

  $sql = "select * from ". PREFIX ."_users where active = 1 order by userid desc";
  $danhsach = $db->all($sql);

  foreach ($danhsach as $user) {
    $xtpl->assign('userid', $user['userid']);
    $xtpl->assign('username', $user['username']);
    $xtpl->assign('first_name', $user['first_name']);
    $xtpl->parse("main.user");
  }
  if (!count($danhsach)) $xtpl->parse('main.trong');
  $xtpl->parse("main");
  return $xtpl->text();
}

function danhsachxetduyet() {
  global $db;

  $xtpl = new XTemplate("danhsachxetduyet.tpl", PATH ."/thanhvien/");

  $sql = "select * from ". PREFIX ."_users where active = 0 order by userid desc";
  $danhsach = $db->all($sql);

  foreach ($danhsach as $user) {
    $xtpl->assign('userid', $user['userid']);
    $xtpl->assign('username', $user['username']);
    $xtpl->assign('first_name', $user['first_name']);
    $xtpl->parse("main.user");
  }
  if (!count($danhsach)) $xtpl->parse('main.trong');
  $xtpl->parse("main");
  return $xtpl->text();
}

function danhsachtiemphong() {
  global $db, $nv_Request;

	$truongloc = $nv_Request->get_array('truongloc', 'post', '');
  if (empty($truongloc['trang'])) {
    $truongloc = [
      'tenchu' => '',
      'dienthoai' => '',
      'thucung' => '',
      'micro' => '',
      'giong' => '',
      'loai' => '',
      'phuong' => '',
      'batdau' => '',
      'ketthuc' => '',
      'trang' => 1,
    ];
  }
  $xtpl = new XTemplate("danhsachtiemphong.tpl", PATH ."/tiemphong/");
  // bộ lọc: tên chủ, điện thoại, tên thú cưng, micro, giống, loài, phường, thời gian tiêm
  $xtra = [];
  if (!empty($truongloc['tenchu'])) $xtra []= " c.ten like '%$truongloc[tenchu]%' ";
  if (!empty($truongloc['dienthoai'])) $xtra []= " c.dienthoai like '%$truongloc[dienthoai]%' ";
  if (!empty($truongloc['thucung'])) $xtra []= " b.ten like '%$truongloc[thucung]%' ";
  if (!empty($truongloc['micro'])) $xtra []= " b.micro like '%$truongloc[micro]%' ";
  if (!empty($truongloc['giong'])) $xtra []= " d.giong like '%$truongloc[giong]%' ";
  if (!empty($truongloc['loai'])) $xtra []= " d.giong like '%$truongloc[loai]%' ";
  if (!empty($truongloc['phuong'])) $xtra []= " e.ten like '%$truongloc[phuong]%' ";

  $thoigian = 0;
  if (!empty($truongloc['batdau']) && ($batdau = chuyendoithoigian($truongloc['batdau']))) $thoigian += 1;
  if (!empty($truongloc['ketthuc']) && ($ketthuc = chuyendoithoigian($truongloc['ketthuc']))) $thoigian += 2;

  switch ($thoigian) {
    case 1:
      // chỉ bắt đầu
      $xtra []= " a.thoigiantiem >= $batdau ";
      break;
    case 2:
      // chỉ kết thúc
      $xtra []= " a.thoigiantiem <= $ketthuc ";
      break;
    case 3:
      // có bắt đầu & kết thúc
      $xtra []= " (a.thoigiantiem between $batdau and $ketthuc) ";
      break;
  }

  if (count($xtra)) $xtra = " where ". implode(' and ', $xtra);
  else $xtra = '';

  $sql = "select a.id, c.ten as chuho, e.ten as phuong, b.micro, a.thoigiantiem as thoigian from ". PREFIX ."_tiemphong a inner join ". PREFIX ."_tiemphong_thucung b on a.idthucung = b.id inner join ". PREFIX ."_tiemphong_chuho c on b.idchu = c.id inner join ". PREFIX ."_danhmuc_giong d on b.idgiong = d.id inner join ". PREFIX ."_danhmuc_phuong e on c.idphuong = e.id $xtra order by thoigiantiem desc, id desc limit ". GIOIHAN ." offset ". ($truongloc['trang'] - 1) * GIOIHAN;
  $danhsach = $db->all($sql);

  $sql = "select count(a.id) as tong from ". PREFIX ."_tiemphong a inner join ". PREFIX ."_tiemphong_thucung b on a.idthucung = b.id inner join ". PREFIX ."_tiemphong_chuho c on b.idchu = c.id inner join ". PREFIX ."_danhmuc_giong d on b.idgiong = d.id inner join ". PREFIX ."_danhmuc_phuong e on c.idphuong = e.id $xtra";
  if (!empty($tong = $db->fetch($sql))) $tong = $tong['tong'];
  else $tong = 0;

  foreach ($danhsach as $tiemphong) {
    $xtpl->assign('id', $tiemphong['id']);
    $xtpl->assign('chuho', $tiemphong['chuho']);
    $xtpl->assign('phuong', $tiemphong['phuong']);
    $xtpl->assign('micro', $tiemphong['micro']);
    $xtpl->assign('thoigian', date('d/m/Y', $tiemphong['thoigian']));
    $xtpl->parse("main.tiemphong");
  }
  if (!count($danhsach)) $xtpl->parse('main.trong');
  $xtpl->assign('phantrang', phantrang($truongloc['trang'], $tong, GIOIHAN, 'dentrang'));
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