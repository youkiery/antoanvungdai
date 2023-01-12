<?php
if (!defined('NV_SYSTEM')) {
  exit('Stop!!!');
}
define('NV_IS_MOD_NEWS', true);
define('PATH', NV_ROOTDIR . '/modules/'. $module_file . '/template/user/'. $op);
define('UPATH', NV_ROOTDIR . '/modules/'. $module_file . '/template/user/');
require_once NV_ROOTDIR . '/modules/' . $module_file . '/global.functions.php';

function quyennhanvien($quyen) {
  global $db;

  $userid = checkuserid();
  $sql = "select * from pos_phanquyen where userid = $userid and quyen = '$quyen'";
  if (empty($db->fetch($sql))) return false;
  return true;
}

function rutgondienthoai($dienthoai, $quyen = true) {
  // nếu không có quyền điền thoại thì rút gọn
  if (!$quyen) {
    $chieudai = strlen($dienthoai);
    if ($chieudai <= 3) $dienthoai = '[..]';
    else $dienthoai = substr($dienthoai, 0, 1) . '[..]' . substr($dienthoai, $chieudai - 3);
  }
  return $dienthoai;
}

function checkuserid() {
  global $_SESSION, $db;

  $session = $_SESSION['session'];
  $sql = "select * from pet_users_session where session = '$session'";
  $dulieuphien = $db->fetch($sql);
  if (empty($dulieuphien)) return '0';
  return $dulieuphien['userid'];
}

function fillzero($number) {
  $number = strval($number);
  $zerolength = 8 - strlen($number);
  for ($i = 0; $i < $zerolength; $i++) { 
    $number = '0' . $number;
  }
  return $number;
}