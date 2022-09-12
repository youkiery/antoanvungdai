<?php
if (!defined('NV_SYSTEM')) {
    exit('Stop!!!');
}

define('NV_IS_MOD_NEWS', true);
define('PATH', NV_ROOTDIR . '/modules/'. $module_file . '/template/user/'. $op);
require_once NV_ROOTDIR . '/modules/' . $module_file . '/global.functions.php';

error_reporting(E_ALL);
ini_set('display_errors', 1);

function login_userid($userid) {
  global $db;

  $session = generate_random_string();
  $time = time() + 60 * 60 * 24 * 3;
  $sql = "insert into pet_users_session (userid, session, time) values($userid, '$session', $time)";
  $_SESSION['session'] = $session;
  if ($db->query($sql)) return true;
  return false;
}

function generate_random_string($length = 20) {
  $characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
  $charactersLength = strlen($characters);
  $randomString = '';
  for ($i = 0; $i < $length; $i++) {
    $randomString .= $characters[rand(0, $charactersLength - 1)];
  }
  return $randomString;
}