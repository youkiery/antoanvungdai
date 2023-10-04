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

$page_title = "Quản lý vật nuôi";

$phanquyen = kiemtraphanquyen();
$xtpl = new XTemplate("main.tpl", PATH . '/vatnuoi/');
$xtpl->assign('sidemenu', sidemenu());
$xtpl->assign('danhsachvatnuoi', danhsachvatnuoi());

$thongtin = [
	'diachi' => "",
	'idphuong' => "",
	'dienthoai' => "",
];

if ($phanquyen == 0) $xtpl->parse('main.coquyen');
else $xtpl->parse('main.khongquyen');
$xtpl->parse('main');
$contents = $xtpl->text();

include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';

