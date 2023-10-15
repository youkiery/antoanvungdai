<?php

/**
 * @Project Petcoffee-tech
 * @Chistua (hchieuthua@gmail.com)
 * @Copyright (C) 2019
 * @Createdate 21-03-2019 13:15
 */

if (!defined('PREFIX')) {
  die('Stop!!!');
}

define('GIOIHAN', 12);

function danhsachphuong() {
  global $db;

  $xtpl = new XTemplate("danhsachphuong.tpl", PATH ."/danhmuc/");

  $sql = "select * from ". PREFIX ."_quanly_danhmuc_phuong where kichhoat = 1 order by ten asc";
  $danhsach = $db->all($sql);

  foreach ($danhsach as $phuong) {
    $sql = "select count(id) as tong from ". PREFIX ."_tiemphong_chuho where idphuong = $phuong[id]";
    if (empty($sochuho = $db->fetch($sql))) $sochuho = 0;
    else $sochuho = $sochuho['tong'];
    $sql = "select count(a.id) as tong from ". PREFIX ."_tiemphong_chuho a inner join ". PREFIX ."_tiemphong_thucung b on a.id = b.idchu where a.idphuong = $phuong[id] and xacnhan = 1";
    if (empty($sothucung = $db->fetch($sql))) $sothucung = 0;
    else $sothucung = $sothucung['tong'];

    $xtpl->assign('id', $phuong['id']);
    $xtpl->assign('ten', $phuong['ten']);
    $xtpl->assign('sochuho', $sochuho);
    $xtpl->assign('sothucung', $sothucung);
    $xtpl->parse("main.phuong");
  }
  if (!count($danhsach)) $xtpl->parse('main.trong');
  $xtpl->parse("main");
  return $xtpl->text();
}

function danhsachgiong() {
  global $db;

  $xtpl = new XTemplate("danhsachgiong.tpl", PATH ."/danhmuc/");

  $sql = "select * from ". PREFIX ."_quanly_danhmuc_giong where kichhoat = 1 order by loai asc, giong asc";
  $danhsach = $db->all($sql);

  foreach ($danhsach as $giong) {
    $sql = "select count(id) as tong from ". PREFIX ."_tiemphong_thucung where idgiong = $giong[id] and xacnhan = 1";
    if (empty($sothucung = $db->fetch($sql))) $sothucung = 0;
    else $sothucung = $sothucung['tong'];

    $xtpl->assign('id', $giong['id']);
    $xtpl->assign('giong', $giong['giong']);
    $xtpl->assign('loai', $giong['loai']);
    $xtpl->assign('sothucung', $sothucung);
    $xtpl->parse("main.giong");
  }
  if (!count($danhsach)) $xtpl->parse('main.trong');
  $xtpl->parse("main");
  return $xtpl->text();
}

function danhsachthanhvien() {
  global $db, $user_info, $nv_Request;

  $xtpl = new XTemplate("danhsachthanhvien.tpl", PATH ."/thanhvien/");
  $trangnhanvien = $nv_Request->get_string("trangnhanvien", "post", 1);

  $sql = "select * from ". PREFIX ."_users where level = 1 order by userid desc limit ". GIOIHAN ." offset ". ($trangnhanvien - 1) * GIOIHAN;
  $danhsach = $db->all($sql);

  $sql = "select userid from ". PREFIX ."_users where level = 1 order by userid desc";
  $tong = count($db->all($sql));

  $quyen = [0 => 'Thành viên', 'Nhân viên', 'Quản lý'];
  // nếu userid == 1, toàn quyền
  // có quyền quản lý và đối phương không phải quản lý thì hiện
  $chucnang = false;
  if ($user_info["userid"] == 1 || kiemtraphanquyennhanvien($user_info["userid"])) $chucnang = true;

  foreach ($danhsach as $user) {
    $sql = "select * from ". PREFIX ."_phanquyen where userid = $user[userid]";
    if (empty($quyennhanvien = $db->fetch($sql))) $quyennhanvien = 0;
    else $quyennhanvien = $quyennhanvien['quyen'];
    $xtpl->assign('userid', $user['userid']);
    $xtpl->assign('username', $user['username']);
    $xtpl->assign('first_name', $user['first_name']);
    $xtpl->assign('quyen', $quyen[$quyennhanvien]);
    if ($user["active"]) $xtpl->assign('trangthai', "Đã kích hoạt");
    else $xtpl->assign('trangthai', "Đã vô hiệu");

    if ($chucnang) {
      if ($user["active"]) $xtpl->parse("main.user.chucnang.kichhoat");
      else $xtpl->parse("main.user.chucnang.vohieuhoa");
      if ($user_info["userid"] == 1 || kiemtraphanquyennhanvien($user["userid"]) < 2) $xtpl->parse("main.user.chucnang");
    }
    $xtpl->parse("main.user");
  }
  if (!count($danhsach)) $xtpl->parse('main.trong');
  $xtpl->assign('phantrang', phantrang($trangnhanvien, $tong, GIOIHAN, 'dentrangnhanvien'));
  $xtpl->parse("main");
  return $xtpl->text();
}

