<?php

if (!defined('NV_MAINFILE')) {
  exit('Stop!!!');
}

function datetotime($thoigian) {
  $thoigian = explode('/', $thoigian);
  return strtotime("$thoigian[2]/$thoigian[1]/$thoigian[0]");
}

function parseimage($image) {
  $l = array();
  foreach ($image as $key => $value) {
    if (!empty($value)) $l []= $value;
  }
  return implode(',', $l);
}

function fillzero($number) {
  $number = strval($number);
  $zerolength = 8 - strlen($number);
  for ($i = 0; $i < $zerolength; $i++) { 
    $number = '0' . $number;
  }
  return $number;
}

function checkuserid() {
  global $_SESSION, $db;

  $session = $_SESSION['session'];
  $sql = "select * from pet_users_session where session = '$session'";
  $dulieuphien = $db->fetch($sql);
  if (empty($dulieuphien)) return '0';
  return $dulieuphien['userid'];
}