<!-- BEGIN: main -->
<table class="table table-bordered"> 
  <thead>
    <tr>
      <th> Mã nhâp </th>
      <th> Thời gian </th>
      <th> Nguồn cung </th>
      <th> Tổng tiền </th>
      <th> Trạng thái </th>
    </tr>
  </thead>
  <!-- BEGIN: row -->
  <tbody>
    <tr onclick="chitiet({id})">
      <td> {manhap} </td>
      <td> {thoigian} </td>
      <td> {nguoncung} </td>
      <td> {tongtien} </td>
      <td> {trangthai} </td>
    </tr>
    <tr class="chitiet" id="tr-{id}" style="display: none;" load="0">
      <td colspan="7" id="td-{id}"></td>
    </tr>
  </tbody>
  <!-- END: row -->
</table>

{navbar}
<!-- END: main -->