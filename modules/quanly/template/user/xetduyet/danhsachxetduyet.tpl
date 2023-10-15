<!-- BEGIN: main -->
<table class="table table-bordered">
  <thead>
    <tr>
      <th> Chủ hộ </th>
      <th> Điện thoại </th>
      <th> Địa chỉ </th>
      <th style="width: 50%;"> Nội dung xét duyệt </th>
      <th></th>
    </tr>
  </thead>
  <!-- BEGIN: danhsach -->
  <tr>
    <td> {chuho} </td>
    <td> {dienthoai} </td>
    <td> {diachi} </td>
    <td> {noidung} </td>
    <td> 
      <button class="btn btn-info btn-xs" onclick="xacnhanxetduyet({id})"> xác nhận </button>  
      <button class="btn btn-warning btn-xs" onclick="huyxetduyet({id})"> huỷ </button>  
    </td>
  </tr>
  <!-- END: danhsach -->
  <!-- BEGIN: trong -->
  <tr>
    <td colspan="9" class="text-center"> Không có dữ liệu </td>
  </tr>
  <!-- END: trong -->
</table>
{phantrang}
<!-- END: main -->