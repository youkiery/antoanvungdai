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

$action = $nv_Request->get_string('action', 'post');
$resp = array(
  'status' => 0
);

if (!empty($action) && function_exists($action)) {
  $action();
}

echo json_encode($resp);
die();

function timkiem() {
	global $db, $nv_Request, $resp;

	$resp['status'] = 1;
	$resp['danhsach'] = danhsachthucung();
}

function xoaphuong() {
	global $db, $nv_Request, $resp;

	$id = $nv_Request->get_string('id', 'post', '0');
	$sql = "update ". PREFIX ."_danhmuc_phuong set kichhoat = 0 where id = $id";
	$db->query($sql);

	$resp['status'] = 1;
	$resp['danhsachphuong'] = danhsachphuong();
}

function xoagiong() {
	global $db, $nv_Request, $resp;

	$id = $nv_Request->get_string('id', 'post', '0');
	$sql = "update ". PREFIX ."_danhmuc_giong set kichhoat = 0 where id = $id";
	$db->query($sql);

	$resp['status'] = 1;
	$resp['danhsachgiong'] = danhsachgiong();
}

function themphuong() {
	global $db, $nv_Request, $resp;

	$id = $nv_Request->get_string('id', 'post', '0');
	$tenphuong = $nv_Request->get_string('tenphuong', 'post', '');
	
	$sql = "select * from ". PREFIX ."_danhmuc_phuong where ten = '$tenphuong'";
	if (!empty($db->fetch($sql))) $resp['messenger'] = 'Tên phường đã tồn tại!!!';
	else {
		if (empty($id)) {
			$sql = "insert into ". PREFIX ."_danhmuc_phuong (ten) values('$tenphuong')";
		}
		else $sql = "update ". PREFIX ."_danhmuc_phuong set ten = '$tenphuong' where id = $id";
		$db->query($sql);
		$resp['danhsachphuong'] = danhsachphuong();
	}

	$resp['status'] = 1;
}

function themgiong() {
	global $db, $nv_Request, $resp;

	$id = $nv_Request->get_string('id', 'post', '0');
	$tengiong = $nv_Request->get_string('tengiong', 'post', '');
	
	$sql = "select * from ". PREFIX ."_danhmuc_giong where ten = '$tengiong'";
	if (!empty($db->fetch($sql))) $resp['messenger'] = 'Tên phường đã tồn tại!!!';
	else {
		if (empty($id)) {
			$sql = "insert into ". PREFIX ."_danhmuc_giong (ten) values('$tengiong')";
		}
		else $sql = "update ". PREFIX ."_danhmuc_giong set ten = '$tengiong' where id = $id";
		$db->query($sql);
		$resp['danhsachgiong'] = danhsachgiong();
	}

	$resp['status'] = 1;
}