function danhsachxetduyet() {
  global $db, $nv_Request;

  $xtpl = new XTemplate("danhsachxetduyet.tpl", PATH ."/thanhvien/");

  $trangchunuoi = $nv_Request->get_string("trangchunuoi", "post", 1);

  $sql = "select * from ". PREFIX ."_users where level = 0 order by userid desc limit ". GIOIHAN ." offset ". ($trangchunuoi - 1) * GIOIHAN;
  $danhsach = $db->all($sql);

  $sql = "select userid from ". PREFIX ."_users where level = 1 order by userid desc";
  $tong = count($db->all($sql));

  foreach ($danhsach as $user) {
    $xtpl->assign('userid', $user['userid']);
    $xtpl->assign('username', $user['username']);
    $xtpl->assign('first_name', $user['first_name']);
    if ($user["active"]) {
      $xtpl->assign('trangthai', "Đã kích hoạt");
      $xtpl->parse("main.user.kichhoat");
    }
    else {
      $xtpl->assign('trangthai', "Chờ kích hoạt");
      $xtpl->parse("main.user.vohieuhoa");
    } 
    $xtpl->parse("main.user");
  }
  if (!count($danhsach)) $xtpl->parse('main.trong');
  $xtpl->assign('phantrang', phantrang($trangchunuoi, $tong, GIOIHAN, 'dentrangchunuoi'));
  $xtpl->parse("main");
  return $xtpl->text();
}

