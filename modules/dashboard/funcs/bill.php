<?php

if (!defined('NV_IS_MOD_NEWS')) {
  exit('Stop!!!');
}
$page_title = $lang_module['title'];

if (!(quyennhanvien(321))) $contents = 'Tài khoản không có quyền xem mục này';
else {
  $xtpl = new XTemplate('main.tpl', PATH);
  $dauthang = date('01/m/Y');
  $cuoithang = date('t/m/Y');
  
  if (quyennhanvien(325)) $xtpl->parse('main.import');
  if (quyennhanvien(326)) $xtpl->parse('main.export');

  $xtpl->assign('dauthang', $dauthang);
  $xtpl->assign('cuoithang', $cuoithang);
  $xtpl->assign('tuychonnhanvien', tuychonnhanvien());
  $xtpl->assign('danhsach', danhsachhoadon());
  $xtpl->parse('main');
  $contents = $xtpl->text();
}

include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
