<?php
if (!defined('NV_SYSTEM')) {
  exit('Stop!!!');
}
define('NV_IS_MOD_NEWS', true);
define('PATH', NV_ROOTDIR . '/modules/'. $module_file . '/template/user/'. $op);
define('UPATH', NV_ROOTDIR . '/modules/'. $module_file . '/template/user/');
require_once NV_ROOTDIR . '/modules/' . $module_file . '/global.functions.php';

error_reporting(E_ALL);
ini_set('display_errors', 1);

function fillzero($number) {
  $number = strval($number);
  $zerolength = 8 - strlen($number);
  for ($i = 0; $i < $zerolength; $i++) { 
    $number = '0' . $number;
  }
  return $number;
}