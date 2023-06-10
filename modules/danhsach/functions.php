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
  if (empty($id)) return 0;
  if ($id == 1) return 2;
  $sql = "select active from ". PREFIX ."_users where userid = $id";
  $nhanvien = $db->fetch($sql);
  if (empty($nhanvien) || !$nhanvien['active']) return 0;
  $sql = "select * from ". PREFIX ."_phanquyen where userid = $id";
	if (!empty($phanquyen = $db->fetch($sql))) return $phanquyen['quyen'];
  return 0;
}

function laytieude() {
  global $db;

  $sql = "select * from ". PREFIX ."_config where module = 'global' and config_name = 'site_description'";
  $tieude = $db->fetch($sql);
  return $tieude['config_value'];
}

function laylogo() {
  global $db;

  $sql = "select * from ". PREFIX ."_config where module = 'global' and config_name = 'site_logo'";
  $hinhanh = $db->fetch($sql);
  if (empty($hinhanh)) return NV_ROOTDIR . '/assets/images/noimage.png';
  if (strpos('http', $hinhanh['config_value']) >= 0) return $hinhanh['config_value'];
  return '/' . $hinhanh['config_value'];
}

function laybanner() {
  global $db;

  $sql = "select * from ". PREFIX ."_config where module = 'global' and config_name = 'site_banner'";
  $hinhanh = $db->fetch($sql);
  if (empty($hinhanh)) return NV_ROOTDIR . '/assets/images/noimage.png';
  if (strpos('http', $hinhanh['config_value']) !== false) return $hinhanh['config_value'];
  return '/' . $hinhanh['config_value'];
}

function kiemtrahinhanh($hinhanh) {
  if (!empty($hinhanh)) return $hinhanh;
  return '/assets/images/noimage.png';
}

function laytengiongloai($idgiong) {
  global $db;

  $sql = "select * from ". PREFIX ."_danhmuc_giong where id = $idgiong";
  if (empty($giong = $db->fetch($sql))) return 'Chưa xác định';
  return "$giong[loai] $giong[giong]";
}

function laythongtinchu($idchu) {
  global $db;

  $sql = "select * from ". PREFIX ."_tiemphong_chuho where id = $idchu";
  if (empty($chuho = $db->fetch($sql))) return 'Chưa xác định';
  return "$chuho[ten]";
}