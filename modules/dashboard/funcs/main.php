<?php

if (!defined('NV_IS_MOD_NEWS')) {
  exit('Stop!!!');
}
$page_title = $lang_module['title'];

if (!quyennguoidung(13)) $contents = 'Tài khoản không có quyền xem mục này';
else {
  $xtpl = new XTemplate('main.tpl', PATH);
  $daungay = strtotime(date('Y/m/d'));
  $cuoingay = $daungay + 60 * 60 * 24 - 1;
  $daungayhomqua = $daungay - 60 * 60 * 24;
  $cuoingayhomqua = $daungayhomqua - 60 * 60 * 24;
  $daungaythangtruoc = $daungay - 60 * 60 * 24 * 30;
  $cuoingaythangtruoc = $daungaythangtruoc + 60 * 60 * 24 - 1;
  // kết quả bán hàng hôm nay
  // 	tổng hóa đơn, doanh thu, so với hôm qua, so với cùng kỳ tháng trước
  // 	trả hàng
  $sql = "select count(*) as soluong from pos_hoadon where (thoigian between $daungay and $cuoingay)";
  $soluonghoadon = $db->fetch($sql)['soluong'];
  
  $sql = "select * from pos_hoadon where (thoigian between $daungay and $cuoingay)";
  $danhsachhoadon = $db->all($sql);
  $sohoadon = count($danhsachhoadon);
  $tongdoanhthu = 0;
  
  foreach ($danhsachhoadon as $hoadon) {
    $tongdoanhthu += $hoadon['thanhtien'];
  }
  
  $sql = "select a.* from pos_chitiettrahang a inner join pos_hoadon b on (b.thoigian between $daungay and $cuoingay) and a.idhoadon = b.id";
  $danhsachtrahang = $db->all($sql);
  $tongtrahang = 0;
  $idtrahang = [];
  
  foreach ($danhsachtrahang as $trahang) {
    if (empty($idtrahang[$trahang['idhoadon']])) $idtrahang[$trahang['idhoadon']] = 1;
    $tongtrahang += $trahang['thanhtien'];
  }
  
  $sql = "select sum(thanhtien) as tongtien from pos_hoadon where (thoigian between $daungayhomqua and $cuoingayhomqua)";
  $doanhthuhomqua = $db->fetch($sql)['tongtien'];
  
  $sql = "select sum(thanhtien) as tongtien from pos_hoadon where (thoigian between $daungaythangtruoc and $cuoingaythangtruoc)";
  $doanhthuthangtruoc = $db->fetch($sql)['tongtien'];
  
  $xtpl->assign('sophieuhoadon', number_format($sohoadon));
  $xtpl->assign('doanhthu', number_format($tongdoanhthu));
  $xtpl->assign('tilehomqua', ($tongdoanhthu < $doanhthuhomqua ? '-' : '+'). number_format(($doanhthuhomqua > 0 ? $tongdoanhthu * 100 / $doanhthuhomqua : 0), 2));
  $xtpl->assign('tilethangtruoc', ($tongdoanhthu < $doanhthuthangtruoc ? '-' : '+'). number_format(($doanhthuthangtruoc > 0 ? $tongdoanhthu * 100 / $doanhthuthangtruoc : 0), 2));
  $xtpl->assign('sophieutrahang', number_format(count($idtrahang)));
  $xtpl->assign('tongtrahang', number_format($tongtrahang));
  
  // doanh thu tháng này
  // 	lấy từng ngày trong tháng
  // 	lập biểu đồ
  $ngaytrongthang = date('t');
  $thongkengay = ['nhan' => [], 'mau' => [], 'dulieu' => []];
  $tongdoanhthu = 0;
  
  for ($i = 1; $i <= $ngaytrongthang; $i++) { 
    $daungay = strtotime(date("Y/m/$i"));
    $cuoingay = $daungay + 60 * 60 * 24 - 1;
    $sql = "select * from pos_hoadon where thoigian between $daungay and $cuoingay";
    $danhsachhoadon = $db->all($sql);
    $thongkengay['nhan'] []= date("d", $daungay);
    $thongkengay['dulieu'] []= 0;
    $thongkengay['mau'] []= 'lightskyblue';
    $thutu = count($thongkengay['dulieu']) - 1;
  
    foreach ($danhsachhoadon as $hoadon) {
      $thongkengay['dulieu'][$thutu] += $hoadon['thanhtien'];
      $tongdoanhthu += $hoadon['thanhtien'];
    }
  }
  
  $xtpl->assign('tongdoanhthu', number_format($tongdoanhthu));
  $xtpl->assign('thongke', json_encode($thongkengay));
  
  // thông báo
  // 	khách hàng nợ tiền từ 10tr quá 7 ngày
  // 	sinh nhật khách
  $sql = "select * from pos_khachhang where tienno >= 10000000 order by tienno desc limit 10";
  $danhsachkhachhang = $db->all($sql);
  
  if (count($danhsachkhachhang)) {
    foreach ($danhsachkhachhang as $khachhang) {
      $sql = "select thoigian from pos_hoadon where idkhach = $khachhang[id] and thanhtoan < thanhtien order by id desc limit 1";
      $thoigian = $db->fetch($sql)['thoigian'];
      $songay = floor((time() - $thoigian) / 60 / 60 / 24);
  
      $xtpl->assign('tenkhach', $khachhang['tenkhach']);
      $xtpl->assign('dienthoai', $khachhang['dienthoai']);
      $xtpl->assign('sotien', number_format($khachhang['tienno']));
      $xtpl->assign('songay', $songay);
      $xtpl->parse('main.khachno.khach');
    }
    $xtpl->parse('main.khachno');
  }
  
  // hoạt động gần đây
  // 	nhân viên bán hàng, trả hàng
  // 	chi tiền
  $sql = "select * from pos_hoadon order by id desc limit 10";
  $danhsachhoadon = $db->all($sql);
  
  if (count($danhsachhoadon)) {
    foreach ($danhsachhoadon as $hoadon) {
      $sql = "select * from pet_users where userid = $hoadon[idnguoiban]";
      $nguoiban = $db->fetch($sql);
    
      $xtpl->assign('nhanvien', $nguoiban['first_name']);
      $xtpl->assign('thanhtien', number_format($hoadon['thanhtien']));
      $xtpl->assign('thoigian', date('d/m H:i', $hoadon['thoigian']));
      $xtpl->parse('main.hoatdong.hoadon');
    }
    $xtpl->parse('main.hoatdong');
  }
  
  // top mặt hàng bán chạy tháng trước
  $dauthang = strtotime(date('Y/m/1'));
  $dauthangtruoc = strtotime(date('Y/m/1', $dauthang - 1));
  $cuoithangtruoc = strtotime(date('Y/m/t', $dauthangtruoc)) + 60 * 60 * 24 - 1;
  $sql = "select id from pos_hoadon where (thoigian between $dauthangtruoc and $cuoithangtruoc)";
  $danhsachidhoadon = $db->arr($sql, 'id');
  $thongkehangthang = ['nhan' => [], 'mau' => [], 'dulieu' => []];
  
  if (count($danhsachidhoadon)) {
    $idhoadon = implode(', ', $danhsachidhoadon);
  
    $sql = "select sum(soluongthuc) as tongsoluong, idhang from pos_chitiethoadon where idhoadon in ($idhoadon) group by idhang order by tongsoluong desc limit 10";
    $danhsachhang = $db->all($sql);
  
    if (count($danhsachhang)) {
      foreach ($danhsachhang as $hanghoa) {
        $sql = "select * from pos_hanghoa where id = $hanghoa[idhang]";
        $chitiethanghoa = $db->fetch($sql);
  
        $thongkehangthang['nhan'] []= $chitiethanghoa['tenhang'];
        $thongkehangthang['dulieu'] []= $hanghoa['tongsoluong'];
        $thongkehangthang['mau'] []= 'lightskyblue';
      }
    }
  }
  
  $xtpl->assign('thongkehangthang', json_encode($thongkehangthang));
  $xtpl->parse('main');
  $contents = $xtpl->text();
}


include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
