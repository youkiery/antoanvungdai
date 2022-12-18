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

<table class="table table-bordered">
  <tr>
    <th> Mã hàng </th>
    <th> Tên hàng </th>
    <th> Số lượng </th>
    <th> Đơn giá </th>
    <th> Giảm giá </th>
    <th> Giá bán </th>
    <th> Thành tiền </th>
  </tr>
  <!-- BEGIN: row -->
  <tr>
    <td> {mahang} </td>
    <td> {tenhang} </td>
    <td> {soluong} </td>
    <td> {dongia} </td>
    <td> {giamgiatien} {giamgiaphantram} {giamgiatienphantram} </td>
    <td> {giaban} </td>
    <td> {thanhtien} </td>
  </tr>
  <!-- END: row -->
</table>

<div style="float: right;">
  <button class="btn btn-info" onclick="inhoadon({id})"> In hóa đơn </button>
  <button class="btn btn-danger" onclick="xoahoadon({id})"> Xóa hóa đơn </button>
</div>
<!-- END: main -->