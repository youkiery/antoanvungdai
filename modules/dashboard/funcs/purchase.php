<?php

if (!defined('NV_IS_MOD_NEWS')) {
  exit('Stop!!!');
}
$page_title = $lang_module['title'];

$xtpl = new XTemplate('main.tpl', PATH);

$sql = "select * from pos_phanloai where module = 'hanghoa' and kichhoat = 1 order by thutu asc, id asc";
$loaihang = $db->all($sql);

$sql = "select * from pos_nguoncung where kichhoat = 1 order by ten asc";
$nguoncung = $db->all($sql);

$xtpl->assign('nguoncung', option($nguoncung, 'ten', 'id'));
$xtpl->assign('loaihang', option($loaihang, 'ten', 'id'));
$xtpl->assign('batdau', date('01/m/Y'));
// $xtpl->assign('ketthuc', date('d/m/Y', strtotime(date('Y') .'/'. (date('m') + 1) . '/1') - 1));
$xtpl->assign('ketthuc', date('t/m/Y'));
$xtpl->assign('danhsach', danhsachnhaphang());
$xtpl->parse('main');
$contents = $xtpl->text();

include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
