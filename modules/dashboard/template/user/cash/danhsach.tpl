<!-- BEGIN: main -->
<table class="table table-bordered"> 
  <thead>
    <tr>
      <th> Mã thu chi </th>
      <th> Thời gian </th>
      <th> Loại thu chi </th>
      <th> Đối tượng </th>
      <th> Loại thanh toán </th>
      <th> Số tiền </th>
      <th></th>
    </tr>
  </thead>
  <!-- BEGIN: row -->
  <tbody>
    <tr>
      <td> {mathuchi} </td>
      <td> {thoigian} </td>
      <td> {loaithuchi} </td>
      <td> {doituong} </td>
      <td> {loaithanhtoan} </td>
      <td> {sotien} </td>
      <td>  
        <!-- BEGIN: sua -->
        <button class="btn btn-info">
          <span class="fa fa-pencil"></span>
          Sửa
        </button>
        <!-- END: sua -->
        <!-- BEGIN: xoa -->
        <button class="btn btn-danger">
          <span class="fa fa-close"></span>
          Xóa
        </button>
        <!-- END: xoa -->
      </td>
    </tr>
  </tbody>
  <!-- END: row -->
</table>

{navbar}
<!-- END: main -->