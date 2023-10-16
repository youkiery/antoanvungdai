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

function kiemtraphanquyenphuong($phanquyen = 0) {
  global $db, $user_info;

  if ($phanquyen == 2) $sql = "select id as idphuong, ten from ". PREFIX ."_quanly_danhmuc_phuong order by ten asc";
  else $sql = "select a.idphuong, b.ten from ". PREFIX ."_phanquyen_chitiet a inner join ". PREFIX ."_quanly_danhmuc_phuong b on a.idphuong = b.id where a.userid = $user_info[userid] order by b.ten asc";
  return $db->obj($sql, "ten", "idphuong");
}

function kiemtraphanquyen() {
  global $db, $user_info;
  
  if (!isset($user_info['userid'])) header('location: /users/login');
  $id = $user_info['userid'];
  if (empty($id)) return 0;
  if ($id == 1) return 2;
  $sql = "select active from ". PREFIX ."_users where userid = $id";
  $nhanvien = $db->fetch($sql);
  if (empty($nhanvien) || !$nhanvien['active']) return 0;
  $sql = "select * from ". PREFIX ."_phanquyen where userid = $id";
	if (!empty($phanquyen = $db->fetch($sql))) return $phanquyen['quyen'];
  return 0;
}

function kiemtraphanquyennhanvien($userid) {
  global $db, $user_info;
  
  if (!isset($userid)) return 0;
  if (empty($userid)) return 0;
  if ($userid == 1) return 2;
  $sql = "select active from ". PREFIX ."_users where userid = $userid";
  $nhanvien = $db->fetch($sql);
  if (empty($nhanvien) || !$nhanvien['active']) return 0;
  $sql = "select * from ". PREFIX ."_phanquyen where userid = $userid";
	if (!empty($phanquyen = $db->fetch($sql))) return $phanquyen['quyen'];
  return 0;
}

function chuyendoithoigian($ngay) {
  if (preg_match("/^([0-9]{1,2})\/([0-9]{1,2})\/([0-9]{4})$/", $ngay, $m)) {
    return mktime(0, 0, 0, $m[2], $m[1], $m[3]);
  }
  return 0;
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
	global $db, $global_config;

  $thoigian = time();
  if (empty($dulieu['dienthoai'])) {
    $sql = "select * from ". PREFIX ."_users_info where diachi = '$dulieu[diachi]' and phuong = $dulieu[idphuong]";
    if (empty($chuho = $db->fetch($sql))) {
      $sql = "insert into ". PREFIX ."_users (group_id, username, md5username, password, email, first_name, last_name, gender, photo, birthday, sig, regdate, question, answer, passlostkey, view_mail, remember, in_groups, active, checknum, last_login, last_ip, last_agent, last_openid, idsite, email_verification_time, active_obj, level) VALUES (4, '', '', '', '', '$dulieu[tenchu]', '', 'M',  '', '0', '', $thoigian, '', '', '', 0, 1, 4, 0, '', 0, '', '', '', $global_config[idsite], -1, 'SYSTEM', 0)";
      $id = $db->insertid($sql);

      $sql = "insert into ". PREFIX ."_users_info (userid, dienthoai, diachi, phuong) values($id, '$dulieu[dienthoai]', '$dulieu[diachi]', $dulieu[idphuong])";
      $db->query($sql);
      return $id;
    }
    return $chuho['userid'];
  }
  else {
    $sql = "select * from ". PREFIX ."_users_info where dienthoai = '$dulieu[dienthoai]'";
    if (empty($chuho = $db->fetch($sql))) {
      $sql = "insert into ". PREFIX ."_users (group_id, username, md5username, password, email, first_name, last_name, gender, photo, birthday, sig, regdate, question, answer, passlostkey, view_mail, remember, in_groups, active, checknum, last_login, last_ip, last_agent, last_openid, idsite, email_verification_time, active_obj, level) VALUES (4, '', '', '', '', '$dulieu[tenchu]', '', 'M',  '', '0', '', $thoigian, '', '', '', 0, 1, 4, 0, '', 0, '', '', '', $global_config[idsite], -1, 'SYSTEM', 0)";
      $id = $db->insertid($sql);

      $sql = "insert into ". PREFIX ."_users_info (userid, dienthoai, diachi, phuong) values($id, '$dulieu[dienthoai]', '$dulieu[diachi]', $dulieu[idphuong])";
      $db->query($sql);
      return $id;
    }
    return $chuho['userid'];
  }
}

function kiemtragiongloai($dulieu) {
	global $db;

  $sql = "select * from ". PREFIX ."_quanly_danhmuc_giong where giong = '$dulieu[giong]' and loai = '$dulieu[loai]'";
  if (empty($giongloai = $db->fetch($sql))) {
    $sql = "insert into ". PREFIX ."_quanly_danhmuc_giong (giong, loai) values('$dulieu[giong]', '$dulieu[loai]')";
    return $db->insertid($sql);
  }
  return $giongloai['id'];
}

function laytengiongloai($idgiong) {
  global $db;

  $sql = "select * from ". PREFIX ."_quanly_danhmuc_giong where id = $idgiong";
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

  // nếu tồn tại microchip thì cập nhật riêng, nếu không thì thêm thẳng
  // trường hợp thêm thẳng nếu có số lượng thì for

  if (!empty($dulieu['micro'])) {
    $sql = "select * from ". PREFIX ."_tiemphong_thucung where idchu = $idchuho and micro = '$dulieu[micro]'";
    if (empty($thucung = $db->fetch($sql))) {
      $sql = "insert into ". PREFIX ."_tiemphong_thucung (idchu, idgiong, ten, micro, hinhanh, ngaysinh, ngaymat) values($idchuho, $idgiong, '$dulieu[tenthucung]', '$dulieu[micro]', '$hinhanh', $ngaysinh, 0)";
      return $db->insertid($sql);
    }
  }
  else {
    $sql = "insert into ". PREFIX ."_tiemphong_thucung (idchu, idgiong, ten, micro, hinhanh, ngaysinh, ngaymat) values($idchuho, $idgiong, '$dulieu[tenthucung]', '$dulieu[micro]', '$hinhanh', $ngaysinh, 0)";
    return $db->insertid($sql);
  }

  return $thucung['id'];
}
