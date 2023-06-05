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
	$tenloai = $nv_Request->get_string('tenloai', 'post', '');
	
	$sql = "select * from ". PREFIX ."_danhmuc_giong where giong = '$tengiong', loai = '$tenloai'";
	if (!empty($db->fetch($sql))) $resp['messenger'] = 'Giống loài đã tồn tại!!!';
	else {
		if (empty($id)) {
			$sql = "insert into ". PREFIX ."_danhmuc_giong (giong, loai) values('$tengiong', '$tenloai')";
		}
		else $sql = "update ". PREFIX ."_danhmuc_giong set giong = '$tengiong', loai = '$tenloai' where id = $id";
		$db->query($sql);
		$resp['danhsachgiong'] = danhsachgiong();
	}

	$resp['status'] = 1;
}

function laythongtinthanhvien() {
	global $db, $nv_Request, $resp;

	$id = $nv_Request->get_string('id', 'post', '0');
	
	$sql = "select * from ". PREFIX ."_users where userid = $id";
	$nhanvien = $db->fetch($sql);

	$sql = "select * from ". PREFIX ."_phanquyen where userid = $id";
	$phanquyen = $db->fetch($sql)['quyen'];

	$sql = "select b.* from ". PREFIX ."_phanquyen_chitiet a inner join ". PREFIX ."_danhmuc_phuong b on a.idphuong = b.id where a.userid = $id";
	$quyen = $db->all($sql);

  $resp['quyen'] = $quyen;
  $resp['phanquyen'] = $phanquyen;
  $resp['gioitinh'] = ($nhanvien['gender'] ? $nhanvien['gender'] : 'M');
  $resp['hoten'] = $nhanvien['first_name'];
	$resp['email'] = $nhanvien['email'];
	$resp['status'] = 1;
}

function themthanhvien() {
	global $db, $nv_Request, $resp, $global_config, $user_info, $crypt;

	$id = $nv_Request->get_string('id', 'post', '0');
	$hoten = $nv_Request->get_string('hoten', 'post', '0');
	$email = $nv_Request->get_string('email', 'post', '0');
	$tendangnhap = $nv_Request->get_string('tendangnhap', 'post', '0');
	$matkhau = $nv_Request->get_string('matkhau', 'post', '0');
	$gioitinh = $nv_Request->get_string('gioitinh', 'post', '0');
	$phanquyen = $nv_Request->get_string('phanquyen', 'post', '0');
	$quyen = $nv_Request->get_array('quyen', 'post', '0');

	$group_id = 4;
	$username = $tendangnhap;
	$md5username = md5($tendangnhap);
	$password = $crypt->hash_password($matkhau, $global_config['hashprefix']);;
	$email = $email;
	$first_name = $hoten;
	$last_name = '';
	$gender = $gioitinh;
	$photo = '';
	$birthday = 0;
	$sig = '';
	$regdate = time();
	$question = '';
	$answer = '';
	$passlostkey = '';
	$view_mail = 0;
	$remember = 1;
	$in_groups = '';
	$active = 1;
	$active2step = 0;
	$secretkey = '';
	$checknum = md5(nv_genpass(10));
	$last_login = 0;
	$last_ip = '';
	$last_agent = '';
	$last_openid = '';
	$last_update = 0;
	$idsite = 0;
	$safemode = 0;
	$safekey = '';
	$email_verification_time = -2;
	$active_obj = $user_info['userid'];

	if (empty($id)) {
		// thêm
		$sql = "select * from ". PREFIX ."_users where username = '$username'";

		if (empty($db->fetch($sql))) {
			$sql = "insert into ". PREFIX ."_users (group_id, username, md5username, password, email, first_name, last_name, gender, photo, birthday, sig, regdate, question, answer, passlostkey, view_mail, remember, in_groups, active, active2step, secretkey, checknum, last_login, last_ip, last_agent, last_openid, last_update, idsite, safemode, safekey, email_verification_time, active_obj) values('$group_id', '$username', '$md5username', '$password', '$email', '$first_name', '$last_name', '$gender', '$photo', '$birthday', '$sig', '$regdate', '$question', '$answer', '$passlostkey', '$view_mail', '$remember', '$in_groups', '$active', '$active2step', '$secretkey', '$checknum', '$last_login', '$last_ip', '$last_agent', '$last_openid', '$last_update', '$idsite', '$safemode', '$safekey', '$email_verification_time', '$active_obj')";
			$id = $db->insertid($sql);
			$resp['messenger'] = 'Đã thêm thành viên';
		}
		else $resp['messenger'] = 'Tên đăng nhập đã tồn tại';
	}
	else {
		$sql = "update ". PREFIX ."_users set email = '$email', first_name = '$first_name', gender = '$gender' where userid = $id";
		$db->query($sql);
		$resp['messenger'] = 'Đã cập nhật thành viên';
	}

	// phân quyền
	if ($id) {
		$sql = "select * from ". PREFIX ."_phanquyen where userid = $id";
		if (empty($db->fetch($sql))) {
			$sql = "insert into ". PREFIX ."_phanquyen (userid, quyen) values($id, $phanquyen)";
		}
		else {
			$sql = "update ". PREFIX ."_phanquyen set quyen = $phanquyen where userid = $id";
		}
		$db->query($sql);
	
		$sql = "delete from ". PREFIX ."_phanquyen_chitiet where userid = $id and idphuong not in (". implode(',', $quyen) .")";
		$db->query($sql);
	
		foreach ($quyen as $idphuong) {
			$sql = "select * from ". PREFIX ."_phanquyen_chitiet where idphuong = $idphuong and userid = $id";
			if (empty($db->fetch($sql))) {
				$sql = "insert into ". PREFIX ."_phanquyen_chitiet (userid, idphuong) values($id, $idphuong)";
				$db->query($sql);
			}
		}

		$resp['status'] = 1;
		$resp['danhsachthanhvien'] = danhsachthanhvien();
	}
}
