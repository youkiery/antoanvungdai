<?php

if (!defined('NV_IS_MOD_NEWS')) {
  exit('Stop!!!');
}
$page_title = $lang_module['title'];

if (!(quyennhanvien(2) || quyennhanvien(21) || quyennhanvien(211))) $contents = 'Tài khoản không có quyền xem mục này';
else {
  $xtpl = new XTemplate('main.tpl', PATH);
  $sql = "select * from pos_phanloai where module = 'hanghoa' and kichhoat = 1 order by thutu asc, id asc";
  $loaihang = $db->all($sql);
  
  $xtpl->assign('loaihang', option($loaihang, 'ten', 'id'));
  $xtpl->assign('danhsachhang', danhsachhang());
  $xtpl->parse('main.danhsach');
  $xtpl->parse('main.danhsach2');

  if (quyennhanvien(212)) $xtpl->parse('main.them');
  if (quyennhanvien(216)) $xtpl->parse('main.import');
  if (quyennhanvien(217)) $xtpl->parse('main.export');

  $xtpl->parse('main');
  $contents = $xtpl->text();
} 

include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
