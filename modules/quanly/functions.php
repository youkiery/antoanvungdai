<?php

/**
 * @Project Petcoffee-tech
 * @Chistua (hchieuthua@gmail.com)
 * @Copyright (C) 2019
 * @Createdate 21-03-2019 13:15
 */

if (!defined('NV_SYSTEM')) {
  die('Stop!!!');
}

define('NV_IS_FORM', true); 
define("PREFIX", $db_config['prefix']);
define("PATH", NV_ROOTDIR . '/modules/' . $module_file . '/template/user/');

function laybanner() {
  global $db;

  $sql = "select * from ". PREFIX ."_config where module = 'global' and config_name = 'site_banner'";
  $hinhanh = $db->fetch($sql);
  if (empty($hinhanh)) return NV_ROOTDIR . '/assets/images/noimage.png';
  if (strpos('http', $hinhanh['config_value']) !== false) return $hinhanh['config_value'];
  return '/' . $hinhanh['config_value'];
}

function kiemtraphanquyen($id) {
  global $db;
  if ($id == 1) return 2;
  $sql = "select active from ". PREFIX ."_users where userid = $id";
  $nhanvien = $db->fetch($sql);
  if (empty($nhanvien) || !$nhanvien['active']) return 0;
  $sql = "select * from ". PREFIX ."_phanquyen where userid = $id";
	if (!empty($phanquyen = $db->fetch($sql))) return $phanquyen['quyen'];
  return 0;
}

function chuyendoithoigian($ngay) {
  if (preg_match("/^([0-9]{1,2})\/([0-9]{1,2})\/([0-9]{4})$/", $ngay, $m)) {
    return mktime(0, 0, 0, $m[2], $m[1], $m[3]);
  }
  return false;
}

function kiemtrangaythang($ngay) {
  if (preg_match("/^([0-9]{1,2})\/([0-9]{1,2})\/([0-9]{4})$/", $ngay, $m)) {
    $day = intval($m[1]);
    $month = intval($m[2]);
    $year = intval($m[3]);
    $monthLength = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    if ($year < 1000 || $year > 3000 || $month == 0 || $month > 12) return false;
    if ($year % 400 == 0 || ($year % 100 != 0 && $year % 4 == 0)) $monthLength[1] = 29;
    return $day > 0 && $day <= $monthLength[$month - 1];
  }
  return false;
}

function kiemtrachuho($dulieu) {
	global $db;

  $sql = "select * from ". PREFIX ."_tiemphong_chuho where dienthoai = '$dulieu[dienthoai]'";
  if (empty($chuho = $db->fetch($sql))) {
    $sql = "insert into ". PREFIX ."_tiemphong_chuho (idphuong, ten, dienthoai, diachi) values($dulieu[idphuong], '$dulieu[tenchu]', '$dulieu[dienthoai]', '$dulieu[diachi]')";
    return $db->insertid($sql);
  }
  else {
    $sql = "update ". PREFIX ."_tiemphong_chuho set idphuong = $dulieu[idphuong], ten = '$dulieu[tenchu]', dienthoai = '$dulieu[dienthoai]', diachi = '$dulieu[diachi]' where id = $chuho[id]";
    $db->query($sql);
  }
  return $chuho['id'];
}

function kiemtragiongloai($dulieu) {
	global $db;

  $sql = "select * from ". PREFIX ."_danhmuc_giong where giong = '$dulieu[giong]' and loai = '$dulieu[loai]'";
  if (empty($giongloai = $db->fetch($sql))) {
    $sql = "insert into ". PREFIX ."_danhmuc_giong (giong, loai) values('$dulieu[giong]', '$dulieu[loai]')";
    return $db->insertid($sql);
  }
  return $giongloai['id'];
}

function laytengiongloai($idgiong) {
  global $db;

  $sql = "select * from ". PREFIX ."_danhmuc_giong where id = $idgiong";
  if (empty($giong = $db->fetch($sql))) return 'Chưa xác định';
  return "$giong[loai] $giong[giong]";
}

function kiemtrahinhanh($hinhanh) {
  $hinhanhtam = '';
  foreach ($hinhanh as $diachianh) {
    if (!empty($diachianh)) $hinhanhtam = $diachianh;
  }
  return $hinhanhtam;
}

function kiemtrathucung($idchuho, $dulieu) {
	global $db;

  $idgiong = kiemtragiongloai($dulieu);
  $hinhanh = kiemtrahinhanh($dulieu['hinhanh']);
  $ngaysinh = chuyendoithoigian($dulieu['ngaysinh']);
  $sql = "select * from ". PREFIX ."_tiemphong_thucung where idchu = $idchuho and micro = '$dulieu[micro]'";
  if (empty($thucung = $db->fetch($sql))) {
    $sql = "insert into ". PREFIX ."_tiemphong_thucung (idchu, idgiong, ten, micro, hinhanh, ngaysinh, ngaymat) values($idchuho, $idgiong, '$dulieu[tenthucung]', '$dulieu[micro]', '$hinhanh', $ngaysinh, 0)";
    return $db->insertid($sql);
  }
  else {
    $sql = "update ". PREFIX ."_tiemphong_thucung set idgiong = $idgiong, ten = '$dulieu[tenthucung]', micro = '$dulieu[micro]', hinhanh = '$hinhanh', ngaysinh = $ngaysinh where id = $thucung[id]";
    $db->query($sql);
  }
  return $thucung['id'];
}
