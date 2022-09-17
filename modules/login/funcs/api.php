<?php

if (!defined('NV_IS_MOD_NEWS')) {
  exit('Stop!!!');
}

error_reporting(E_ALL);
ini_set('display_errors', 1);
$action = $nv_Request->get_string('action', 'post');
$resp = array(
  'status' => 0
);
if (!empty($action) && function_exists($action)) {
  $action();
}

echo json_encode($resp);
die();

function signin() {
  global $db, $resp, $nv_Request, $crypt;

  $username = $nv_Request->get_string('username', 'post');
  $password = $nv_Request->get_string('password', 'post');

  $sql = "select * from pet_users where username = '$username'";
  if (empty($user = $db->fetch($sql))) {
    $resp['messenger'] = 'Tài khoản không tồn tại';
  }
  else if (!$crypt->validate_password($password, $user['password'])) {
    $resp['messenger'] = 'Sai mật khẩu';
  }
  else {
    if (login_userid($user['userid'])) $resp['status'] = 1;
  }
}
