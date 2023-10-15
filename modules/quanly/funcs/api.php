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

$action = $nv_Request->get_string('action', 'post/get');
$resp = array(
  'status' => 0
);

$phanquyen = kiemtraphanquyen();
if ($phanquyen == 0) $resp = ['status' => 0, 'messenger' => 'Thành viên không có quyền'];
else if (!empty($action) && function_exists($action)) {
  $action();
}

echo json_encode($resp);
die();

function timkiem() {
	global $db, $nv_Request, $resp;

	$resp['status'] = 1;
	$resp['danhsach'] = danhsachthucung();
}

function xoaxuphat() {
	global $db, $nv_Request, $resp;

	$id = $nv_Request->get_string('id', 'post', '0');
	$sql = "delete from ". PREFIX ."_xuphat where id = $id";
	$db->query($sql);

	$resp['status'] = 1;
	$resp['danhsachxuphat'] = danhsachxuphat();
}

function chitietxuphat() {
	global $db, $nv_Request, $resp;

  $xtpl = new XTemplate("chitietxuphat.tpl", PATH ."/xuphat/");
	$idchu = $nv_Request->get_string('idchu', 'post', '0');
	$sql = "select * from ". PREFIX ."_tiemphong_chuho where id = $idchu";
	$thongtin = $db->fetch($sql);
	$tongphat = 0;
	$chuadongphat = 0;
	$dongphat = 0;

	$sql = "select * from ". PREFIX ."_xuphat where idchuho = $idchu";
	$danhsach = $db->all($sql);

	foreach ($danhsach as $xuphat) {
		$tongphat ++;
		if ($xuphat['dongphat']) $dongphat ++;
		else $chuadongphat ++;

		$xtpl->assign('mucphat', number_format($xuphat['mucphat']));
		$xtpl->assign('ngayphat', date('d/m/Y', $xuphat['thoigianphat']));
		$xtpl->assign('ngaydong', ($xuphat['thoigiandong'] ? " ngày đóng phạt " . date('d/m/Y', $xuphat['thoigiandong']) : ''));
		$xtpl->parse('main.dongphat');
	}

	$xtpl->assign('tongphat', number_format($tongphat));
	$xtpl->assign('chuadongphat', number_format($chuadongphat));
	$xtpl->assign('dongphat', number_format($dongphat));
	$xtpl->assign('chuho', $thongtin['ten']);
	$xtpl->assign('diachi', $thongtin['diachi']);
	$xtpl->assign('dienthoai', $thongtin['dienthoai']);
	$xtpl->parse('main');

	$resp['status'] = 1;
	$resp['chitiet'] = $xtpl->text();
}

function dongphat() {
	global $db, $nv_Request, $resp;

	$id = $nv_Request->get_string('id', 'post', '0');
	$thoigian = chuyendoithoigian($nv_Request->get_string('thoigian', 'post', '0'));

	$sql = "update ". PREFIX ."_xuphat set dongphat = 1, thoigiandong = $thoigian where id = $id";
	$db->query($sql);

	$resp['status'] = 1;
	$resp['danhsachxuphat'] = danhsachxuphat();
}

function xoaphuong() {
	global $db, $nv_Request, $resp;

	$id = $nv_Request->get_string('id', 'post', '0');
	$sql = "update ". PREFIX ."_quanly_danhmuc_phuong set kichhoat = 0 where id = $id";
	$db->query($sql);

	$resp['status'] = 1;
	$resp['danhsachphuong'] = danhsachphuong();
}

function xoagiong() {
	global $db, $nv_Request, $resp;

	$id = $nv_Request->get_string('id', 'post', '0');
	$sql = "update ". PREFIX ."_quanly_danhmuc_giong set kichhoat = 0 where id = $id";
	$db->query($sql);

	$resp['status'] = 1;
	$resp['danhsachgiong'] = danhsachgiong();
}

