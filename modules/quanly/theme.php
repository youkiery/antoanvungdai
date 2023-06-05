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

function danhsachphuong() {
  global $db;

  $xtpl = new XTemplate("danhsachphuong.tpl", PATH ."/danhmuc/");

  $sql = "select * from ". PREFIX ."_danhmuc_phuong where kichhoat = 1 order by ten asc";
  $danhsach = $db->all($sql);

  foreach ($danhsach as $phuong) {
    $xtpl->assign('id', $phuong['id']);
    $xtpl->assign('ten', $phuong['ten']);
    $xtpl->parse("main.phuong");
  }
  if (!count($danhsach)) $xtpl->parse('main.trong');
  $xtpl->parse("main");
  return $xtpl->text();
}

function danhsachgiong() {
  global $db;

  $xtpl = new XTemplate("danhsachgiong.tpl", PATH ."/danhmuc/");

  $sql = "select * from ". PREFIX ."_danhmuc_giong where kichhoat = 1 order by loai asc, giong asc";
  $danhsach = $db->all($sql);

  foreach ($danhsach as $giong) {
    $xtpl->assign('id', $giong['id']);
    $xtpl->assign('giong', $giong['giong']);
    $xtpl->assign('loai', $giong['loai']);
    $xtpl->parse("main.giong");
  }
  if (!count($danhsach)) $xtpl->parse('main.trong');
  $xtpl->parse("main");
  return $xtpl->text();
}

function danhsachthanhvien() {
  global $db;

  $xtpl = new XTemplate("danhsachthanhvien.tpl", PATH ."/thanhvien/");

  $sql = "select * from ". PREFIX ."_users where active = 1 order by userid desc";
  $danhsach = $db->all($sql);

  foreach ($danhsach as $user) {
    $xtpl->assign('userid', $user['userid']);
    $xtpl->assign('username', $user['username']);
    $xtpl->assign('first_name', $user['first_name']);
    $xtpl->parse("main.user");
  }
  if (!count($danhsach)) $xtpl->parse('main.trong');
  $xtpl->parse("main");
  return $xtpl->text();
}

function danhsachxetduyet() {
  global $db;

  $xtpl = new XTemplate("danhsachxetduyet.tpl", PATH ."/thanhvien/");

  $sql = "select * from ". PREFIX ."_users where active = 0 order by userid desc";
  $danhsach = $db->all($sql);

  foreach ($danhsach as $user) {
    $xtpl->assign('userid', $user['userid']);
    $xtpl->assign('username', $user['username']);
    $xtpl->assign('first_name', $user['first_name']);
    $xtpl->parse("main.user");
  }
  if (!count($danhsach)) $xtpl->parse('main.trong');
  $xtpl->parse("main");
  return $xtpl->text();
}