<!-- BEGIN: main -->
<div class="row">
  <div class="col-xs-12">
    Mã nhập hàng: {manhaphang} <br>
    Thời gian: {thoigian} <br>
    Người nhập: {ratoa} <br>
  </div>
  <div class="col-xs-12">
    Số hàng: {sohang} <br>
    Thành tiền: {thanhtien} <br>
    Nguồn cung: {nguoncung} <br>
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

<div style="float: right;">
  <!-- BEGIN: update -->
  <button class="btn btn-info" onclick="suanhap({id})"> <span class="fa fa-pencil"></span> Sửa </button>
  <!-- END: update -->
  <button class="btn btn-info" onclick="inma({id})"> <span class="fa fa-print"></span> In </button>
  <!-- BEGIN: export -->
  <button class="btn btn-info" onclick="xuatfilechitiet({id})"> <span class="fa fa-download"></span> Xuất file </button>
  <!-- END: export -->
  <!-- BEGIN: thanhtoan -->
  <button class="btn btn-info" onclick="thanhtoan({id})"> <span class="fa fa-money"></span> Thanh toán </button>
  <!-- END: thanhtoan -->
  <!-- BEGIN: xoa -->
  <button class="btn btn-danger" onclick="xoanhap({id})"> <span class="fa fa-close"></span> Xóa </button>
  <!-- END: xoa -->
</div>
<!-- END: main -->