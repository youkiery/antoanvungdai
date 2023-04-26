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
define('BUILDER_INSERT_NAME', 0);
define('BUILDER_INSERT_VALUE', 1);
define('BUILDER_EDIT', 2);

if (!empty($_SERVER['HTTP_CLIENT_IP'])) $ip = $_SERVER['HTTP_CLIENT_IP'];
elseif (!empty($_SERVER['HTTP_X_FORWARDED_FOR'])) $ip = $_SERVER['HTTP_X_FORWARDED_FOR'];
else $ip = $_SERVER['REMOTE_ADDR'];

$page_title = "Gửi thông tin thú cưng";

function registerList() {
  global $db, $ip;
  $sql = 'select * from `pet_news_newinfo`';
  $query = $db->query($sql);
  $xtpl = new XTemplate("list.tpl", PATH2);
  while ($row = $query->fetch()) {
    $xtpl->assign('id', $row['id']);
    $xtpl->assign('name', $row['petname']);
    $xtpl->assign('breed', $row['petbreed']);
    $xtpl->assign('birthday', $row['petbirthday']);
    $xtpl->assign('sex', $row['petsex']);
    $xtpl->assign('microchip', $row['petmicro']);
    $xtpl->parse('main.row');
  }

  $xtpl->parse('main');
  return $xtpl->text();
}

$action = $nv_Request->get_string('action', 'post', '');
if (!empty($action)) {
  $result = array('status' => 0);
  switch ($action) {
    case 'insert':
      $data = $nv_Request->get_array('data', 'post');

      $sql = 'insert into `pet_news_newinfo` (ip, name, birthday, phone, address, petname, petbirthday, petbreed, petsex, petcolor, petmicro, petbreeder, time) values("'. $ip .'", "'. $data['name'] .'", "'. $data['birthday'] .'", "'. $data['phone'] .'", "'. $data['address'] .'", "'. $data['petname'] .'", "'. $data['petbirthday'] .'", "'. $data['petbreed'] .'", "'. $data['petsex'] .'", "'. $data['petcolor'] .'", "'. $data['petmicro'] .'", "'. $data['petbreeder'] .'", '. time() .')';
      $db->query($sql);

      $result['status'] = 1;
      $result['html'] = registerList();
    break;
    case 'print':
      $id = $nv_Request->get_int('id', 'post', 0);

      $sql = 'select name, birthday, phone, address, petname, petbirthday, petbreed, petsex, petcolor, petmicro, petbreeder, time from pet_news_newinfo where id = '. $id;
      $query = $db->query($sql);
      $info = $query->fetch();

      include 'vendor/autoload.php';
      $templateProcessor = new \PhpOffice\PhpWord\TemplateProcessor(NV_ROOTDIR . '/assets/newinfo.docx');
      foreach ($info as $key => $value) {
        $templateProcessor->setValue($key, $value);
      }
      $templateProcessor->setValue('day', date('d', $info['time']));
      $templateProcessor->setValue('month', date('m', $info['time']));
      $templateProcessor->setValue('year', date('Y', $info['time']));
      $templateProcessor->saveAs(NV_ROOTDIR . '/assets/newinfo-temp.docx');
      $result['status'] = 1;
      $result['time'] = time();
    break;
  }
  echo json_encode($result);
  die();
}

$xtpl = new XTemplate("main.tpl", PATH2);

$xtpl->assign('list', registerList());
$xtpl->parse("main");
$contents = $xtpl->text("main");
include ("modules/". $module_file ."/layout/header.php");
echo $contents;
include ("modules/". $module_file ."/layout/footer.php");