function danhsachtiemphong() {
  global $db, $nv_Request, $user_info;

	$truongloc = $nv_Request->get_array('truongloc', 'post', '');
  if (empty($truongloc['trang'])) {
    $truongloc = [
      'tenchu' => '',
      'dienthoai' => '',
      'thucung' => '',
      'micro' => '',
      'giong' => '',
      'loai' => '',
      'phuong' => '',
      'batdau' => '',
      'ketthuc' => '',
      'trang' => 1,
    ];
  }
  $xtpl = new XTemplate("danhsachtiemphong.tpl", PATH ."/tiemphong/");
  // bộ lọc: tên chủ, điện thoại, tên thú cưng, micro, giống, loài, phường, thời gian tiêm
  // kiểm tra quyền, nếu là quyền nhân viên thì lọc theo danh sách
  $phanquyen = kiemtraphanquyen();
  $xtra = [];
  
  $phanquyen = kiemtraphanquyen();
  $danhsachphuong = kiemtraphanquyenphuong($phanquyen);
  if ($phanquyen == 2) $xtra []= 1;
  else if (empty($danhsachphuong)) $xtra []= 0;
  else $xtra [] = "(e.id in (". implode(", ", $danhsachphuong) .") )";

  if ($phanquyen == 1) {
    $sql = "select * from ". PREFIX ."_phanquyen_chitiet where userid = $user_info[userid]";
    $danhsachphuong = $db->arr($sql, 'idphuong');
    if (!count($danhsachphuong)) $xtra []= " 0 ";
    else $xtra []= " e.id in (". (implode(', ', $danhsachphuong)) .") ";
  }
  if (!empty($truongloc['tenchu'])) $xtra []= " c.ten like '%$truongloc[tenchu]%' ";
  if (!empty($truongloc['dienthoai'])) $xtra []= " c.dienthoai like '%$truongloc[dienthoai]%' ";
  if (!empty($truongloc['thucung'])) $xtra []= " b.ten like '%$truongloc[thucung]%' ";
  if (!empty($truongloc['micro'])) $xtra []= " b.micro like '%$truongloc[micro]%' ";
  if (!empty($truongloc['giong'])) $xtra []= " d.giong like '%$truongloc[giong]%' ";
  if (!empty($truongloc['loai'])) $xtra []= " d.giong like '%$truongloc[loai]%' ";
  if (!empty($truongloc['phuong'])) $xtra []= " e.id = $truongloc[phuong] ";

  $thoigian = 0;
  if (!empty($truongloc['batdau']) && ($batdau = chuyendoithoigian($truongloc['batdau']))) $thoigian += 1;
  if (!empty($truongloc['ketthuc']) && ($ketthuc = chuyendoithoigian($truongloc['ketthuc']))) $thoigian += 2;

  switch ($thoigian) {
    case 1:
      // chỉ bắt đầu
      $xtra []= " a.thoigiantiem >= $batdau ";
      break;
    case 2:
      // chỉ kết thúc
      $xtra []= " a.thoigiantiem <= $ketthuc ";
      break;
    case 3:
      // có bắt đầu & kết thúc
      $xtra []= " (a.thoigiantiem between $batdau and $ketthuc) ";
      break;
  }

  $xtra []= "xacnhan = 1";
  $xtra = " where ". implode(' and ', $xtra);
  
  $sql = "select a.id, c.ten as chuho, e.ten as phuong, b.micro, a.thoigiantiem as thoigian from ". PREFIX ."_tiemphong a inner join ". PREFIX ."_tiemphong_thucung b on a.idthucung = b.id inner join ". PREFIX ."_tiemphong_chuho c on b.idchu = c.id inner join ". PREFIX ."_quanly_danhmuc_giong d on b.idgiong = d.id inner join ". PREFIX ."_quanly_danhmuc_phuong e on c.idphuong = e.id $xtra order by id desc, thoigiantiem desc limit ". GIOIHAN ." offset ". ($truongloc['trang'] - 1) * GIOIHAN;
  $danhsach = $db->all($sql);

  $sql = "select count(a.id) as tong from ". PREFIX ."_tiemphong a inner join ". PREFIX ."_tiemphong_thucung b on a.idthucung = b.id inner join ". PREFIX ."_tiemphong_chuho c on b.idchu = c.id inner join ". PREFIX ."_quanly_danhmuc_giong d on b.idgiong = d.id inner join ". PREFIX ."_quanly_danhmuc_phuong e on c.idphuong = e.id $xtra";
  if (!empty($tong = $db->fetch($sql))) $tong = $tong['tong'];
  else $tong = 0;

  foreach ($danhsach as $tiemphong) {
    $xtpl->assign('id', $tiemphong['id']);
    $xtpl->assign('chuho', $tiemphong['chuho']);
    $xtpl->assign('phuong', $tiemphong['phuong']);
    $xtpl->assign('micro', $tiemphong['micro']);
    $xtpl->assign('thoigian', date('d/m/Y', $tiemphong['thoigian']));
    $xtpl->parse("main.tiemphong");
  }
  if (!count($danhsach)) $xtpl->parse('main.trong');
  $xtpl->assign('phantrang', phantrang($truongloc['trang'], $tong, GIOIHAN, 'dentrang'));
  $xtpl->parse("main");
  return $xtpl->text();
}

