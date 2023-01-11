<?php

if (!defined('NV_IS_MOD_NEWS')) {
  exit('Stop!!!');
}
$page_title = $lang_module['title'];

if (!quyennguoidung(1))  $contents = 'Tài khoản không có quyền xem mục này';
else {
  $xtpl = new XTemplate('main.tpl', PATH);
  if (quyennguoidung(111) || quyennguoidung(11)) {
    if (quyennguoidung(112)) $xtpl->parse('main.mauin.sua');

    $sql = "select * from pos_cauhinh where module = 'mauhoadon'";
    if (empty($cauhinh = $db->fetch($sql))) {
      $sql = "insert into pos_cauhinh (module, giatri) values('mauhoadon', '')";
      $db->query($sql);
      $cauhinh = ['giatri' => ''];
    }

    $xtpl->assign('mauin', $cauhinh['giatri']);
    $xtpl->parse('main.mauin');
  }

  if (quyennguoidung(121) || quyennguoidung(12)) {
    if (quyennguoidung(121)) $xtpl->parse('main.nhanvien.them');
    if (quyennguoidung(125)) $xtpl->parse('main.nhanvien.export');

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
