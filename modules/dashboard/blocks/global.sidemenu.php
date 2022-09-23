<?php

if (!defined('NV_MAINFILE')) {
  exit('Stop!!!');
}

if (!nv_function_exists('sidemenu')) {
  function sidemenu() {
    global $nv_Cache, $site_mods, $global_config, $lang_global, $op;
    
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
    );
    $xtpl = new XTemplate('sidemenu.tpl', UPATH);
    if (!empty($menu[$op])) $m = $menu[$op];
    else $m = 'overview';
    $xtpl->assign($m, 'active');

    // kiểm tra đường dẫn hiện tại hiển thị active menu
    $xtpl->parse('main');
    return $xtpl->text();
  }
}

if (defined('NV_SYSTEM')) {
  $content = sidemenu();
}
