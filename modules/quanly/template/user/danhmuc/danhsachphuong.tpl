<!-- BEGIN: main -->
<table class="table table-bordered">
  <tr>
    <td> Tên phường </td>
    <td> Số hộ gia đình </td>
    <td> Số lượng thú cưng </td>
    <td> Chức năng </td>
  </tr>
  <!-- BEGIN: phuong -->
  <tr>
    <td> {ten} </td>
    <td> {sochuho} </td>
    <td> {sothucung} </td>
    <td> 
      <button class="btn btn-info btn-xs" onclick="capnhatphuong({id}, '{ten}')"> <span class="fa fa-pencil-square-o"></span> cập nhật </button>  
      <button class="btn btn-danger btn-xs" onclick="xoaphuong({id})"> <span class="fa fa-times"></span> xóa </button>  
    </td>
  </tr>
  <!-- END: phuong -->
  <!-- BEGIN: trong -->
  <tr>
    <td colspan="4" class="text-center"> Không có dữ liệu </td>
  </tr>
  <!-- END: trong -->
</table>
<!-- END: main -->