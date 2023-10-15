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

$xtpl = new XTemplate("main.tpl", PATH . '/vatnuoi/');
$xtpl->assign('sidemenu', sidemenu());
$phanquyen = kiemtraphanquyen();
if ($phanquyen == 0) {
	$action = $nv_Request->get_string('action', 'post/get');
	$resp = array(
		'status' => 0
	);

	if (!empty($action) && function_exists($action)) {
		$action();
	
		echo json_encode($resp);
		die();
	}

	$xtpl->assign('idchu', $user_info["userid"]);
	$xtpl->assign('danhsachvatnuoi', danhsachvatnuoi());

	$sql = "select * from ". PREFIX ."_quanly_danhmuc_phuong where kichhoat = 1 order by ten asc";
	$danhsachphuong = $db->all($sql);

	foreach ($danhsachphuong as $phuong) {
		$xtpl->assign('idphuong', $phuong['id']);
		$xtpl->assign('tenphuong', $phuong['ten']);
		$xtpl->parse('main.coquyen.phuong');
	}

	$sql = "select * from ". PREFIX ."_quanly_xetduyet where idchu = $user_info[userid] and trangthai = 0 and loaixetduyet = 1";
	if (!empty($xetduyet = $db->fetch($sql))) {
		$dulieu = json_decode($xetduyet["dulieu"]);
		foreach ($dulieu as $tentruong => $giatrimoi) {
			$xtpl->assign("xetduyet". $tentruong, " => ". $giatrimoi . " (chờ xét duyệt)");
		}
	}

	$sql = "select * from ". PREFIX ."_users_info where userid = $user_info[userid]";
	$thongtin = $db->fetch($sql);
	
	$sql = "select * from ". PREFIX ."_quanly_danhmuc_phuong where id = '$thongtin[phuong]'";
	$phuong = $db->fetch($sql);

	if (empty($phuong = $db->fetch($sql))) {
		$thongtin["tenphuong"] = "";
		$thongtin["phuong"] = "0";
	}
	else {
		$thongtin["tenphuong"] = $phuong["ten"];
		$thongtin["phuong"] = $phuong["id"];
	}

	$thongtin["tenchuho"] = $user_info["first_name"];

	foreach ($thongtin as $tentruong => $giatri) {
		$xtpl->assign($tentruong, $giatri);
	}

	$xtpl->parse('main.coquyen');
}
else $xtpl->parse('main.khongquyen');
$xtpl->parse('main');
$contents = $xtpl->text();

include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';

function chuyentrangvatnuoi() {
	global $db, $nv_Request, $resp;

	$resp['status'] = 1;
	$resp['danhsachvatnuoi'] = danhsachvatnuoi();
}

function capnhatthongtin() {
	global $db, $nv_Request, $resp, $user_info;

	$idchuho = $user_info["userid"];
	$dulieu = $nv_Request->get_array("dulieu", "post");

	$sql = "select * from ". PREFIX ."_users_info where userid = $idchuho";
	$thongtinchunuoi = $db->fetch($sql);

	$thaydoi = [];
	foreach ($dulieu as $tentruong => $giatri) {
		if (isset($thongtinchunuoi[$tentruong]) && $thongtinchunuoi[$tentruong] !== $giatri) $thaydoi[$tentruong] = $giatri;
	}

	if (count($thaydoi)) {
		$thoigian = time();
		$dulieu = [];
		$noidung = [];
		$chuyendoi = ["tenchuho" => "Tên chủ", "diachi" => "Địa chỉ", "phuong" => "Phường", "dienthoai" => "Điện thoại"];
		foreach ($thaydoi as $tentruong => $giatri) {
			$dulieu [$tentruong]= $giatri;
			if ($tentruong == "phuong") {
				$sql = "select * from ". PREFIX ."_quanly_danhmuc_phuong where id = $thongtinchunuoi[$tentruong]";
				if (empty($phuong = $db->fetch($sql))) $phuong["ten"] = "";

				$sql = "select * from ". PREFIX ."_quanly_danhmuc_phuong where id = $giatri";
				if (empty($phuong2 = $db->fetch($sql))) $phuong2["ten"] = "";
				$noidung [] = "$chuyendoi[$tentruong] $phuong[ten] => $phuong2[ten]";
			}
			else $noidung [] = "$chuyendoi[$tentruong] $thongtinchunuoi[$tentruong] => $giatri";
		}
		$noidung = "Thay đổi ". implode(", ", $noidung);
		$dulieu = json_encode($dulieu);

		$sql = "select * from ". PREFIX ."_quanly_xetduyet where idchu = $idchuho and loaixetduyet = 1 and trangthai = 0";
		if (!empty($xetduyet = $db->fetch($sql))) {
			$sql = "update ". PREFIX ."_quanly_xetduyet set noidung = '$noidung', dulieu = '$dulieu', thoigian = $thoigian where id = $xetduyet[id]";
			$db->query($sql);
		}
		else {
			$sql = "insert into ". PREFIX ."_quanly_xetduyet (loaixetduyet, idnguoitao, idchu, idthucung, noidung, dulieu, thoigian, trangthai) values(1, $idchuho, $idchuho, 0, '$noidung', '$dulieu', $thoigian, 0)";
			$db->query($sql);
		}
	}

	$resp['status'] = 1;
}

function themtiemphong() {
	global $db, $nv_Request, $resp;

	$idchu = $nv_Request->get_string('idchu', 'post', '0');
	$dulieu = $nv_Request->get_array('dulieu', 'post', '');

  $sql = "select b.first_name as tenchu, a.dienthoai, a.diachi, a.phuong as idphuong from ". PREFIX ."_users_info a inner join ". PREFIX ."_users b on a.userid = b.userid where a.userid = $idchu";
  $chuho = $db->fetch($sql);
	$idchuho = kiemtrachuho($chuho);
	$idthucung = kiemtrathucung($idchuho, $dulieu);
	$thoigian = time();

	$sql = "update ". PREFIX ."_tiemphong_thucung set xacnhan = 0 where id = $idthucung";
	$db->query($sql);

	$sql = "insert into ". PREFIX ."_quanly_xetduyet (loaixetduyet, idnguoitao, idchu, idthucung, noidung, dulieu, thoigian, trangthai) values(2, $idchuho, $idchuho, $idthucung, 'Thêm vật nuôi $dulieu[tenthucung]', '', $thoigian, 0)";
	$db->query($sql);

	$resp['status'] = 1;
}

function timkiemthucung() {
	global $db, $nv_Request, $resp;

	$tukhoa = $nv_Request->get_string('tukhoa', 'post', '');
	$idchu = $nv_Request->get_string('idchu', 'post', '0');

  $sql = "select * from ". PREFIX ."_users_info where userid = $idchu";
  $chuho = $db->fetch($sql);
  if (empty($chuho)) $x = 0;
  else $x = 1;

  $sql = "select * from ". PREFIX ."_tiemphong_thucung where idchu in (select id as idchu from ". PREFIX ."_tiemphong_chuho where dienthoai = '$chuho[dienthoai]' and $x) and (micro like '%$tukhoa%' or ten like '%$tukhoa%') ";
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