<!-- BEGIN: main -->
<table class="table table-bordered">
  <thead>
    <tr>
      <th> STT </th>
      <th> Danh mục </th>
      <th>  </th>
    </tr>
  </thead>
  <!-- BEGIN: row -->
  <tbody>
    <tr>
      <td> {thutu} </td>
      <td> {danhmuc} </td>
      <td> 
        <button class="btn btn-info btn-xs" onclick="suadanhmuc({id}, '{danhmuc}')">
          <span class="fa fa-pencil"></span> Sửa
        </button>
        <button class="btn btn-danger btn-xs" onclick="xoadanhmuc({id})">
          <span class="fa fa-close"></span> Xóa
        </button>
      </td>
    </tr>
  </tbody>
  <!-- END: row -->
  <!-- BEGIN: khongco -->
  <tbody>
    <tr>
      <td colspan="{hopcot}" class="text-center"> Không có danh sách </td>
    </tr>
  </tbody>
  <!-- END: khongco -->
</table>
<!-- END: main -->