<?php

/**
 * @Project Petcoffee-tech
 * @Chistua (hchieuthua@gmail.com)
 * @Copyright (C) 2019
 * @Createdate 21-03-2019 13:15
 */

if (!defined('NV_IS_FORM')) {
	die('Stop!!!');
}

$page_title = "Quản lý tài khoản";

if (!isset($user_info['userid'])) header('location: /users/login');

$phanquyen = kiemtraphanquyen($user_info['userid']);
$xtpl = new XTemplate("main.tpl", PATH . '/main/');
$xtpl->assign('banner', laybanner());
$xtpl->assign('module_file', $module_file);
if ($phanquyen >= 0) $xtpl->parse("main.thanhvien");
if ($phanquyen >= 1) $xtpl->parse("main.nhanvien");
if ($phanquyen == 2) $xtpl->parse("main.quanly");
$xtpl->parse("main");
$contents = $xtpl->text("main");


include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';

