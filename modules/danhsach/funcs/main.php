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

$page_title = laytieude();

$xtpl = new XTemplate("main.tpl", PATH .'/main/');
$xtpl->assign('module_file', $module_file);
$xtpl->assign('logo', laylogo());
$xtpl->assign('banner', laybanner());
if (isset($user_info['userid'])) $xtpl->parse('main.nhanvien');
else $xtpl->parse('main.khach');

$xtpl->assign('content', danhsachthucung());
$xtpl->parse("main");
$contents = $xtpl->text();

include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';

