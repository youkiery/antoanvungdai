<!-- BEGIN: main -->
<table class="table table-bordered">
  <tr>
    <td> Tài khoản </td>
    <td> Họ tên </td>
    <td> Hoạt động </td>
    <td> Chức năng </td>
  </tr>
  <!-- BEGIN: user -->
  <tr>
    <td> {username} </td>
    <td> {first_name} </td>
    <td> Đã kích hoạt </td>
    <td> 
      <button class="btn btn-info btn-xs" onclick="capnhatthanhvien({userid})"> <span class="fa fa-pencil-square-o"></span> cập nhật </button>  
      <button class="btn btn-danger btn-xs" onclick="xoathanhvien({userid})"> <span class="fa fa-times"></span> xóa </button>  
    </td>
  </tr>
  <!-- END: user -->
  <!-- BEGIN: trong -->
  <tr>
    <td colspan="4" class="text-center"> Không có dữ liệu </td>
  </tr>
  <!-- END: trong -->
</table>
<!-- END: main -->