function danhsachxuphat() {
  global $db, $nv_Request;

	$truongloc = $nv_Request->get_array('truongloc', 'post', '');
  if (empty($truongloc['trang'])) {
    $truongloc = [
      'tenchu' => '',
      'dienthoai' => '',
      'noidung' => '',
      'phuong' => '',
      'dongphat' => 0,
      'batdau' => '',
      'ketthuc' => '',
      'trang' => 1,
    ];
  }
  $xtpl = new XTemplate("danhsachxuphat.tpl", PATH ."/xuphat/");
  // bộ lọc: tên chủ, điện thoại, tên thú cưng, micro, giống, loài, phường, thời gian tiêm
  $xtra = [];
  if (!empty($truongloc['tenchu'])) $xtra []= " c.ten like '%$truongloc[tenchu]%' ";
  if (!empty($truongloc['dienthoai'])) $xtra []= " c.dienthoai like '%$truongloc[dienthoai]%' ";
  if (!empty($truongloc['phuong'])) $xtra []= " e.id = '$truongloc[phuong]' ";
  if (!empty($truongloc['noidung'])) $xtra []= " a.noidung like '%$truongloc[noidung]%' ";
  if (!empty($truongloc['dongphat'])) {
    $truongloc['dongphat'] --;
    $xtra []= " a.dongphat = $truongloc[dongphat]";
  }

  $thoigian = 0;
  if (!empty($truongloc['batdau']) && ($batdau = chuyendoithoigian($truongloc['batdau']))) $thoigian += 1;
  if (!empty($truongloc['ketthuc']) && ($ketthuc = chuyendoithoigian($truongloc['ketthuc']))) $thoigian += 2;

  switch ($thoigian) {
    case 1:
      // chỉ bắt đầu
      $xtra []= " a.thoigianphat >= $batdau ";
      break;
    case 2:
      // chỉ kết thúc
      $xtra []= " a.thoigianphat <= $ketthuc ";
      break;
    case 3:
      // có bắt đầu & kết thúc
      $xtra []= " (a.thoigianphat between $batdau and $ketthuc) ";
      break;
  }

  if (count($xtra)) $xtra = " where ". implode(' and ', $xtra);
  else $xtra = '';

  $sql = "select a.id, a.noidung, a.mucphat, a.dongphat, a.thoigianphat, c.id as idchuho, c.ten as chuho, c.dienthoai, c.diachi, e.ten as phuong from ". PREFIX ."_xuphat a inner join ". PREFIX ."_tiemphong_chuho c on a.idchuho = c.id inner join ". PREFIX ."_quanly_danhmuc_phuong e on c.idphuong = e.id $xtra order by a.thoigianphat desc limit ". GIOIHAN ." offset ". ($truongloc['trang'] - 1) * GIOIHAN;
  $danhsach = $db->all($sql);

  $sql = "select count(c.id) as tong from ". PREFIX ."_xuphat a inner join ". PREFIX ."_tiemphong_chuho c on a.idchuho = c.id inner join ". PREFIX ."_quanly_danhmuc_phuong e on c.idphuong = e.id $xtra";
  if (!empty($tong = $db->fetch($sql))) $tong = $tong['tong'];
  else $tong = 0;

  foreach ($danhsach as $thucung) {
    $xtpl->assign('id', $thucung['id']);
    $xtpl->assign('idchuho', $thucung['idchuho']);
    $xtpl->assign('chuho', $thucung['chuho']);
    $xtpl->assign('dienthoai', $thucung['dienthoai']);
    $xtpl->assign('diachi', $thucung['diachi']);
    $xtpl->assign('phuong', $thucung['phuong']);
    $xtpl->assign('noidung', $thucung['noidung']);
    $xtpl->assign('mucphat', number_format($thucung['mucphat']));
    $xtpl->assign('ngayphat', date('d/m/Y', $thucung['thoigianphat']));
    $sql = "select * from ". PREFIX ."_xuphat_dinhkem where idxuphat = $thucung[id]";
    $danhsachdinhkem = $db->all($sql);
    foreach ($danhsachdinhkem as $dinhkem) {
      $xtpl->assign('url', $dinhkem['diachi']);
      $xtpl->parse('main.thucung.dinhkem');
    }

    if ($thucung['dongphat']) $xtpl->parse('main.thucung.datiem');
    else {
      $xtpl->parse('main.thucung.chuatiem');
      $xtpl->parse('main.thucung.dongphat');
    }
    $xtpl->parse("main.thucung");
  }
  if (!count($danhsach)) $xtpl->parse('main.trong');
  $xtpl->assign('phantrang', phantrang($truongloc['trang'], $tong, GIOIHAN, 'dentrang'));
  $xtpl->parse("main");
  return $xtpl->text();
}

