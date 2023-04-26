<!-- BEGIN: main -->
<table class="table table-bordered">
  <thead>
    <tr>
      <th> Tên </th>
      <th> Giống </th>
      <th> Ngày sinh </th>
      <th> Giới tính </th>
      <th> Số microchip </th>
      <th>  </th>
    </tr>
  </thead>
  <tbody style="font-size: 0.8em">
    <!-- BEGIN: row -->
    <tr>
      <td> {name} </td>
      <td> {breed} </td>
      <td> {birthday} </td>
      <td> {sex} </td>
      <td> {microchip} </td>
      <td> 
        <button class="btn btn-info btn-xs" onclick="print({id})">
          in văn bản
        </button>  
      </td>
    </tr>
    <!-- END: row -->
  </tbody>  
</table>
<!-- END: main -->