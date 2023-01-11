<?php

if (!defined('NV_MAINFILE')) {
  exit('Stop!!!');
}

if (!nv_function_exists('sidemenu')) {
  function sidemenu() {
    global $db, $nv_Cache, $site_mods, $global_config, $lang_global, $op, $_SESSION;
    
    $xtpl = new XTemplate('sidemenu.tpl', UPATH);

    $menu = array(
      '' => 'overview',
      'main' => 'overview',
    );
    if (quyennhanvien(2) || quyennhanvien(21) || quyennhanvien(211)) $menu['item'] = 'item';
    if (quyennhanvien(33) || quyennhanvien(331)) $menu['purchase'] = 'purchase';
    if (quyennhanvien(45) || quyennhanvien(451)) $menu['source'] = 'source';
    if (quyennhanvien(41) || quyennhanvien(411)) $menu['customer'] = 'customer';
    if (quyennhanvien(32) || quyennhanvien(321)) $menu['bill'] = 'bill';
    if (quyennhanvien(6) || quyennhanvien(61)) $menu['cash'] = 'cash';
    if (quyennhanvien(5) || quyennhanvien(51)) $menu['statistic'] = 'statistic';
    if (quyennhanvien(121) || quyennhanvien(12)) $menu['setting'] = 'overview';
    if (quyennhanvien(1) || quyennhanvien(11) || quyennhanvien(12)) $xtpl->parse('main.caidat');
    if (quyennhanvien(31) || quyennhanvien(311)) $xtpl->parse('main.banhang');

    if (!empty($menu[$op])) $m = $menu[$op];
    else $m = 'overview';
    $xtpl->assign($m, 'active');
    $sql = "select a.* from pet_users a inner join pet_users_session b on a.userid = b.userid and b.session = '$_SESSION[session]'";
    $nhanvien = $db->fetch($sql);

    $dahien = [];
    foreach ($menu as $sidename) {
      if (empty($dahien[$sidename])) {
        $dahien[$sidename] = 1;
        $xtpl->parse('main.'. $sidename);
      }
    }

    // kiểm tra đường dẫn hiện tại hiển thị active menu
    $xtpl->assign('nhanvien', $nhanvien['first_name']);
    $xtpl->parse('main');
    return $xtpl->text();
  }
}

if (defined('NV_SYSTEM')) {
  $content = sidemenu();
}