function danhsachthongke() {
  global $db, $nv_Request;

	$truongloc = $nv_Request->get_array('truongloc', 'post', '');
  if (empty($truongloc['trang'])) {
    $truongloc = [
      'tenchu' => '',
      'dienthoai' => '',
      'thucung' => '',
      'micro' => '',
      'giong' => '',
      'loai' => '',
      'phuong' => '',
      'tiemphong' => 0,
      // 'batdau' => '',
      // 'ketthuc' => '',
      'trang' => 1,
    ];
  }
  $xtpl = new XTemplate("danhsachthongke.tpl", PATH ."/thongke/");
  // bộ lọc: tên chủ, điện thoại, tên thú cưng, micro, giống, loài, phường, thời gian tiêm
  $hantiemphong = time() - 365.25 * 60 * 60 * 24;
  $xtra = [];

  $phanquyen = kiemtraphanquyen();
  $danhsachphuong = kiemtraphanquyenphuong($phanquyen);
  if ($phanquyen == 2) $xtra []= 1;
  else if (empty($danhsachphuong)) $xtra []= 0;
  else $xtra [] = "(e.id in (". implode(", ", $danhsachphuong) .") )";

  if (!empty($truongloc['tenchu'])) $xtra []= " c.ten like '%$truongloc[tenchu]%' ";
  if (!empty($truongloc['dienthoai'])) $xtra []= " c.dienthoai like '%$truongloc[dienthoai]%' ";
  if (!empty($truongloc['thucung'])) $xtra []= " b.ten like '%$truongloc[thucung]%' ";
  if (!empty($truongloc['micro'])) $xtra []= " b.micro like '%$truongloc[micro]%' ";
  if (!empty($truongloc['giong'])) $xtra []= " d.giong like '%$truongloc[giong]%' ";
  if (!empty($truongloc['loai'])) $xtra []= " d.loai like '%$truongloc[loai]%' ";
  if (!empty($truongloc['phuong'])) $xtra []= " e.id = $truongloc[phuong] ";
  if (!empty($truongloc['tiemphong'])) {
    if ($truongloc['tiemphong'] == 1) $ex = ' not in ';
    else $ex = ' in ';
    $xtra []= " b.id $ex (select idthucung as id from ". PREFIX ."_tiemphong where thoigiantiem >= $hantiemphong group by idthucung) ";
  }

  $xtra []= "xacnhan = 1";
  $xtra = " where ". implode(' and ', $xtra);
  
  $sql = "select c.ten as chuho, c.diachi, e.ten as phuong, c.id from ". PREFIX ."_tiemphong_thucung b inner join ". PREFIX ."_tiemphong_chuho c on b.idchu = c.id inner join ". PREFIX ."_quanly_danhmuc_giong d on b.idgiong = d.id inner join ". PREFIX ."_quanly_danhmuc_phuong e on c.idphuong = e.id $xtra and b.ngaymat = 0 group by c.id order by c.id desc limit ". GIOIHAN ." offset ". ($truongloc['trang'] - 1) * GIOIHAN;
  $danhsach = $db->all($sql);

  $sql = "select c.id from ". PREFIX ."_tiemphong_thucung b inner join ". PREFIX ."_tiemphong_chuho c on b.idchu = c.id inner join ". PREFIX ."_quanly_danhmuc_giong d on b.idgiong = d.id inner join ". PREFIX ."_quanly_danhmuc_phuong e on c.idphuong = e.id $xtra and b.ngaymat = 0 group by c.id";
  $tong = count($db->arr($sql, "id"));

  foreach ($danhsach as $chuho) {
    $tongtiemphong = 0;
    $datiemphong = 0;
    $sql = "select * from ". PREFIX ."_tiemphong_thucung where idchu = $chuho[id] and ngaymat = 0 and xacnhan = 1";
    $danhsachthucung = $db->all($sql);
    foreach ($danhsachthucung as $thucung) {
      $sql = "select * from ". PREFIX ."_tiemphong where idthucung = $thucung[id] and thoigiantiem >= $hantiemphong";
      if (!empty($db->fetch($sql))) $datiemphong ++;
      $tongtiemphong ++;
    }

    $xtpl->assign('id', $chuho['id']);
    $xtpl->assign('chuho', $chuho['chuho']);
    $xtpl->assign('diachi', $chuho['diachi']);
    $xtpl->assign('phuong', $chuho['phuong']);
    if ($datiemphong == $tongtiemphong) $xtpl->assign('color', 'style="color: green"');
    else $xtpl->assign('color', 'style="color: red"');
    $xtpl->assign('tongtiemphong', $tongtiemphong);
    $xtpl->assign('datiemphong', $datiemphong);

    $xtpl->parse("main.thucung");
  }
  if (!count($danhsach)) $xtpl->parse('main.trong');
  $xtpl->assign('phantrang', phantrang($truongloc['trang'], $tong, GIOIHAN, 'dentrang'));
  $xtpl->parse("main");
  return $xtpl->text();
}

