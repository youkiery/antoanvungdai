<!-- BEGIN: main -->
<!DOCTYPE html>
<html lang="en">
<head>
  <title> Mẫu in </title>
  <style>
    #printer * {
      font-size: 12pt;
      font-family: "Tahoma", sans-serif;
    }

    @media print{
      @page {
        margin: 0.1in;
      }
    }

  </style>
</head>
<body id="printer">
  <div>BỆNH VIỆN THÚ CƯNG THANH XUÂN</div>
  <div>Chi nhánh: Đăk Lăk</div>
  <div>Điện thoại: 02626 290 609</div>
  <div style="text-align: center;"> <b> HÓA ĐƠN </b> </div>
  <div style="text-align: center;"> <b> {mahoadon} </b> </div>
  <div> Nhân viên: {nguoiban} </div>
  <div> Khách hàng: {khachhang} </div>
  <!-- BEGIN: khachhang -->
  <div> Điện thoại: {dienthoai} </div>
  <div> Địa chỉ: {diachi} </div>
  <!-- END: khachhang -->
  <div> Thời gian: {thoigian} </div>
  <div style="border-bottom: 1px dashed gray; padding-bottom: 2px;"></div>
  <!-- BEGIN: row -->
  <div style="border-bottom: 1px dashed gray; padding-bottom: 2px; clear: both; overflow: auto;">
    <div> {tenhang} </div>
    <div style="float: left; width: 40%;">
      {giaban} 
      <div style="text-decoration: line-through;"> {dongia} </div>
    </div>
    <div style="text-align: right; float: right; width: 40%;"> {thanhtien} </div>
    <div style="text-align: center; float: right; width: 20%;"> {soluong} </div>
  </div>
  <!-- END: row -->
  <!-- BEGIN: giamgia -->
  <div style="clear: both;">
    <div style="text-align: right; float: left; width: 70%;">
      Tiền hàng
    </div>
    <div style="text-align: right; float: right; width: 30%;">
      {tongtien}
    </div>
  </div>
  <div style="clear: both;">
    <div style="text-align: right; float: left; width: 70%;">
      Giảm hóa đơn
    </div>
    <div style="text-align: right; float: right; width: 30%;">
      {giamgiatienphantram}
    </div>
  </div>
  <!-- END: giamgia -->
  <div style="clear: both;">
    <div style="text-align: right; float: left; width: 70%;">
      Thành tiền
    </div>
    <div style="text-align: right; float: right; width: 30%;">
      <b>{thanhtien}</b>
    </div>
  </div>
</body>
</html>
<!-- END: main -->
