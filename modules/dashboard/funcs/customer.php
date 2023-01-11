<?php

if (!defined('NV_IS_MOD_NEWS')) {
  exit('Stop!!!');
}
$page_title = $lang_module['title'];

if (!(quyennhanvien(41) || quyennhanvien(411))) $contents = 'Tài khoản không có quyền xem mục này';
else {
  $xtpl = new XTemplate('main.tpl', PATH);
  $xtpl->assign('danhsach', danhsachkhach());

  if (quyennhanvien(412)) $xtpl->parse('main.them');
  if (quyennhanvien(416)) $xtpl->parse('main.import');
  if (quyennhanvien(417)) $xtpl->parse('main.export');

  $xtpl->parse('main');
  $contents = $xtpl->text();
}

include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
