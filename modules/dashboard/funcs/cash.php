<?php

if (!defined('NV_IS_MOD_NEWS')) {
  exit('Stop!!!');
}
$page_title = $lang_module['title'];

$xtpl = new XTemplate('main.tpl', PATH);

$sql = "select * from pos_loaithuchi where loai = 0 order by id";
$danhsachloaithu = $db->all($sql);

$sql = "select * from pos_loaithuchi where loai = 1 order by id";
$danhsachloaichi = $db->all($sql);

$xtpl->assign('loaithu', option($danhsachloaithu, 'ten', 'id'));
$xtpl->assign('loaichi', option($danhsachloaichi, 'ten', 'id'));

$xtpl->assign('batdau', date('d/m/Y'));
$xtpl->assign('ketthuc', date('d/m/Y'));
$xtpl->assign('danhsach', danhsachthuchi());
$xtpl->parse('main');
$contents = $xtpl->text();

include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
