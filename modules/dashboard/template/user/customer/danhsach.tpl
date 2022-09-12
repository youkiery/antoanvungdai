<!-- BEGIN: main -->
<table class="table table-bordered"> 
  <thead>
    <tr>
      <th> Khách hàng </th>
      <th> Địa chỉ </th>
      <th> Điện thoại </th>
      <th>  </th>
    </tr>
  </thead>
  <!-- BEGIN: row -->
  <tbody>
    <tr>
      <td> {ten} </td>
      <td> {diachi} </td>
      <td> {dienthoai} </td>
      <td> 
        <button class="btn btn-info btn-xs" onclick="suakhach({id}, '{ten}', '{diachi}', '{dienthoai}')">
          sửa
        </button>
        <button class="btn btn-danger btn-xs" onclick="xoakhach({id})">
          xóa
        </button>
      </td>
    </tr>
  </tbody>
  <!-- END: row -->
</table>

{navbar}
<!-- END: main -->