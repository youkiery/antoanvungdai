<!-- BEGIN: main -->
<table class="table table-bordered"> 
  <thead>
    <tr>
      <th> Mã hóa đơn </th>
      <th> Thời gian </th>
      <th> Khách hàng </th>
      <th> Thành tiền </th>
      <th> Giảm giá </th>
      <th> Đã trả </th>
    </tr>
  </thead>
  <!-- BEGIN: row -->
  <tbody>
    <tr onclick="chitiet({id})">
      <td> {mahoadon} </td>
      <td> {thoigian} </td>
      <td> {khachhang} </td>
      <td> {thanhtien} </td>
      <td> {giamgia} </td>
      <td> {datra} </td>
    </tr>
    <tr class="chitiet" id="tr-{id}" style="display: none;" load="0">
      <td colspan="6" id="td-{id}"></td>
    </tr>
  </tbody>
  <!-- END: row -->
</table>

{navbar}
<!-- END: main -->