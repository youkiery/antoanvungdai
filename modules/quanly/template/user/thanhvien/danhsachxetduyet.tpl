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
    <td> {trangthai} </td>
    <td> 
      <!-- BEGIN: kichhoat -->
      <button class="btn btn-warning btn-xs" onclick="xoakichhoatthanhvien({userid})"> <span class="fa fa-times"></span> vô hiệu hóa </button>  
      <!-- END: kichhoat -->
      <!-- BEGIN: vohieuhoa -->
      <button class="btn btn-success btn-xs" onclick="kichhoatthanhvien({userid})"> <span class="fa fa-times"></span> kích hoạt </button>  
      <!-- END: vohieuhoa -->
      <button class="btn btn-danger btn-xs" onclick="xoathanhvien({userid})"> <span class="fa fa-times"></span> xoá </button>  
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