function dulieuthongke() {
  global $db, $nv_Request;

  $xtpl = new XTemplate("dulieuthongke.tpl", PATH ."/thongke/");

  $phanquyen = kiemtraphanquyen();
  $danhsachphuong = kiemtraphanquyenphuong($phanquyen);
  if ($phanquyen == 2) $x = 1;
  else if (empty($danhsachphuong)) $x = 0;
  else $x = "(c.id in (". implode(", ", $danhsachphuong) .") )";

  $tongthucung = 0;
  $sql = "select a.id from ". PREFIX ."_tiemphong_thucung a inner join ". PREFIX ."_tiemphong_chuho b on a.idchu = b.id inner join ". PREFIX ."_quanly_danhmuc_phuong c on b.idphuong = c.id and $x and a.ngaymat = 0 and xacnhan = 1";
  $danhsach = $db->all($sql);
  foreach ($danhsach as $thucung) {
    $tongthucung ++;
  }

  $hantiemphong = time() - 365.25 * 60 * 60 * 24;

  foreach ($danhsachphuong as $tenphuong => $idphuong) {
    $datiemphong = 0;
    $tungtiemphong = 0;
    $chuatiemphong = 0;
    $sql = "select b.id from ". PREFIX ."_tiemphong_thucung b inner join ". PREFIX ."_tiemphong_chuho c on b.idchu = c.id where c.idphuong = $idphuong and ngaymat = 0 and xacnhan = 1";
    $danhsachthucung = $db->all($sql);

    foreach ($danhsachthucung as $thucung) {
      $sql = "select thoigiantiem from ". PREFIX ."_tiemphong where idthucung = $thucung[id] order by thoigiantiem desc limit 1";
      if (!empty($tiemphong = $db->fetch($sql))) {
        if ($tiemphong['thoigiantiem'] >= $hantiemphong) $datiemphong ++;
        else $tungtiemphong ++;
      }
      else $chuatiemphong ++;
    }

    $xtpl->assign('tenphuong', $tenphuong);
    $xtpl->assign('datiemphong', $datiemphong);
    $xtpl->assign('tungtiemphong', $tungtiemphong);
    $xtpl->assign('chuatiemphong', $chuatiemphong);
    $xtpl->assign('tongthucungphuong', $datiemphong + $chuatiemphong);
    $tong = $datiemphong + $chuatiemphong;
    if ($tong == 0) $tile = 0;
    else $tile = round($datiemphong * 100 / $tong);

    $xtpl->assign('tiletiemphong', $tile);
    $xtpl->parse('main.row');
  }
  $xtpl->assign('tongthucung', $tongthucung);

  $xtpl->parse("main");
  return $xtpl->text();
}

function danhsachvatnuoi() {
  global $db, $nv_Request, $user_info, $op;

  $idchu = $user_info["userid"];
  $xtpl = new XTemplate("danhsachvatnuoi.tpl", PATH . '/vatnuoi/');

  $sql = "select * from ". PREFIX ."_users_info where userid = $idchu";
  $chuho = $db->fetch($sql);
  if (empty($chuho)) $x = 0;
  else $x = 1;

  $sql = "select * from ". PREFIX ."_tiemphong_thucung where idchu in (select id as idchu from ". PREFIX ."_tiemphong_chuho where dienthoai = '$chuho[dienthoai]' and $x)";
  $danhsachthucung = $db->all($sql);
  $homnay = strtotime(date("Y/m/d"));

  foreach ($danhsachthucung as $thucung) {
    $sql = "select thoigiantiem from ". PREFIX ."_tiemphong where idthucung = $thucung[id] order by id desc limit 1";
    $tiemphong = $db->fetch($sql);
    if (empty($tiemphong)) {
      $tiemcuoi = "-";
      $tiemphong = "Chưa tiêm";
      $color = "orange";
    }
    else {
      $tiemcuoi = date("d/m/Y", $tiemphong["thoigiantiem"]);
      $ngaytiem = strtotime(" +1 year", $tiemphong["thoigiantiem"]);
      if ($ngaytiem >= $homnay) {
        $color = "green";
        $tiemphong = date("d/m/Y", $ngaytiem);
      }
      else {
        $color = "red";
        $tiemphong = "Quá hạn tiêm";
      }
    }

    $xtpl->assign('id', $thucung['id']);
    $xtpl->assign('tenthucung', $thucung['ten']);
    $xtpl->assign('giongloai', laytengiongloai($thucung['idgiong']));
    $xtpl->assign('micro', $thucung['micro']);
    $xtpl->assign('tiemcuoi', $tiemcuoi);
    if ($thucung["xacnhan"]) $xtpl->assign('choxacnhan', "");
    else $xtpl->assign('choxacnhan', "(chờ xét duyệt)");
    $xtpl->assign('tiemphong', $tiemphong);
    $xtpl->assign('color', $color);
    $xtpl->parse("main.thucung");
  }
  if (!count($danhsachthucung)) $xtpl->parse('main.trong');
  $xtpl->assign('phantrang', phantrang($truongloc['trang'], $tong, GIOIHAN, 'dentrang'));
  $xtpl->parse("main");
  return $xtpl->text();
}

