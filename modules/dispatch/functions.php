<?php

/**
 * @Project NUKEVIET 4.x
 * @Author VINADES.,JSC <contact@vinades.vn>
 * @Copyright (C) 2014 VINADES.,JSC. All rights reserved
 * @License GNU/GPL version 2 or any later version
 * @Createdate Tue, 19 Jul 2011 09:07:26 GMT
 */

if (!defined('NV_SYSTEM')) die('Stop!!!');
define("PREFIX", $db_config['prefix']);
define("PATH", NV_ROOTDIR . '/modules/' . $module_file . '/template/user/');
global $arr_type, $arr_status;

$arr_status = array(
    '0' => array(
        'id' => '0',
        'name' => $lang_module['dis_sta0']
    ),
    '1' => array(
        'id' => '1',
        'name' => $lang_module['dis_sta1']
    ),
    '2' => array(
        'id' => '2',
        'name' => $lang_module['dis_sta2']
    )
);

define('NV_IS_FILE_ADMIN', true);

/**
 * nv_setcats1()
 *
 * @param mixed $list2
 * @param mixed $id
 * @param mixed $list
 * @param integer $m
 * @param integer $num
 * @return
 */
function nv_setcats1($list2, $id, $list, $m = 0, $num = 0)
{
    $num++;
    $defis = "";
    for ($i = 0; $i < $num; $i++) {
        $defis .= "--";
    }
    
    if (isset($list[$id])) {
        foreach ($list[$id] as $value) {
            if ($value['id'] != $m) {
                $list2[$value['id']] = $value;
                $list2[$value['id']]['name'] = "|" . $defis . "&gt; " . $list2[$value['id']]['name'];
                if (isset($list[$value['id']])) {
                    $list2 = nv_setcats1($list2, $value['id'], $list, $m, $num);
                }
            }
        }
    }
    return $list2;
}

function getdefcode() {
    global $db, $db_config;

    $sql = 'select * from `' . $db_config['prefix'] . '_config` where config_name = "defcode"';
    $query2 = $db->query($sql);
    if ($row2 = $query2->fetch()) {
        // gotten
        return $row2['config_value'];
    }
    else {
        // insert
        $sql = 'insert into `' . $db_config['prefix'] . '_config` values ("lang", "sys", "defcode", "1")';
        $db->query($sql);
        return 1;
    }
}


/**
 * nv_listcats()
 *
 * @param mixed $parentid
 * @param integer $m
 * @return
 */
function nv_listcats($parentid, $m = 0)
{
    global $db, $module_data;
    
    $sql = "SELECT * FROM `" . NV_PREFIXLANG . "_" . $module_data . "_cat` ORDER BY `parentid`,`weight` ASC";
    
    $result = $db->query($sql);
    $list = array();
    while ($row = $result->fetch()) {
        $list[$row['parentid']][] = array(
            'id' => (int) $row['id'],
            'parentid' => (int) $row['parentid'],
            'title' => $row['title'],
            'alias' => $row['alias'],
            'introduction' => $row['introduction'],
            'weight' => (int) $row['weight'],
            'status' => $row['status'],
            'name' => $row['title'],
            'addtime' => $row['addtime'],
            'selected' => $parentid == $row['id'] ? " selected=\"selected\"" : ""
        );
    }
    
    if (empty($list)) {
        return $list;
    }
    
    $list2 = array();
    foreach ($list[0] as $value) {
        if ($value['id'] != $m) {
            $list2[$value['id']] = $value;
            if (isset($list[$value['id']])) {
                $list2 = nv_setcats1($list2, $value['id'], $list, $m);
            }
        }
    }
    
    return $list2;
}

/**
 * nv_setdes1()
 *
 * @param mixed $list2
 * @param mixed $id
 * @param mixed $list
 * @param integer $m
 * @param integer $num
 * @return
 */
function nv_setdes1($list2, $id, $list, $m = 0, $num = 0)
{
    $num++;
    $defis = "";
    $des = "";
    for ($i = 0; $i < $num; $i++) {
        $defis .= "--";
    
    }
    
    if (isset($list[$id])) {
        foreach ($list[$id] as $value) {
            if ($value['id'] != $m) {
                $list2[$value['id']] = $value;
                $list2[$value['id']]['name'] = "|" . $defis . "&gt; " . $list2[$value['id']]['name'];
                if (isset($list[$value['id']])) {
                    $list2 = nv_setcats1($list2, $value['id'], $list, $m, $num);
                }
            }
        }
    }
    return $list2;
}

/**
 * nv_listdes()
 *
 * @param mixed $parentid
 * @param integer $m
 * @return
 */
