<!-- BEGIN: main -->
<table class="table table-bordered"> 
  <thead>
    <tr>
      <th> Mã hóa đơn </th>
      <th> Thời gian </th>
      <th> Khách hàng </th>
      <th> Tổng tiền </th>
      <th> Giảm giá </th>
      <th> Thành tiền </th>
      <th> Đã trả </th>
    </tr>
  </thead>
  <!-- BEGIN: row -->
  <tbody>
    <tr onclick="chitiet({id})">
      <td> {mahoadon} </td>
      <td> {thoigian} </td>
      <td> {khachhang} </td>
      <td> {tongtien} </td>
      <td> <span class="{cogiamgia}"> {giamgiatien} {giamgiaphantram} </span> </td>
      <td> {thanhtien} </td>
      <td> {datra} </td>
    </tr>
    <tr class="chitiet" id="tr-{id}" style="display: none;" load="0">
      <td colspan="7" id="td-{id}"></td>
    </tr>
  </tbody>
  <!-- END: row -->
</table>

{navbar}
<!-- END: main -->