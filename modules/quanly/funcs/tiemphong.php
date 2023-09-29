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

$xtpl = new XTemplate("main.tpl", PATH . '/tiemphong/');
$xtpl->assign('sidemenu', sidemenu());
$phanquyen = kiemtraphanquyen();
if ($phanquyen == 0) $xtpl->parse("main.khongquyen");
else {
	$xtpl->assign('homnay', date('d/m/Y'));
	$xtpl->assign('danhsachtiemphong', danhsachtiemphong());

	$sql = "select * from ". PREFIX ."_danhmuc_phuong where kichhoat = 1 order by ten asc";
	$danhsachphuong = $db->all($sql);

	foreach ($danhsachphuong as $phuong) {
		$xtpl->assign('idphuong', $phuong['id']);
		$xtpl->assign('tenphuong', $phuong['ten']);
		$xtpl->parse('main.coquyen.timkiemphuong');
		$xtpl->parse('main.coquyen.phuong');
	}

	$xtpl->parse("main.coquyen");
}
$xtpl->parse("main");
$contents = $xtpl->text();

include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';

