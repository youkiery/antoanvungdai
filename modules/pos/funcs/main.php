<?php

if (!defined('NV_IS_MOD_NEWS')) {
  exit('Stop!!!');
}
$page_title = $lang_module['title'];

if (!(quyennhanvien(31) || quyennhanvien(311))) $contents = 'Tài khoản không có quyền xem mục này';
else {
  $xtpl = new XTemplate('main.tpl', PATH);
  $sql = "select userid, first_name from pet_users order by userid desc";
  $danhsachnhanvien = $db->all($sql);
  
  $sql = "select userid from pet_users_session where session = '$_SESSION[session]'";
  $session = $db->fetch($sql);
  
  $xtpl->assign('thoigian', date('d/m/Y H:i'));
  $xtpl->assign('idnhanvien', $session['userid']);
  $xtpl->assign('danhsachnhanvien', option($danhsachnhanvien, 'first_name', 'userid'));
  if (quyennhanvien(311)) {
    $xtpl->parse('main.thanhtoan');
    $xtpl->parse('main.thanhtoan2');
  }
  if (quyennhanvien(412)) {
    $xtpl->parse('main.themkhach');
    $xtpl->parse('main.themkhach2');
  }
  if (quyennhanvien(413)) $xtpl->parse('main.suakhach');
  if (quyennhanvien(315)) $xtpl->parse('main.giamgia');
  if (!quyennhanvien(316)) $xtpl->assign('suanguoiban', 'disabled');

  $cauhinh = [
    'dongia' => quyennhanvien(313),
    'giaban' => quyennhanvien(314),
    'giamgia' => quyennhanvien(315),
  ];

  foreach ($cauhinh as $ten => $giatri) {
    $xtpl->assign('cauhinh'. $ten, $ten);
    $xtpl->assign('giatricauhinh'. $ten, intval($giatri));
  }

  $xtpl->parse('main');
  $contents = $xtpl->text();
}

include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