function danhsachduyet() {
  global $db, $nv_Request, $user_info, $op;

  $truongloc = $nv_Request->get_array("truongloc", "post");
  if (empty($truongloc)) $truongloc = [];
  if (empty($truongloc["trang"])) $truongloc["trang"] = 1;

  $idchu = $user_info["userid"];
  $xtpl = new XTemplate("danhsachxetduyet.tpl", PATH . '/xetduyet/');

  $phanquyen = kiemtraphanquyen();
  $danhsachphuong = kiemtraphanquyenphuong($phanquyen);
  if ($phanquyen == 2) $x = 1;
  else if (empty($danhsachphuong)) $x = 0;
  else $x = "(c.id in (". implode(", ", $danhsachphuong) .") )";

  $sql = "select a.id, a.noidung, c.ten, c.dienthoai, c.diachi from ". PREFIX ."_quanly_xetduyet a inner join ". PREFIX ."_tiemphong_chuho c on a.idchu = c.id where a.trangthai = 0 order by a.thoigian asc limit ". GIOIHAN . " offset ". ($truongloc["trang"] - 1) * GIOIHAN;
  $danhsach = $db->all($sql);

  $sql = "select a.id from ". PREFIX ."_quanly_xetduyet a inner join ". PREFIX ."_tiemphong_chuho c on a.idchu = c.id where a.trangthai = 0";
  $tong = count($db->arr($sql, "id"));

  foreach ($danhsach as $xetduyet) {
    $xtpl->assign("id", $xetduyet["id"]);
    $xtpl->assign("chuho", $xetduyet["ten"]);
    $xtpl->assign("dienthoai", $xetduyet["dienthoai"]);
    $xtpl->assign("diachi", $xetduyet["diachi"]);
    $xtpl->assign("noidung", $xetduyet["noidung"]);
    $xtpl->parse("main.danhsach");
  }

  if (!count($danhsach)) $xtpl->parse("main.trong");
  $xtpl->assign('phantrang', phantrang($truongloc['trang'], $tong, GIOIHAN, 'dentrang'));
  $xtpl->parse("main");
  return $xtpl->text();
}

function sidemenu() {
  global $db, $nv_Request, $user_info, $op;

  $xtpl = new XTemplate("sidemenu.tpl", PATH);
  $phanquyen = kiemtraphanquyen();
  $danhsachchucnang = ['thanhvien', 'tiemphong', 'thongke', 'nguoidung', 'danhmuc', 'xuphat', 'vatnuoi', 'xetduyet', 'dispatch'];
  if (in_array($op, $danhsachchucnang) !== false) $chucnang = $op;
  else $chucnang = 'main';
  $xtpl->assign($chucnang, 'active');
  $xtpl->assign('banner', laybanner());
  
  $sql = "select * from ". PREFIX ."_users where userid = $user_info[userid]";
  $nhanvien = $db->fetch($sql);
  $xtpl->assign('nhanvien', $nhanvien['first_name']);

  $quyen = [0 => 'Thành viên', 'Nhân viên', 'Quản lý'];
  $sql = "select * from ". PREFIX ."_phanquyen where userid = $user_info[userid]";
  if (empty($quyennhanvien = $db->fetch($sql))) $quyennhanvien = 0;
  else $quyennhanvien = $quyennhanvien['quyen'];
  $xtpl->assign('chucvu', $quyen[$quyennhanvien]);

  if ($phanquyen >= 0) $xtpl->parse("main.thanhvien");
  if ($phanquyen == 0) $xtpl->parse("main.thanhvien2");
  if ($phanquyen >= 1) $xtpl->parse("main.nhanvien");
  if ($phanquyen == 2) $xtpl->parse("main.quanly");
  $xtpl->parse('main');
  return $xtpl->text();
}

