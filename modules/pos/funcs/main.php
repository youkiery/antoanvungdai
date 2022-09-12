<?php

if (!defined('NV_IS_MOD_NEWS')) {
  exit('Stop!!!');
}
$page_title = $lang_module['title'];

$xtpl = new XTemplate('main.tpl', PATH);

$sql = "select userid, first_name from pet_users order by userid desc";
$danhsachnhanvien = $db->all($sql);

$sql = "select userid from pet_users_session where session = '$_SESSION[session]'";
$session = $db->fetch($sql);

$xtpl->assign('idnhanvien', $session['userid']);
$xtpl->assign('danhsachnhanvien', option($danhsachnhanvien, 'first_name', 'userid'));
$xtpl->parse('main');
$contents = $xtpl->text();

include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
