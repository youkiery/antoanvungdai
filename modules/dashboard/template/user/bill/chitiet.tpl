<!-- BEGIN: main -->
<div class="row">
  <div class="col-xs-12">
    Mã hóa đơn: {mahoadon} <br>
    Thời gian: {thoigian} <br>
    Khách hàng: {khachhang} <br>
    Người ra toa: {ratoa} <br>
    Người bán: {banhang} <br>
  </div>
  <div class="col-xs-12">
    Số hàng: {sohang} <br>
    Tổng tiền: {tongtien} <br>
    Giảm giá: {giamgiatien} {giamgiaphantram} {giamgiatienphantram} <br>
    Thành tiền: {thanhtien} <br>
    Đã trả: {datra} <br>
  </div>
  <div class="col-xs-24">
    Ghi chú: {ghichu}
  </div>
</div>

<!-- BEGIN: hangtra -->
<table class="table table-bordered">
  <tr>
    <th> Mã hàng </th>
    <th> Hàng trả </th>
    <th> Số lượng </th>
    <th> Giá bán </th>
    <th> Tổng tiền </th>
  </tr>
  <!-- BEGIN: cot -->
  <tr>
    <td> {mahang} </td>
    <td> {tenhang} </td>
    <td> {soluong} </td>
    <td> {giaban} </td>
    <td> {thanhtien} </td>
  </tr>
  <!-- END: cot -->
</table>
<!-- END: hangtra -->

<!-- BEGIN: hangban -->
<table class="table table-bordered">
  <tr>
    <th> Mã hàng </th>
    <th> Hàng bán </th>
    <th> Số lượng </th>
    <th> Đơn giá </th>
    <th> Giảm giá </th>
    <th> Giá bán </th>
    <th> Thành tiền </th>
  </tr>
  <!-- BEGIN: cot -->
  <tr>
    <td> {mahang} </td>
    <td> {tenhang} </td>
    <td> {soluong} </td>
    <td> {dongia} </td>
    <td> {giamgiatien} {giamgiaphantram} {giamgiatienphantram} </td>
    <td> {giaban} </td>
    <td> {thanhtien} </td>
  </tr>
  <!-- END: cot -->
</table>
<!-- END: hangban -->

<div style="float: right;">
  <!-- BEGIN: saochep -->
  <button class="btn btn-info"> Sửa </button>
  <!-- END: saochep -->
  <!-- BEGIN: saochep -->
  <button class="btn btn-info"> Sao chép </button>
  <!-- END: saochep -->
  <!-- BEGIN: inhoadon -->
  <button class="btn btn-info" onclick="inhoadon({id})"> In hóa đơn </button>
  <!-- END: inhoadon -->
  <!-- BEGIN: xoahoadon -->
  <button class="btn btn-danger" onclick="xoahoadon({id})"> Xóa hóa đơn </button>
  <!-- END: xoahoadon -->
</div>
<!-- END: main -->