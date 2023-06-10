<!-- BEGIN: main -->
<table class="table table-bordered">
  <thead>
    <tr>
      <th> Tên thú cưng </th>
      <th> Giống loài </th>
      <th> Microchip </th>
      <th> Chủ hộ </th>
      <th> Địa chỉ </th>
      <th> Phường </th>
      <th> Tiêm phòng </th> 
    </tr>
  </thead>
  <!-- BEGIN: thucung -->
  <tr>
    <td> {tenthucung} </td>
    <td> {giongloai} </td>
    <td> {micro} </td>
    <td> {chuho} </td>
    <td> {diachi} </td>
    <td> {phuong} </td>
    <!-- BEGIN: chuatiem -->
    <td style="color: red"> Chưa tiêm phòng </td>
    <!-- END: chuatiem -->
    <!-- BEGIN: datiem -->
    <td style="color: green"> Đã tiêm phòng </td>
    <!-- END: datiem -->
  </tr>
  <!-- END: thucung -->
  <!-- BEGIN: trong -->
  <tr>
    <td colspan="5" class="text-center"> Không có dữ liệu </td>
  </tr>
  <!-- END: trong -->
</table>
{phantrang}
<!-- END: main -->