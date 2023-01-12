<?php

if (!defined('NV_IS_MOD_NEWS')) {
  exit('Stop!!!');
}
$page_title = $lang_module['title'];

if (!(quyennhanvien(1) || quyennhanvien(11) || quyennhanvien(12) || quyennhanvien(126)))  $contents = 'Tài khoản không có quyền xem mục này';
else {
  $xtpl = new XTemplate('main.tpl', PATH);
  if (quyennhanvien(111) || quyennhanvien(11)) {
    if (quyennhanvien(112)) $xtpl->parse('main.mauin.sua');

    $sql = "select * from pos_cauhinh where module = 'mauhoadon'";
    if (empty($cauhinh = $db->fetch($sql))) {
      $sql = "insert into pos_cauhinh (module, giatri) values('mauhoadon', '')";
      $db->query($sql);
      $cauhinh = ['giatri' => ''];
    }

    $xtpl->assign('mauin', $cauhinh['giatri']);
    $xtpl->parse('main.mauin');
  }

  if (quyennhanvien(121) || quyennhanvien(12)) {
    if (quyennhanvien(121)) $xtpl->parse('main.nhanvien.them');
    if (quyennhanvien(125)) $xtpl->parse('main.nhanvien.export');

    $xtpl->assign('homnay', date('d/m/Y'));
    $xtpl->assign('danhsach', danhsachnhanvien());
    $xtpl->parse('main.nhanvien');
  }

  $xtpl->parse('main');
  $contents = $xtpl->text();
}

include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
