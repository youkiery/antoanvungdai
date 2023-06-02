<?php

/**
 * @Project Petcoffee-tech
 * @Chistua (hchieuthua@gmail.com)
 * @Copyright (C) 2019
 * @Createdate 21-03-2019 13:15
 */

if (! defined('NV_ADMIN') or ! defined('NV_MAINFILE') or ! defined('NV_IS_MODADMIN')) {
  die('Stop!!!');
}

define('NV_IS_ADMIN_FORM', true);
define("PREFIX", $db_config['prefix'] . "_" . $module_name);
define("PATH", NV_ROOTDIR . '/modules/' . $module_file . '/template/admin/' . $op);
define("PATHER", NV_ROOTDIR . '/modules/' . $module_file . '/template/admin/');
