<!-- BEGIN: main -->
<table class="table table-bordered">
  <tr>
    <td> Chủ hộ </td>
    <td> Phường </td>
    <td> Microchip </td>
    <td> Thời gian </td>
    <td> Chức năng </td>
  </tr>
  <!-- BEGIN: tiemphong -->
  <tr>
    <td> {chuho} </td>
    <td> {phuong} </td>
    <td> {microchip} </td>
    <td> {thoigian} </td>
    <td> 
      <button class="btn btn-info btn-xs" onclick="capnhatgiong({id}, '{giong}', '{loai}')"> <span class="fa fa-pencil-square-o"></span> cập nhật </button>  
      <button class="btn btn-danger btn-xs" onclick="xoagiong({id})"> <span class="fa fa-times"></span> xóa </button>  
    </td>
  </tr>
  <!-- END: tiemphong -->
  <!-- BEGIN: trong -->
  <tr>
    <td colspan="5" class="text-center"> Không có dữ liệu </td>
  </tr>
  <!-- END: trong -->
</table>
{phantrang}
<!-- END: main -->