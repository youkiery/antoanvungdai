<!-- BEGIN: main -->
<table class="table table-bordered">
  <thead>
    <tr>
      <th> Tên thú cưng </th>
      <th> Giống loài </th>
      <th> Microchip </th>
      <th> Tiêm phòng cuối </th>
      <th> Tiêm phòng </th>
      <th></th>
    </tr>
  </thead>
  <!-- BEGIN: thucung -->
  <tr>
    <td> {tenthucung} </td>
    <td> {giongloai} </td>
    <td> {micro} </td>
    <td> {tiemcuoi} </td>
    <td class="{color}"> {tiemphong} </td>
    <td> <button class="btn btn-info btn-xs" onclick="chitiet({id})"> chi tiết </button> </td>
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