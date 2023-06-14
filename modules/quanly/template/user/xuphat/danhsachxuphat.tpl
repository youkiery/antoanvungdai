<!-- BEGIN: main -->
<table class="table table-bordered">
  <thead>
    <tr>
      <th> Chủ hộ </th>
      <th> Điện thoại </th>
      <th> Địa chỉ </th>
      <th> Phường </th>
      <th> Nội dung phạt </th>
      <th> Mức phạt </th>
      <th> Ngày phạt </th>
      <th> Đóng phạt </th>
      <th> Đính kèm </th>
      <th> Chức năng </th>
    </tr>
  </thead>
  <!-- BEGIN: thucung -->
  <tr>
    <td> {chuho} </td>
    <td> {dienthoai} <span class="fa fa-info-circle" onclick="chitiet({idchuho})"></span> </td>
    <td> {diachi} </td>
    <td> {phuong} </td>
    <td> {noidung} </td>
    <td> {mucphat} </td>
    <td> {ngayphat} </td>
    <!-- BEGIN: chuatiem -->
    <td style="color: red"> Chưa đóng </td>
    <!-- END: chuatiem -->
    <!-- BEGIN: datiem -->
    <td style="color: green"> Đã đóng </td>
    <!-- END: datiem -->
    <td>
      <!-- BEGIN: dinhkem -->
      <div class="fa fa-file" onclick="taifile('{url}')"></div>
      <!-- END: dinhkem -->
    </td>
    <td>
      <!-- BEGIN: dongphat -->
      <button class="btn btn-warning btn-xs" onclick="dongphat({id})"> Đóng phạt </button>
      <!-- END: dongphat -->
      <button class="btn btn-info btn-xs" onclick="capnhatxuphat({id})"> Cập nhật </button>
      <button class="btn btn-danger btn-xs" onclick="xoaxuphat({id})"> Xóa </button>
    </td>
  </tr>
  <!-- END: thucung -->
  <!-- BEGIN: trong -->
  <tr>
    <td colspan="10" class="text-center"> Không có dữ liệu </td>
  </tr>
  <!-- END: trong -->
</table>
{phantrang}
<!-- END: main -->