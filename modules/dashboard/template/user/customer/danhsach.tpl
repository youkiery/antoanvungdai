<!-- BEGIN: main -->
<table class="table table-bordered"> 
  <thead>
    <tr>
      <th> Mã khách </th>
      <th> Khách hàng </th>
      <th> Điện thoại </th>
      <th> Mua hàng </th>
      <th> Tiền nợ </th>
      <th>  </th>
    </tr>
  </thead>
  <!-- BEGIN: row -->
  <tbody>
    <tr>
      <td> {makhach} </td>
      <td> {ten} </td>
      <td> {dienthoai} </td>
      <td> {muahang} </td>
      <td> {tienno} </td>
      <td> 
        <button class="btn btn-info btn-xs" onclick="suakhach({id}, '{makhach}', '{ten}', '{diachi}', '{dienthoai}')">
          sửa
        </button>
        <button class="btn btn-danger btn-xs" onclick="xoakhach({id})">
          xóa
        </button>
      </td>
    </tr>
  </tbody>
  <!-- END: row -->
  <!-- BEGIN: khongkhach -->
  <tbody>
    <tr>
      <td colspan="6" class="text-center"> Không tìm thấy khách hàng </td>
      </td>
    </tr>
  </tbody>
  <!-- END: khongkhach -->
</table>

{navbar}
<!-- END: main -->