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

$xtpl = new XTemplate("main.tpl", PATH .'/chitiet/');
$xtpl->assign('logo', laylogo());
$xtpl->assign('banner', laybanner());

$id = $nv_Request->get_string('id', 'get', '0');

$sql = "select b.ten, b.id as idthucung, b.idgiong, b.idchu, b.hinhanh, c.ten as tenchu, c.diachi, c.dienthoai, d.ten as tenphuong from ". PREFIX ."_tiemphong_thucung b inner join ". PREFIX ."_tiemphong_chuho c on b.idchu = c.id inner join ". PREFIX ."_danhmuc_phuong d on c.idphuong = d.id where b.id = $id";
$thucung = $db->fetch($sql);

$hinhanh = kiemtrahinhanh($thucung['hinhanh']);
$xtpl->assign('hinhanh', $hinhanh);
$xtpl->assign('tenthucung', $thucung['ten']);
$xtpl->assign('giongloai', laytengiongloai($thucung['idgiong']));
$xtpl->assign('tenchu', $thucung['tenchu']);
$xtpl->assign('diachi', $thucung['diachi']);
$xtpl->assign('tenphuong', $thucung['tenphuong']);

$sql = "select * from ". PREFIX ."_tiemphong where idthucung = $thucung[idthucung] order by thoigiantiem desc";
$danhsach = $db->all($sql);

foreach ($danhsach as $tiemphong) {
	$xtpl->assign('thoigian', date('d/m/Y', $tiemphong['thoigiantiem']));
	$xtpl->parse("main.row");
}

$xtpl->parse("main");
$contents = $xtpl->text("main");

include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';

