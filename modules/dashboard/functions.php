<?php
if (!defined('NV_SYSTEM')) {
  exit('Stop!!!');
}
define('NV_IS_MOD_NEWS', true);
define('PATH', NV_ROOTDIR . '/modules/'. $module_file . '/template/user/'. $op);
define('UPATH', NV_ROOTDIR . '/modules/'. $module_file . '/template/user/');
define('URPATH', '/modules/'. $module_file . '/template/user/');
require_once NV_ROOTDIR . '/modules/' . $module_file . '/global.functions.php';

error_reporting(E_ALL);
ini_set('display_errors', 1);

function khoangsosanh($tenbien, $batdau, $ketthuc) {
  $thutu = 0;
  $trave = '';
  if (!empty($batdau)) $thutu += 1;
  if (!empty($ketthuc)) $thutu += 2;
  switch ($thutu) {
    case 1:
    $trave = "($tenbien > $batdau)";
    break;
    case 2:
    $trave = "($tenbien < $ketthuc)";
    break;
    case 3:
    $trave = "($tenbien between $batdau and $ketthuc)";
    break;
  }
  return $trave;
  }
  
  function chuyenthoigian($time) {
  if (preg_match("/^([0-9]{1,2})\/([0-9]{1,2})\/([0-9]{4})$/", $time, $m)) {
    $time = mktime(0, 0, 0, $m[2], $m[1], $m[3]);
    if (!$time) return 0;
  }
  else return 0;
  return $time;
}