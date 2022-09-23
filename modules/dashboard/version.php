<?php
if (!defined('NV_ADMIN') or !defined('NV_MAINFILE')) {
    exit('Stop!!!');
}

$module_version = [
    'name' => 'dashboard', // Tieu de module
    'modfuncs' => 'main,item,purchase,source,customer,bill,cash,statistic', // Cac function co block
    'is_sysmod' => 0, // 1:0 => Co phai la module he thong hay khong
    'virtual' => 1, // 1:0 => Co cho phep ao hao module hay khong
    'version' => '4.5.01', // Phien ban cua modle
    'date' => 'Saturday, November 6, 2021 16:00:00 GMT+07:00', // Ngay phat hanh phien ban
    'author' => 'Petcoffee.work', // Tac gia
];
