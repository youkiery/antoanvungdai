<?php

if (!defined('NV_IS_MOD_NEWS')) {
  exit('Stop!!!');
}
$page_title = $lang_module['title'];

if (!(quyennguoidung(32) || quyennguoidung(321))) $contents = 'Tài khoản không có quyền xem mục này';
else {
  $xtpl = new XTemplate('main.tpl', PATH);
  $sql = "select * from pos_phanloai where module = 'hanghoa' and kichhoat = 1 order by thutu asc, id asc";
  $loaihang = $db->all($sql);

  $sql = "select * from pos_nguoncung where kichhoat = 1 order by ten asc";
  $nguoncung = $db->all($sql);

  $sql = "select sum(tongtien) as tongno from pos_nhaphang where thanhtoan = 0";
  $tongno = $db->query($sql)->fetch()['tongno'];

  $xtpl->assign('nguoncung', option($nguoncung, 'ten', 'id'));
  $xtpl->assign('loaihang', option($loaihang, 'ten', 'id'));
  $xtpl->assign('batdau', date('01/m/Y'));
  $xtpl->assign('ketthuc', date('t/m/Y'));
  $xtpl->assign('tongno', number_format($tongno));
  if ($tongno) $xtpl->parse('main.tongno');
  $xtpl->assign('danhsach', danhsachnhaphang());
  $xtpl->parse('main');
  $contents = $xtpl->text();
}

include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
