<?php

/**
 * @Project Petcoffee-tech
 * @Chistua (hchieuthua@gmail.com)
 * @Copyright (C) 2019
 * @Createdate 21-03-2019 13:15
 */

if (!defined('NV_ADMIN') or !defined('NV_MAINFILE')) {
  die('Stop!!!');
}

$module_version = array(
    'name' => 'Quản lý tiêm phòng',
    'modfuncs' => 'main,api,danhmuc,nguoidung,thanhvien,thongke,xuphat,tiemphong,vatnuoi,xetduyet',
    'submenu' => 'main,api,danhmuc,nguoidung,thanhvien,thongke,xuphat,tiemphong,vatnuoi,xetduyet',
    'is_sysmod' => 1,
    'virtual' => 1,
    'version' => '4.3.04',
    'date' => 'Thusday, March 21, 2019 13:15:00 AM GMT+07:00',
    'author' => 'Chistua <hchieuthua@gmail.com>',
    'note' => ''
);
