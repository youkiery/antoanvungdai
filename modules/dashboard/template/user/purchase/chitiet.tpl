<!-- BEGIN: main -->
<div class="row">
  <div class="col-xs-12">
    Mã nhập hàng: {mahoadon} <br>
    Thời gian: {thoigian} <br>
    Nguồn cung: {khachhang} <br>
    Người nhập: {ratoa} <br>
  </div>
  <div class="col-xs-12">
    Số hàng: {sohang} <br>
    Thành tiền: {thanhtien} <br>
    Trạng thái: 
  </div>
</div>

<table class="table table-bordered">
  <tr>
    <th> Mã hàng </th>
    <th> Tên hàng </th>
    <th> Số lượng </th>
    <th> Đơn giá </th>
    <th> Thành tiền </th>
  </tr>
  <!-- BEGIN: row -->
  <tr>
    <td> {mahang} </td>
    <td> {tenhang} </td>
    <td> {soluong} </td>
    <td> {gianhap} </td>
    <td> {thanhtien} </td>
  </tr>
  <!-- END: row -->
</table>

<!-- BEGIN: update -->
<div style="float: right;">
  <button class="btn btn-info" onclick="suanhap({id})"> Sửa </button>
</div>
<!-- END: update -->

<div style="float: right;">
  <button class="btn btn-info" onclick="inma({id})"> In </button>
</div>
<div style="float: right;">
  <button class="btn btn-info" onclick="xuatfilechitiet({id})"> Xuất file </button>
</div>
<div style="float: right;">
  <button class="btn btn-danger" onclick="xoanhap({id})"> Xóa </button>
</div>
<!-- END: main -->