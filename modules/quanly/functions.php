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
  $sql = "select * from ". PREFIX ."_tiemphong_thucung where idchu = $idchuho and micro = '$dulieu[micro]'";
  if (empty($thucung = $db->fetch($sql))) {
    $sql = "insert into ". PREFIX ."_tiemphong_thucung (idchu, idgiong, ten, micro, hinhanh) values($idchuho, '$dulieu[tenthucung]', '$dulieu[micro]', '$hinhanh')";
    return $db->insertid($sql);
  }
  else {
    $sql = "update ". PREFIX ."_tiemphong_thucung set ten = '$dulieu[tenthucung]', micro = '$dulieu[micro]', hinhanh = '$hinhanh' where id = $thucung[id]";
    $db->query($sql);
  }
  return $thucung['id'];
}
