<!-- BEGIN: main -->
<table class="table table-bordered">
  <tr>
    <td> Loài </td>
    <td> Giống </td>
    <td> Số lượng thú cưng </td>
    <td> Chức năng </td>
  </tr>
  <!-- BEGIN: giong -->
  <tr>
    <td> {loai} </td>
    <td> {giong} </td>
    <td> 0 </td>
    <td> 
      <button class="btn btn-info btn-xs" onclick="capnhatgiong({id}, '{giong}', '{loai}')"> <span class="fa fa-pencil-square-o"></span> cập nhật </button>  
      <button class="btn btn-danger btn-xs" onclick="xoagiong({id})"> <span class="fa fa-times"></span> xóa </button>  
    </td>
  </tr>
  <!-- END: giong -->
  <!-- BEGIN: trong -->
  <tr>
    <td colspan="3" class="text-center"> Không có dữ liệu </td>
  </tr>
  <!-- END: trong -->
</table>
<!-- END: main -->