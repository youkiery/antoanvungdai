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

$xtpl = new XTemplate("main.tpl", PATH .'/thongke/');
$xtpl->assign('dulieuthongke', dulieuthongke());
$xtpl->assign('danhsachthongke', danhsachthongke());

$xtpl->parse("main");
$contents = $xtpl->text("main");

include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';

