<!-- BEGIN: main -->
<table class="table table-bordered">
  <thead>
    <tr>
      <th> Chủ hộ </th>
      <th> Điện thoại </th>
      <th> Địa chỉ </th>
      <th> Phường </th>
      <th class="text-center"> Đã tiêm </th> 
      <th> Chức năng </th>
    </tr>
  </thead>
  <!-- BEGIN: thucung -->
  <tr>
    <td> {chuho} </td>
    <td> {dienthoai} </td>
    <td> {diachi} </td>
    <td> {phuong} </td>
    <td class="text-center" {color}> 
      {datiemphong} / 
      {tongtiemphong} 
    </td>
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