function phantrang($trang, $tong, $gioihan, $chucnang = '') {
  $xtpl = new XTemplate('phantrang.tpl', PATH);
  $tongtrang = floor($tong / $gioihan) + (fmod($tong, $gioihan) ? 1 : 0);
  if ($tongtrang < 1) $tongtrang = 1;
  
  $danhsachtrang = [];
  $danhsachtrang[1] = 1;
  $danhsachtrang[2] = 1;
  $danhsachtrang[3] = 1;
  $danhsachtrang[$trang - 2] = 1;
  $danhsachtrang[$trang - 1] = 1;
  $danhsachtrang[$trang] = 1;
  $danhsachtrang[$trang + 1] = 1;
  $danhsachtrang[$trang + 2] = 1;
  $danhsachtrang[$tongtrang - 2] = 1;
  $danhsachtrang[$tongtrang - 1] = 1;
  $danhsachtrang[$tongtrang] = 1;

  ksort($danhsachtrang);
  $trangtruoc = 0;
  $xtpl->assign('hientai', $trang);
  foreach ($danhsachtrang as $sotrang => $value) {
    if ($sotrang <= 0 || $sotrang > $tongtrang) continue;
    if ($trang == $sotrang) $xtpl->assign('active', 'btn-info');
    else {
      if ($trangtruoc && (($sotrang - $trangtruoc) > 2)) {
        $xtpl->assign('active', 'btn-default');
        $xtpl->assign('chucnang', '');
        $xtpl->assign('trang', "...");
        $xtpl->parse('main.row');
      }
      $xtpl->assign('active', 'btn-default');
      if (!empty($chucnang)) $xtpl->assign('chucnang', 'onclick="'. $chucnang .'('. $sotrang .')"');
      else $xtpl->assign('chucnang', '');
    }
    $xtpl->assign('trang', $sotrang);
    $trangtruoc = $sotrang;
    $xtpl->parse('main.row');
  }

  if (!empty($chucnang)) {
    $xtpl->assign('func', 'let trang = $("#dentrang").val(); if (trang < 1 || trang > '.$tongtrang.') return vhttp.notify("Vượt quá giới hạn trang"); '. $chucnang . '(trang);');
  }
  else $xtpl->assign('func', 'return 0;');

  // for ($i = 1; $i <= $tongtrang; $i++) {
  //   if ($trang == $i) $xtpl->assign('active', 'btn-info');
  //   else $xtpl->assign('active', 'btn-default');
  //   if (!empty($chucnang)) $xtpl->assign('chucnang', 'onclick="'. $chucnang .'('. $i .')"');
  //   else $xtpl->assign('chucnang', '');
  //   $xtpl->assign('trang', $i);
  //   $xtpl->parse('main.row');
  // }
  $xtpl->parse('main');
  return $xtpl->text();
}

function danhsachchitietchunuoi() {
  global $db, $nv_Request;

  $idchu = $nv_Request->get_string("idchu", "post");
	$sql = "select a.*, b.giong, b.loai from ". PREFIX ."_tiemphong_thucung a inner join ". PREFIX ."_quanly_danhmuc_giong b on a.idgiong = b.id where idchu = $idchu and ngaymat = 0 and xacnhan = 1";
	$danhsachthucung = $db->all($sql);
  $hantiemphong = time() - 365.25 * 60 * 60 * 24;

  $xtpl = new XTemplate("danhsachthucung.tpl", PATH ."/thongke/");
	foreach ($danhsachthucung as $thucung) {
    $sql = "select * from ". PREFIX ."_tiemphong where idthucung = $thucung[id] order by thoigiantiem desc limit 1";
    if (empty($tiemphong = $db->fetch($sql))) {
      $tiemcuoi = "Chưa tiêm phòng";
      $color = "style='color: red'";
    }
    else {
      $tiemcuoi = date("d/m/Y", $tiemphong["thoigiantiem"]);
      if ($tiemphong["thoigiantiem"] >= $hantiemphong) $color = "style='color: green'";
      else $color = "style='color: red'";
    }

    $xtpl->assign("id", $thucung["id"]);
    $xtpl->assign("tenthucung", $thucung["ten"]);
    $xtpl->assign("micro", $thucung["micro"]);
    $xtpl->assign("giongloai", $thucung["loai"]. " " .$thucung["giong"]);
    $xtpl->assign("ngaysinh", ($thucung["ngaysinh"] ? date("d/m/Y", $thucung["ngaysinh"]) : "-"));
    $xtpl->assign("tiemcuoi", $tiemcuoi);
    $xtpl->parse("main.thucung");
	}

  if (!count($danhsachthucung)) $xtpl->parse("main.trong");

  $xtpl->parse("main");
  return $xtpl->text();
}