function nv_listdes($parentid, $m = 0)
{
    global $db, $module_data;
    
    $sql = "SELECT * FROM `" . NV_PREFIXLANG . "_" . $module_data . "_departments` ORDER BY `parentid`,`weight` ASC";
    
    $result = $db->query($sql);
    $list = array();
    while ($row = $result->fetch()) {
        $list[$row['parentid']][] = array(
            'id' => (int) $row['id'],
            'parentid' => (int) $row['parentid'],
            'title' => $row['title'],
            'alias' => $row['alias'],
            'introduction' => $row['introduction'],
            'weight' => (int) $row['weight'],
            'head' => $row['head'],
            'name' => $row['title'],
            'addtime' => $row['addtime'],
            'selected' => $parentid == $row['id'] ? " selected=\"selected\"" : "",
            'checked' => $parentid == $row['id'] ? " checked=\"checked\"" : ""
        );
    }
    
    if (empty($list)) {
        return $list;
    }
    
    $list2 = array();
    foreach ($list[0] as $value) {
        if ($value['id'] != $m) {
            $list2[$value['id']] = $value;
            if (isset($list[$value['id']])) {
                $list2 = nv_setdes1($list2, $value['id'], $list, $m);
            }
        }
    }
    
    return $list2;
}

function nv_signerList($idsigner)
{
    global $db, $module_data;
    
    $sql = "SELECT * FROM `" . NV_PREFIXLANG . "_" . $module_data . "_signer` ORDER BY `weight` ASC";
    $result = $db->query($sql);
    $list = array();
    while ($row = $result->fetch()) {
        $list[$row['id']] = array(
            'id' => $row['id'],
            'name' => $row['name'],
            'positions' => $row['positions'],
            'weight' => (int) $row['weight'],
            'selected' => $idsigner == $row['id'] ? " selected=\"selected\"" : ""
        );
    }
    
    return $list;
}

/**
 * nv_settype1()
 *
 * @param mixed $list2
 * @param mixed $id
 * @param mixed $list
 * @param integer $m
 * @param integer $num
 * @return
 */
function nv_settypes1($list2, $id, $list, $m = 0, $num = 0)
{
    $num++;
    $defis = "";
    for ($i = 0; $i < $num; $i++) {
        $defis .= "--";
    }
    
    if (isset($list[$id])) {
        foreach ($list[$id] as $value) {
            if ($value['id'] != $m) {
                $list2[$value['id']] = $value;
                $list2[$value['id']]['name'] = "|" . $defis . "&gt; " . $list2[$value['id']]['name'];
                if (isset($list[$value['id']])) {
                    $list2 = nv_settypes1($list2, $value['id'], $list, $m, $num);
                }
            }
        }
    }
    return $list2;
}

/**
 * nv_listtypes()
 *
 * @param mixed $parentid
 * @param integer $m
 * @return
 */
function nv_listtypes($parentid, $m = 0)
{
    global $db, $module_data;
    
    $sql = "SELECT * FROM `" . NV_PREFIXLANG . "_" . $module_data . "_type` ORDER BY `parentid`,`weight` ASC";
    
    $result = $db->query($sql);
    $list = array();
    while ($row = $result->fetch()) {
        $list[$row['parentid']][] = array(
            'id' => (int) $row['id'],
            'parentid' => (int) $row['parentid'],
            'title' => $row['title'],
            'alias' => $row['alias'],
            'weight' => (int) $row['weight'],
            'status' => $row['status'],
            'name' => $row['title'],
            'selected' => $parentid == $row['id'] ? " selected=\"selected\"" : ""
        );
    }
    
    if (empty($list)) {
        return $list;
    }
    
    $list2 = array();
    foreach ($list[0] as $value) {
        if ($value['id'] != $m) {
            $list2[$value['id']] = $value;
            if (isset($list[$value['id']])) {
                $list2 = nv_settypes1($list2, $value['id'], $list, $m);
            }
        }
    }
    
    return $list2;
}

define('NV_IS_MOD_CONGVAN', true);

function totime($time) {
    if (preg_match("/^([0-9]{1,2})\.([0-9]{1,2})\.([0-9]{4})$/", $time, $m)) {
      $time = mktime(0, 0, 0, $m[2], $m[1], $m[3]);
      if (!$time) {
        $time = time();
      }
    }
    else {
      $time = time();
    }
    return $time;
}

function kiemtraphanquyen() {
    global $db, $user_info;
    
    if (!isset($user_info['userid'])) header('location: /users/login');
    $id = $user_info['userid'];
    if (empty($id)) return 0;
    if ($id == 1) return 2;
    $sql = "select active from ". PREFIX ."_users where userid = $id";
    $nhanvien = $db->fetch($sql);
    if (empty($nhanvien) || !$nhanvien['active']) return 0;
    $sql = "select * from ". PREFIX ."_phanquyen where userid = $id";
      if (!empty($phanquyen = $db->fetch($sql))) return $phanquyen['quyen'];
    return 0;
}

  
function laybanner() {
    global $db;
  
    $sql = "select * from ". PREFIX ."_config where module = 'global' and config_name = 'site_banner'";
    $hinhanh = $db->fetch($sql);
    if (empty($hinhanh)) return NV_ROOTDIR . '/assets/images/noimage.png';
    if (strpos('http', $hinhanh['config_value']) !== false) return $hinhanh['config_value'];
    return '/' . $hinhanh['config_value'];
}
?>

