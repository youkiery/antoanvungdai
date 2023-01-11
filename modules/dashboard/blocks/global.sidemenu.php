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
    if (quyennguoidung(2) || quyennguoidung(21) || quyennguoidung(211)) $menu['item'] = 'item';
    if (quyennguoidung(32) || quyennguoidung(321)) $menu['purchase'] = 'purchase';
    if (quyennguoidung(45) || quyennguoidung(451)) $menu['source'] = 'source';
    if (quyennguoidung(41) || quyennguoidung(411)) $menu['customer'] = 'customer';
    if (quyennguoidung(31) || quyennguoidung(311)) $menu['bill'] = 'bill';
    if (quyennguoidung(6) || quyennguoidung(61)) $menu['cash'] = 'cash';
    if (quyennguoidung(5) || quyennguoidung(51)) $menu['statistic'] = 'statistic';
    if (quyennguoidung(121) || quyennguoidung(12)) $menu['setting'] = 'overview';

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
