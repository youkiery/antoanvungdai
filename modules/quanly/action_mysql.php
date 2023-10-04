<?php

/**
 * @Project Petcoffee-tech
 * @Chistua (hchieuthua@gmail.com)
 * @Copyright (C) 2019
 * @Createdate 21-03-2019 13:15
 */

if (!defined('NV_IS_FILE_MODULES')) {
    die('Stop!!!');
}

define("PREFIX", $db_config['prefix'] . "_" . $module_name);

$sql_drop_module = array();
// $sql_drop_module[] = "DROP TABLE IF EXISTS pet_quanly_danhmuc_giong";
// $sql_drop_module[] = "DROP TABLE IF EXISTS pet_quanly_danhmuc_phuong";
// $sql_drop_module[] = "DROP TABLE IF EXISTS pet_phanquyen";
// $sql_drop_module[] = "DROP TABLE IF EXISTS pet_phanquyen_chitiet";
// $sql_drop_module[] = "DROP TABLE IF EXISTS pet_tiemphong";
// $sql_drop_module[] = "DROP TABLE IF EXISTS pet_tiemphong_chuho";
// $sql_drop_module[] = "DROP TABLE IF EXISTS pet_tiemphong_chuho_lienket";
// $sql_drop_module[] = "DROP TABLE IF EXISTS pet_tiemphong_thucung";
// $sql_drop_module[] = "DROP TABLE IF EXISTS pet_xuphat";
// $sql_drop_module[] = "DROP TABLE IF EXISTS pet_xuphat_dinhkem";

// $sql_create_module = $sql_drop_module;
// $sql_create_module[]= "CREATE TABLE `pet_quanly_danhmuc_giong` (
//     `id` int(11) NOT NULL AUTO_INCREMENT,
//     `giong` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
//     `loai` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
//     `kichhoat` int(11) NOT NULL DEFAULT 1,
//     PRIMARY KEY (`id`)
//    ) ENGINE=MyISAM AUTO_INCREMENT=320 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci";
// $sql_create_module[]= "CREATE TABLE `pet_quanly_danhmuc_phuong` (
//     `id` int(11) NOT NULL AUTO_INCREMENT,
//     `ten` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
//     `kichhoat` int(11) NOT NULL DEFAULT 1,
//     PRIMARY KEY (`id`)
//    ) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci";
// $sql_create_module[]= "CREATE TABLE `pet_phanquyen` (
//     `id` int(11) NOT NULL AUTO_INCREMENT,
//     `userid` int(11) NOT NULL,
//     `quyen` int(11) NOT NULL,
//     PRIMARY KEY (`id`)
//    ) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci";
// $sql_create_module[]= "CREATE TABLE `pet_phanquyen_chitiet` (
//     `id` int(11) NOT NULL AUTO_INCREMENT,
//     `userid` int(11) NOT NULL,
//     `idphuong` int(11) NOT NULL,
//     PRIMARY KEY (`id`)
//    ) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci";
// $sql_create_module[]= "CREATE TABLE `pet_tiemphong` (
//     `id` int(11) NOT NULL AUTO_INCREMENT,
//     `idthucung` int(11) NOT NULL,
//     `thoigiantiem` int(11) NOT NULL,
//     `thoigiannhac` int(11) NOT NULL,
//     PRIMARY KEY (`id`)
//    ) ENGINE=MyISAM AUTO_INCREMENT=269 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci";
// $sql_create_module[]= "CREATE TABLE `pet_tiemphong_chuho` (
//     `id` int(11) NOT NULL AUTO_INCREMENT,
//     `idphuong` int(11) NOT NULL,
//     `ten` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
//     `dienthoai` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
//     `diachi` varchar(300) COLLATE utf8mb4_unicode_ci NOT NULL,
//     PRIMARY KEY (`id`)
//    ) ENGINE=MyISAM AUTO_INCREMENT=1144 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci";
// $sql_create_module[]= "CREATE TABLE `pet_tiemphong_chuho_lienket` (
//     `id` int(11) NOT NULL AUTO_INCREMENT,
//     `idthanhvien` int(11) NOT NULL,
//     `idchu` int(11) NOT NULL,
//     PRIMARY KEY (`id`)
//    ) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci";
// $sql_create_module[]= "CREATE TABLE `pet_tiemphong_thucung` (
//     `id` int(11) NOT NULL AUTO_INCREMENT,
//     `idchu` int(11) NOT NULL,
//     `idgiong` int(11) NOT NULL,
//     `ten` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
//     `micro` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
//     `ngaysinh` int(11) NOT NULL,
//     `ngaymat` int(11) NOT NULL,
//     `hinhanh` varchar(300) COLLATE utf8mb4_unicode_ci NOT NULL,
//     PRIMARY KEY (`id`)
//    ) ENGINE=MyISAM AUTO_INCREMENT=390 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci";
// $sql_create_module[]= "CREATE TABLE `pet_xuphat` (
//     `id` int(11) NOT NULL AUTO_INCREMENT,
//     `idchuho` int(11) NOT NULL,
//     `mucphat` int(11) NOT NULL,
//     `dongphat` int(11) NOT NULL,
//     `noidung` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
//     `thoigianphat` int(11) NOT NULL,
//     `thoigiandong` int(11) NOT NULL,
//     PRIMARY KEY (`id`)
//    ) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci";
// $sql_create_module[]= "CREATE TABLE `pet_xuphat_dinhkem` (
//     `id` int(11) NOT NULL AUTO_INCREMENT,
//     `idxuphat` int(11) NOT NULL,
//     `diachi` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
//     PRIMARY KEY (`id`)
//    ) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci";