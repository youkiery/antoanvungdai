<!-- BEGIN: main -->
<div class="row">
  <div class="col-xs-24"> {tenhang} </div>
  <div class="col-xs-12">
    <img src="{hinhanh}">
    <!-- hình ảnh -->
  </div>
  <div class="col-xs-12">
    Mã hàng: {mahang} <br>
    Nhóm hàng: {nhomhang} <br>
    Giá nhập: {gianhap} <br>
    Giá bán: {giaban} <br>
    Tồn kho: {tonkho} <br>
    Giới thiệu: {gioithieu}
  </div>
</div>

<div style="float: right;">
  <!-- BEGIN: sua -->
  <button class="btn btn-info" onclick="suahang({id})">
    sửa
  </button>
  <!-- END: sua -->
  <!-- BEGIN: xoa -->
  <button class="btn btn-danger" onclick="xoahang({id})">
    xóa
  </button>
  <!-- END: xoa -->
</div>
<!-- END: main -->