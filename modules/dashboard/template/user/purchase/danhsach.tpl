<!-- BEGIN: main -->
<table class="table table-bordered"> 
  <thead>
    <tr>
      <th> Mã nhâp </th>
      <th> Thời gian </th>
      <th> Nguồn cung </th>
      <th> Tổng tiền </th>
      <th> Trạng thái </th>
      <th>  </th>
    </tr>
  </thead>
  <!-- BEGIN: row -->
  <tbody>
    <tr>
      <td> {manhap} </td>
      <td> {thoigian} </td>
      <td> {nguoncung} </td>
      <td> {tongtien} </td>
      <td> {trangthai} </td>
      <td> 
        <!-- BEGIN: update -->
        <button class="btn btn-info btn-xs" onclick="suanhap({id})">
          sửa
        </button>
        <!-- END: update -->
        <button class="btn btn-danger btn-xs" onclick="xoanhap({id})">
          xóa
        </button>
      </td>
    </tr>
  </tbody>
  <!-- END: row -->
</table>

{navbar}
<!-- END: main -->