<?php

if (!defined('NV_ADMIN') or !defined('NV_MAINFILE') or !defined('NV_IS_MODADMIN')) {
    exit('Stop!!!');
}

define('PATH', NV_ROOTDIR . '/modules/'. $module_file . '/template/admin/'. $op);