function themphuong() {
	global $db, $nv_Request, $resp;

	$id = $nv_Request->get_string('id', 'post', '0');
	$tenphuong = $nv_Request->get_string('tenphuong', 'post', '');
	
	$sql = "select * from ". PREFIX ."_quanly_danhmuc_phuong where ten = '$tenphuong'";
	if (!empty($db->fetch($sql))) $resp['messenger'] = 'Tên phường đã tồn tại!!!';
	else {
		if (empty($id)) {
			$sql = "insert into ". PREFIX ."_quanly_danhmuc_phuong (ten) values('$tenphuong')";
		}
		else $sql = "update ". PREFIX ."_quanly_danhmuc_phuong set ten = '$tenphuong' where id = $id";
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
	
	$sql = "select * from ". PREFIX ."_quanly_danhmuc_giong where giong = '$tengiong' and loai = '$tenloai'";
	if (!empty($db->fetch($sql))) $resp['messenger'] = 'Giống loài đã tồn tại!!!';
	else {
		if (empty($id)) {
			$sql = "insert into ". PREFIX ."_quanly_danhmuc_giong (giong, loai) values('$tengiong', '$tenloai')";
		}
		else $sql = "update ". PREFIX ."_quanly_danhmuc_giong set giong = '$tengiong', loai = '$tenloai' where id = $id";
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
	if (empty($phanquyen = $db->fetch($sql))) $phanquyen = 0;
	else $phanquyen = $phanquyen['quyen'];

	$sql = "select b.* from ". PREFIX ."_phanquyen_chitiet a inner join ". PREFIX ."_quanly_danhmuc_phuong b on a.idphuong = b.id where a.userid = $id";
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
	$password = $crypt->hash_password($matkhau, $global_config['hashprefix']);
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
			$sql = "insert into ". PREFIX ."_users (group_id, username, md5username, password, email, first_name, last_name, gender, photo, birthday, sig, regdate, question, answer, passlostkey, view_mail, remember, in_groups, active, active2step, secretkey, checknum, last_login, last_ip, last_agent, last_openid, last_update, idsite, safemode, safekey, email_verification_time, active_obj, level) values('$group_id', '$username', '$md5username', '$password', '$email', '$first_name', '$last_name', '$gender', '$photo', '$birthday', '$sig', '$regdate', '$question', '$answer', '$passlostkey', '$view_mail', '$remember', '$in_groups', '$active', '$active2step', '$secretkey', '$checknum', '$last_login', '$last_ip', '$last_agent', '$last_openid', '$last_update', '$idsite', '$safemode', '$safekey', '$email_verification_time', '$active_obj', 1)";
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

function timkiemchuho() {
	global $db, $nv_Request, $resp;

	$tukhoa = $nv_Request->get_string('tukhoa', 'post', '');
	$sql = "select * from ". PREFIX ."_tiemphong_chuho where ten like '%$tukhoa%' or diachi like '%$tukhoa%' or dienthoai like '%$tukhoa%' order by id asc limit ". GIOIHAN;
	$danhsach = $db->all($sql);
  $xtpl = new XTemplate('goiychuho.tpl', PATH .'/tiemphong/');

	foreach ($danhsach as $chuho) {
		$sql = "select * from ". PREFIX ."_quanly_danhmuc_phuong where id = $chuho[idphuong]";
		$phuong = $db->fetch($sql)['ten'];
		$xtpl->assign('idchu', $chuho['id']);
		$xtpl->assign('ten', $chuho['ten']);
		$xtpl->assign('diachi', $chuho['diachi']);
		$xtpl->assign('dienthoai', $chuho['dienthoai']);
		$xtpl->assign('idphuong', $chuho['idphuong']);
		$xtpl->assign('phuong', $phuong);
		$xtpl->parse('main.row');
	}

	if (empty($danhsach)) $xtpl->parse('main.trong');
	$xtpl->parse('main');

	$resp['status']	= 1;
	$resp['danhsach']	= $xtpl->text();
}

function timkiemchuhomorong() {
	global $db, $nv_Request, $resp;

	$tukhoa = $nv_Request->get_string('tukhoa', 'post', '');
	$sql = "select * from ". PREFIX ."_tiemphong_chuho a inner join ". PREFIX ."_tiemphong_thucung b on a.id = b.idchu where a.ten like '%$tukhoa%' or a.diachi like '%$tukhoa%' or a.dienthoai like '%$tukhoa%' or b.micro like '%$tukhoa%' order by id asc limit ". GIOIHAN;
	$danhsach = $db->all($sql);
  $xtpl = new XTemplate('goiychuho.tpl', PATH .'/tiemphong/');

	foreach ($danhsach as $chuho) {
		$sql = "select * from ". PREFIX ."_quanly_danhmuc_phuong where id = $chuho[idphuong]";
		$phuong = $db->fetch($sql)['ten'];
		$xtpl->assign('idchu', $chuho['id']);
		$xtpl->assign('ten', $chuho['ten']);
		$xtpl->assign('diachi', $chuho['diachi']);
		$xtpl->assign('dienthoai', $chuho['dienthoai']);
		$xtpl->assign('idphuong', $chuho['idphuong']);
		$xtpl->assign('phuong', $phuong);
		$xtpl->parse('main.row');
	}

	if (empty($danhsach)) $xtpl->parse('main.trong');
	$xtpl->parse('main');

	$resp['status']	= 1;
	$resp['danhsach']	= $xtpl->text();
}

function uploadfile() {
	global $_FILES, $resp;

	$target_dir = NV_ROOTDIR . "/uploads/quanly/";
	$name = pathinfo($_FILES["file"]["name"], PATHINFO_FILENAME);
	$extension = pathinfo($_FILES["file"]["name"], PATHINFO_EXTENSION);
	$time = time();
	$target_file = $target_dir . "$name$time.$extension";
	move_uploaded_file($_FILES["file"]["tmp_name"], $target_file);
	
	$resp['status']	= 1;
	$resp['url']= "/uploads/quanly/$name$time.$extension";
}

function timkiemthucung() {
	global $db, $nv_Request, $resp;

	$tukhoa = $nv_Request->get_string('tukhoa', 'post', '');
	$idchu = $nv_Request->get_string('idchu', 'post', '0');
	$sql = "select * from ". PREFIX ."_tiemphong_thucung where idchu = $idchu and (micro like '%$tukhoa%' or ten like '%$tukhoa%') order by id asc limit ". GIOIHAN;
	$danhsach = $db->all($sql);
  $xtpl = new XTemplate('goiythucung.tpl', PATH .'/tiemphong/');

	foreach ($danhsach as $thucung) {
		$sql = "select * from ". PREFIX ."_quanly_danhmuc_giong where id = $thucung[idgiong]";
		$giongloai = $db->fetch($sql);

		$sql = "select * from ". PREFIX ."_tiemphong_chuho where id = $thucung[idchu]";
		$chuho = $db->fetch($sql);
		$xtpl->assign('idthucung', $thucung['id']);
		$xtpl->assign('ten', $thucung['ten']);
		$xtpl->assign('micro', $thucung['micro']);
		$xtpl->assign('giong', $giongloai['giong']);
		$xtpl->assign('loai', $giongloai['loai']);
		$xtpl->assign('tenchu', $chuho['ten']);
		$xtpl->assign('diachi', $chuho['diachi']);
		$xtpl->assign('dienthoai', $chuho['dienthoai']);
		$xtpl->parse('main.row');
	}

	if (empty($danhsach)) $xtpl->parse('main.trong');
	$xtpl->parse('main');

	$resp['status']	= 1;
	$resp['danhsach']	= $xtpl->text();
}

function timkiemgiongloai() {
	global $db, $nv_Request, $resp;

	$tukhoa = $nv_Request->get_string('tukhoa', 'post', '');
	$sql = "select * from ". PREFIX ."_quanly_danhmuc_giong where giong like '%$tukhoa%' or loai like '%$tukhoa%' order by loai asc, giong asc limit ". GIOIHAN;
	$danhsach = $db->all($sql);
  $xtpl = new XTemplate('goiygiongloai.tpl', PATH .'/tiemphong/');

	foreach ($danhsach as $giongloai) {
		$xtpl->assign('giong', $giongloai['giong']);
		$xtpl->assign('loai', $giongloai['loai']);
		$xtpl->parse('main.row');
	}

	if (empty($danhsach)) $xtpl->parse('main.trong');
	$xtpl->parse('main');

	$resp['status']	= 1;
	$resp['danhsach']	= $xtpl->text();
}

function chuyentrangtiemphong() {
	global $db, $nv_Request, $resp;

	$resp['status'] = 1;
	$resp['danhsachtiemphong'] = danhsachtiemphong();
}

function chuyentrangxetduyet() {
	global $db, $nv_Request, $resp;

	$resp['status'] = 1;
	$resp['danhsachduyet'] = danhsachduyet();
}

function chuyentrangduyet() {
	global $db, $nv_Request, $resp;

	$resp['status'] = 1;
	$resp['danhsachxetduyet'] = danhsachduyet();
}

function chuyentrangnhanvien() {
	global $db, $nv_Request, $resp;

	$resp['status'] = 1;
	$resp['danhsachthanhvien'] = danhsachthanhvien();
}

function chuyentrangchunuoi() {
	global $db, $nv_Request, $resp;

	$resp['status'] = 1;
	$resp['danhsachxetduyet'] = danhsachxetduyet();
}

function xoakichhoatthanhvien() {
	global $db, $nv_Request, $resp;

	$id = $nv_Request->get_string('id', 'post', '0');
	$sql = "update ". PREFIX ."_users set active = 0 where userid = $id";
	$db->query($sql);

	$resp['status'] = 1;
	$resp['danhsachthanhvien'] = danhsachthanhvien();
	$resp['danhsachxetduyet'] = danhsachxetduyet();
}

function mokichhoatthanhvien() {
	global $db, $nv_Request, $resp;

	$id = $nv_Request->get_string('id', 'post', '0');
	$sql = "update ". PREFIX ."_users set active = 1 where userid = $id";
	$db->query($sql);

	$resp['status'] = 1;
	$resp['danhsachthanhvien'] = danhsachthanhvien();
	$resp['danhsachxetduyet'] = danhsachxetduyet();
}

function xoathanhvien() {
	global $db, $nv_Request, $resp;

	$id = $nv_Request->get_string('id', 'post', '0');
	$sql = "delete from ". PREFIX ."_users where userid = $id";
	$db->query($sql);
	$sql = "delete from ". PREFIX ."_phanquyen where userid = $id";
	$db->query($sql);
	$sql = "delete from ". PREFIX ."_phanquyen_chitiet where userid = $id";
	$db->query($sql);
	$sql = "delete from ". PREFIX ."_tiemphong_chuho_lienket where idchu = $id";
	$db->query($sql);

	$resp['status'] = 1;
	$resp['danhsachthanhvien'] = danhsachthanhvien();
	$resp['danhsachxetduyet'] = danhsachxetduyet();
}

function xoatiemphong() {
	global $db, $nv_Request, $resp;

	$id = $nv_Request->get_string('id', 'post', '0');
	$sql = "delete from ". PREFIX ."_tiemphong where id = $id";
	$db->query($sql);

	$resp['status'] = 1;
	$resp['danhsachtiemphong'] = danhsachtiemphong();
}

function kichhoatthanhvien() {
	global $db, $nv_Request, $resp;

	$id = $nv_Request->get_string('id', 'post', '0');
	$sql = "update ". PREFIX ."_users set active = 1 where userid = $id";
	$db->query($sql);

	$resp['status'] = 1;
	$resp['danhsachthanhvien'] = danhsachthanhvien();
	$resp['danhsachxetduyet'] = danhsachxetduyet();
}

function laythongtintiemphong() {
	global $db, $nv_Request, $resp;

	$id = $nv_Request->get_string('id', 'post', '0');
	
  $sql = "select a.id, c.ten as tenchu, c.dienthoai, c.diachi, b.ten as tenthucung, b.micro, d.giong, d.loai, b.hinhanh, c.idphuong, a.thoigiantiem, b.ngaysinh from ". PREFIX ."_tiemphong a inner join ". PREFIX ."_tiemphong_thucung b on a.idthucung = b.id inner join ". PREFIX ."_tiemphong_chuho c on b.idchu = c.id inner join ". PREFIX ."_quanly_danhmuc_giong d on b.idgiong = d.id where a.id = $id";
	$resp = $db->fetch($sql);
	$resp['thoigiantiem'] = date('d/m/Y', $resp['thoigiantiem']);
	$resp['ngaysinh'] = date('d/m/Y', $resp['ngaysinh']);
	$resp['status'] = 1;
}

function laythongtinxuphat() {
	global $db, $nv_Request, $resp;

	$id = $nv_Request->get_string('id', 'post', '0');
	
  $sql = "select a.id, a.noidung, a.mucphat, a.dongphat, a.thoigianphat, a.thoigiandong, c.id as idchuho, c.ten as chuho, c.dienthoai, c.diachi, c.idphuong from ". PREFIX ."_xuphat a inner join ". PREFIX ."_tiemphong_chuho c on a.idchuho = c.id where a.id = $id";
	$resp = $db->fetch($sql);

	$sql = "select * from ". PREFIX ."_xuphat_dinhkem where idxuphat = $id";
	$resp['dinhkem'] = $db->arr($sql, 'diachi');
	$resp['mucphat'] = number_format($resp['mucphat']);
	if (empty($resp['thoigiandong'])) $resp['thoigiandong'] = '';
	else $resp['thoigiandong'] = date('d/m/Y', $resp['thoigiandong']);
	$resp['thoigianphat'] = date('d/m/Y', $resp['thoigianphat']);
	$resp['status'] = 1;
}

function themtiemphong() {
	global $db, $nv_Request, $resp;

	$id = $nv_Request->get_string('id', 'post', '0');
	$dulieu = $nv_Request->get_array('dulieu', 'post', '');
	$idchuho = kiemtrachuho($dulieu);
	$idthucung = kiemtrathucung($idchuho, $dulieu);

	if (empty($dulieu['thoigiantiem'])) {
		// chưa tiêm phòng
		// xóa chưa tiêm phòng
		if ($id) {
			$sql = "delete from ". PREFIX ."_tiemphong where id = $id";
			$db->query($sql);
		}
	}
	else {
		$thoigiantiem = chuyendoithoigian($dulieu['thoigiantiem']);
		if ($thoigiantiem > 0) $thoigiannhac = strtotime('-1 year', $thoigiantiem);
		else $thoigiannhac = 0;
		
		if ($id) {
			// cập nhật
			$sql = "update ". PREFIX ."_tiemphong set idthucung = $idthucung, thoigiantiem = $thoigiantiem, thoigiannhac = $thoigiannhac where id = $id";
		}
		else {
			// thêm
			$sql = "insert into ". PREFIX ."_tiemphong (idthucung, thoigiantiem, thoigiannhac) values ($idthucung, $thoigiantiem, $thoigiannhac)";
		}
		$db->query($sql);
	}

	$resp['danhsachtiemphong'] = danhsachtiemphong();
	$resp['status'] = 1;
}

function themxuphat() {
	global $db, $nv_Request, $resp;

	$id = $nv_Request->get_string('id', 'post', '0');
	$dulieu = $nv_Request->get_array('dulieu', 'post', '');
	$idchuho = kiemtrachuho($dulieu);
	$thoigianphat = chuyendoithoigian($dulieu['thoigianphat']);
	$mucphat = intval($dulieu['mucphat']);

	if (empty($dulieu['thoigiandong'])) {
		$thoigiandong = 0;
		$dongphat = 0;
	}
	else {
		$thoigiandong = chuyendoithoigian($dulieu['thoigiandong']);
		$dongphat = 1;
	}

	if ($id) {
		$sql = "update ". PREFIX ."_xuphat set idchuho = $idchuho, thoigianphat = $thoigianphat, thoigiandong = $thoigiandong, noidung = '$dulieu[noidung]', mucphat = $mucphat where id = $id";
		$db->query($sql);
	}
	else {
		$sql = "insert into ". PREFIX ."_xuphat (idchuho, noidung, mucphat, dongphat, thoigianphat, thoigiandong) values ($idchuho, '$dulieu[noidung]', $mucphat, $dongphat, $thoigianphat, $thoigiandong)";
		$id = $db->insertid($sql);
	}

	$sql = "delete from ". PREFIX ."_xuphat_dinhkem where idxuphat = $id";
	$db->query($sql);

	foreach ($dulieu['tepdinhkem'] as $url) {
		$sql = "insert into ". PREFIX ."_xuphat_dinhkem (idxuphat, diachi) values($id, '$url')";
		$db->query($sql);
	}

	$resp['danhsachxuphat'] = danhsachxuphat();
	$resp['status'] = 1;
}

function doimatkhau() {
	global $db, $nv_Request, $resp, $user_info, $global_config, $crypt;

	$userid = $user_info['userid'];
	$dulieu = $nv_Request->get_array('dulieu', 'post', '');
	$matkhaumoi = $crypt->hash_password($dulieu["matkhaumoi"], $global_config['hashprefix']);

	$sql = "select * from ". PREFIX ."_users where userid = $userid";
	$nguoidung = $db->fetch($sql);
	if (!$crypt->validate_password($dulieu["matkhaucu"], $nguoidung['password'])) $resp["messenger"] = "Sai mật khẩu";
	else {
		$sql = "update ". PREFIX ."_users set `password` = '$matkhaumoi' where userid = $userid";
		$db->query($sql);
		$resp["messenger"] = "Đã đổi mật khẩu";
		$resp['status'] = 1;
	}
}

function importtiemphong() {
  global $db, $nv_Request, $resp, $_FILES, $user_info;

	$x = array();
	$xr = array(0 => 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'AA', 'AB', 'AC', 'AD', 'AE', 'AF', 'AG', 'AH', 'AI', 'AJ', 'AK', 'AM', 'AN', 'AO', 'AP', 'AQ', 'AR', 'AS', 'AT', 'AU', 'AV', 'AW', 'AX', 'AY', 'AZ', 'BA', 'BB', 'BC', 'BD', 'BE', 'BF', 'BG', 'BH', 'HI', 'BJ', 'BK', 'BL', 'BM', 'BN', 'BO');
	foreach ($xr as $key => $value) {
		$x[$value] = $key;
	}

  $raw = $_FILES['file']['tmp_name'];
  include(NV_ROOTDIR .'/includes/plugin/PHPExcel/IOFactory.php');
  $inputFileType = PHPExcel_IOFactory::identify($raw);
  $objReader = PHPExcel_IOFactory::createReader($inputFileType);
  $objReader->setReadDataOnly(true);
  $objPHPExcel = $objReader->load($raw);

	$phanquyen = kiemtraphanquyen();
	$danhsachphuong = kiemtraphanquyenphuong($phanquyen);
  
  $sheet = $objPHPExcel->getSheet(0); 
  $tongdong = intval($sheet->getHighestRow()); 
  $highestColumn = $sheet->getHighestColumn();
  $array = ['Tên chủ hộ' => -1, 'Điện thoại' => -1, 'Địa chỉ' => -1, 'Phường' => -1, 'Số con' => -1, 'Tên thú cưng' => -1, 'Microchip' => -1, 'Loài' => -1, 'Giống' => -1, 'Ngày sinh' => -1, 'Ngày tiêm' => -1];
  $rev = ['Tên chủ hộ' => 'tenchu', 'Điện thoại' => 'dienthoai', 'Địa chỉ' => 'diachi', 'Số con' => 'soluong', 'Phường' => 'phuong', 'Tên thú cưng' => 'tenthucung', 'Microchip' => 'micro', 'Loài' => 'loai', 'Giống' => 'giong', 'Ngày tiêm' => 'thoigiantiem', 'Ngày sinh' => 'ngaysinh'];
  $arr = [];
  for ($j = 0; $j <= $x[$highestColumn]; $j ++) {
    $arr [$j]= $sheet->getCell($xr[$j] . '1')->getValue();
  }

  foreach ($arr as $key => $val) {
    if (isset($array[$val])) $array[$val] = $key;
  }

  $check = false;
  foreach ($array as $val) {
    if ($val < 0) $check = true;
  }
  if ($check) {
    $resp['messenger'] = "File thiếu cột dữ liệu";
    return 0;
  }

	$tatcaphuong = [];
	foreach ($danhsachphuong as $tenphuong => $idphuong) {
		$tatcaphuong []= $tenphuong;
	}
	$tatcaphuong = implode(", ", $tatcaphuong);

	$noidung = "$user_info[first_name] ($tatcaphuong) đã import dữ liệu ";
	$thoigian = time();

  $loi = [];
  for ($i = 2; $i <= $tongdong; $i ++) {
    $dulieu = [];
    foreach ($array as $key => $value) {
      $val = $sheet->getCell($xr[$value] . ($i))->getValue();
      if ($val !== 0 && empty($val)) $val = '';
      $dulieu[$rev[$key]] = trim($val);
    }

    // kiểm tra chủ hộ, nếu chưa có sđt thì thêm
		$sql = "select * from ". PREFIX ."_quanly_danhmuc_phuong where ten = '$dulieu[phuong]'";
		if (empty($phuong = $db->fetch($sql))) {
			$loi []= "Dòng $i tên phường $dulieu[phuong] không có trong danh mục";
		}
		else {
			$dulieu['idphuong'] = $phuong['id'];
			$idchuho = kiemtrachuho($dulieu);

			if (empty($danhsachphuong[$phuong["ten"]])) {
				$loi []= "Dòng $i không có quyền thêm thú nuôi thuộc phường $phuong[ten]";
				continue;
			}

			// kiểm tra thú cưng, nếu chưa có micro thì thêm
			$dulieu['idgiong'] = kiemtragiongloai($dulieu);
			$dulieu['hinhanh'] = '';
			
			if (empty($dulieu['soluong']) || $dulieu['soluong'] <= 0) $dulieu['soluong'] = 1;
			for ($j = 0; $j < $dulieu['soluong']; $j++) { 
				$dulieu['tenthucung'] = $j + 1;
				$idthucung = kiemtrathucung($idchuho, $dulieu);
				
				$thoigiantiem = chuyendoithoigian($dulieu['thoigiantiem']);
				if ($thoigiantiem > 0) $thoigiannhac = strtotime('-1 year', $thoigiantiem);
				else $thoigiannhac = 0;
				// kiểm tra cấu trúc ngày, nếu đúng thì thêm
				if (!empty($thoigiantiem)) {
					$sql = "select * from ". PREFIX ."_tiemphong where idthucung = $idthucung and thoigiantiem = $thoigiantiem and thoigiannhac = $thoigiannhac";
					if (!empty($db->fetch($sql))) {
						$loi []= "Dòng $i chủ hộ $dulieu[tenchu] thú cưng $dulieu[tenthucung] đã có dữ liệu trước đó";
						// continue;
					}
					else {
						$sql = "insert into ". PREFIX ."_tiemphong (idthucung, thoigiantiem, thoigiannhac) values ($idthucung, $thoigiantiem, $thoigiannhac)";
						$db->query($sql);
					}
				}
			}
		}
  }
  if (count($loi)) {
    $resp['loi'] = implode('<br>', $loi);
    return 0;
  }
	else {
		$resp['messenger'] = "Đã import file";
	}
  $resp['status'] = 1;
}

function timkiemthongke() {
  global $db, $nv_Request, $resp;

	$resp['danhsachthongke'] = danhsachthongke();
	$resp['status'] = 1;
}

function timkiemxuphat() {
  global $db, $nv_Request, $resp;

	$resp['danhsachxuphat'] = danhsachxuphat();
	$resp['status'] = 1;
}

function laychitiet() {
  global $db, $nv_Request, $resp;

	$resp['chitiet'] = danhsachchitietchunuoi();
	$resp['status'] = 1;
}

function xoachitietchuho() {
  global $db, $nv_Request, $resp;

	$idthucung = $nv_Request->get_string("id", "post");

	$sql = "delete from ". PREFIX ."_tiemphong where idthucung = $idthucung";
	$db->query($sql);
	$sql = "delete from ". PREFIX ."_tiemphong_thucung where id = $idthucung";
	$db->query($sql);

	$resp['chitiet'] = danhsachchitietchunuoi();
	$resp['danhsachthongke'] = danhsachthongke();
	$resp['status'] = 1;
}

function laythongtinthucung() {
  global $db, $nv_Request, $resp;

	$id = $nv_Request->get_string('id', 'post', '0');
	
  $sql = "select b.ten as tenthucung, b.micro, d.giong, d.loai, b.hinhanh, b.ngaysinh from ". PREFIX ."_tiemphong_thucung b inner join ". PREFIX ."_quanly_danhmuc_giong d on b.idgiong = d.id where b.id = $id";
	$resp = $db->fetch($sql);
	$resp['ngaysinh'] = (empty($resp['ngaysinh']) ? "" : date("d/m/Y", $resp['ngaysinh']));
	$resp['status'] = 1;
}

function capnhatthucung() {
  global $db, $nv_Request, $resp;

	$id = $nv_Request->get_string('id', 'post', '0');
	$dulieu = $nv_Request->get_array('dulieu', 'post', '0');
  $idgiong = kiemtragiongloai($dulieu);
  $hinhanh = kiemtrahinhanh($dulieu['hinhanh']);
  $ngaysinh = chuyendoithoigian($dulieu['ngaysinh']);
	
  $sql = "update ". PREFIX ."_tiemphong_thucung set ten = '$dulieu[tenthucung]', micro = '$dulieu[micro]', idgiong = $idgiong, hinhanh = '$hinhanh', ngaysinh = $ngaysinh where id = $id";
	$db->query($sql);
	
	$resp['chitiet'] = danhsachchitietchunuoi();
	$resp['danhsachthongke'] = danhsachthongke();
	$resp['status'] = 1;
}

function huyxetduyet() {
  global $db, $nv_Request, $resp;

	$id = $nv_Request->get_string('id', 'post', '0');
	$sql = "update ". PREFIX ."_quanly_xetduyet set trangthai = 1 where id = $id";
	$db->query($sql);

	$resp['danhsachduyet'] = danhsachduyet();
	$resp['status'] = 1;
}

function xacnhanxetduyet() {
  global $db, $nv_Request, $resp;

	$id = $nv_Request->get_string('id', 'post', '0');
	$sql = "select * from ". PREFIX ."_quanly_xetduyet where id = $id";
	$thongtinxetduyet = $db->fetch($sql);

	switch ($thongtinxetduyet["loaixetduyet"]) {
		case '1':
			// cập nhật thông tin chủ nuôi
			$dulieu = json_decode($thongtinxetduyet["dulieu"]);
			foreach ($dulieu as $tentruong => $danhsachthaydoi) {
				foreach ($danhsachthaydoi as $giatricu => $giatrimoi) {
					$sql = "update ". PREFIX ."_users_info set $tentruong = '$giatrimoi' where userid = $thongtinxetduyet[idchu]";
					$db->query($sql);
				}
			}
			$sql = "update ". PREFIX ."_quanly_xetduyet set trangthai = 1 where id = $id";
			$db->query($sql);
			break;
		case '2':
			// duyệt vật nuôi
			break;
		case '3':
			// xác nhận tiêm phòng
			break;
		case '4':
			// xác nhận bắn chip
			break;
	}

	$resp['danhsachduyet'] = danhsachduyet();
	$resp['status'] = 1;
}
