<?php

if (!defined('NV_IS_MOD_NEWS')) {
  exit('Stop!!!');
}

$page_title = $lang_module['title'];

if (!empty($user_info)) {
  header('location: /dashboard');
}
// kiểm tra session
// kiểm tra nếu đã đăng nhập từ admin thì tự động đăng nhập

$xtpl = new XTemplate('main.tpl', PATH);
$xtpl->parse('main');
$contents = $xtpl->text();

include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
