<?php

if (!defined('NV_MAINFILE')) {
  exit('Stop!!!');
}

if (!nv_function_exists('sidemenu')) {
  function sidemenu() {
    global $db, $nv_Cache, $site_mods, $global_config, $lang_global, $op, $_SESSION;
    
    $menu = array(
      '' => 'overview',
      'main' => 'overview',
      'item' => 'item',
      'purchase' => 'purchase',
      'source' => 'source',
      'customer' => 'customer',
      'bill' => 'bill',
      'cash' => 'cash',
      'statistic' => 'statistic',
      'setting' => 'overview',
    );
    $xtpl = new XTemplate('sidemenu.tpl', UPATH);
    if (!empty($menu[$op])) $m = $menu[$op];
    else $m = 'overview';
    $xtpl->assign($m, 'active');
    $sql = "select a.* from pet_users a inner join pet_users_session b on a.userid = b.userid and b.session = '$_SESSION[session]'";
    $nhanvien = $db->fetch($sql);

    // kiểm tra đường dẫn hiện tại hiển thị active menu
    $xtpl->assign('nhanvien', $nhanvien['first_name']);
    $xtpl->parse('main');
    return $xtpl->text();
  }
}

if (defined('NV_SYSTEM')) {
  $content = sidemenu();
}
