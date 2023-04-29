<?php

/**
 * @Project Petcoffee-tech
 * @Chistua (hchieuthua@gmail.com)
 * @Copyright (C) 2019
 * @Createdate 21-03-2019 13:15
 */

if (!defined('NV_IS_ADMIN_FORM')) {
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

function themphuong() {
	global $db, $nv_Request, $resp;

	$tenphuong = $nv_Request->get_string('tenphuong', 'post', '');
	$sql = "select * from ". PREFIX ."_phuong where ten = '$tenphuong'";
	if (empty($db->fetch($sql))) {
		$sql = "insert into ". PREFIX ."_phuong (ten) values('$tenphuong')";
		$db->query($sql);
	}

	$resp['status'] = 1;
	$resp['danhsach'] = danhsachphuong();
}
