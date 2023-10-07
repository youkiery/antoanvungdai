<!-- BEGIN: main -->
<table class="table table-bordered">
  <thead>
    <tr>
      <th> Tài khoản </th>
      <th> Họ tên </th>
      <th> Quyền </th>
      <th> Hoạt động </th>
      <th> Chức năng </th>
    </tr>
  </thead>
  <!-- BEGIN: user -->
  <tr>
    <td> {username} </td>
    <td> {first_name} </td>
    <td> {quyen} </td>
    <td> {trangthai} </td>
    <td> 
      <!-- BEGIN: chucnang -->
      <button class="btn btn-info btn-xs" onclick="capnhatthanhvien({userid})"> <span class="fa fa-pencil-square-o"></span> cập nhật </button>  
      <!-- BEGIN: kichhoat -->
      <button class="btn btn-warning btn-xs" onclick="xoakichhoatthanhvien({userid})"> <span class="fa fa-times"></span> vô hiệu hóa </button>  
      <!-- END: kichhoat -->
      <!-- BEGIN: vohieuhoa -->
      <button class="btn btn-success btn-xs" onclick="kichhoatthanhvien({userid})"> <span class="fa fa-times"></span> kích hoạt </button>  
      <!-- END: vohieuhoa -->
      <button class="btn btn-danger btn-xs" onclick="xoathanhvien({userid})"> <span class="fa fa-times"></span> xoá </button>  
      <!-- END: chucnang -->
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