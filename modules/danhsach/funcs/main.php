<?php

/**
 * @Project Petcoffee-tech
 * @Chistua (hchieuthua@gmail.com)
 * @Copyright (C) 2019
 * @Createdate 21-03-2019 13:15
 */

if (!defined('NV_IS_FORM')) {
	die('Stop!!!');
}

$tieude = laytieude();

$xtpl = new XTemplate("main.tpl", PATH);
$xtpl->assign('module_file', $module_file);

$xtpl->assign('content', noidungtrangchinh());
$xtpl->parse("main");
$contents = $xtpl->text("main");

include NV_ROOTDIR . '/includes/header.php';
echo $contents;
include NV_ROOTDIR . '/includes/footer.php';

