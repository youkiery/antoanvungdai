<!-- BEGIN: main -->
<table class="table table-bordered">
  <thead>
    <tr>
      <th> Tên vật nuôi </th>
      <th> Microchip </th>
      <th> Giống loài </th>
      <th> Ngày sinh </th>
      <th> Tiêm cuối </th> 
      <th></th>
    </tr>
  </thead>
  <!-- BEGIN: thucung -->
  <tr>
    <td> {tenthucung} </td>
    <td> {micro} </td>
    <td> {giongloai} </td>
    <td> {ngaysinh} </td>
    <td {color}> 
      {tiemcuoi}
    </td>
    <td> 
      <button class="btn btn-warning btn-xs" onclick="xoa({id})"> xoá </button> 
      <button class="btn btn-info btn-xs" onclick="capnhat({id})"> cập nhật </button> 
    </td>
  </tr>
  <!-- END: thucung -->
  <!-- BEGIN: trong -->
  <tr>
    <td colspan="9" class="text-center"> Không có dữ liệu </td>
  </tr>
  <!-- END: trong -->
</table>
{phantrang}
<!-- END: main -->