<!-- BEGIN: main -->
<table class="table table-bordered"> 
  <thead>
    <tr>
      <th> <input type="checkbox" id="all" onchange="kiemtra(event)"> </th>
      <th> Mã hàng </th>
      <th> Tên hàng </th>
      <!-- BEGIN: gianhap -->
      <th> Giá nhập </th>
      <!-- END: gianhap -->
      <th> Giá bán </th>
      <th> Số lượng </th>
    </tr>
  </thead>
  <!-- BEGIN: row -->
  <tbody>
    <tr>
      <td> <input type="checkbox" class="checkbox" ref="{id}" onchange="kiemtra(event)"> </td>
      <td onclick="chitiet({id})"> {mahang} </td>
      <td onclick="chitiet({id})"> {tenhang} </td>
      <!-- BEGIN: gianhap2 -->
      <td onclick="chitiet({id})"> {gianhap} </td>
      <!-- END: gianhap2 -->
      <td onclick="chitiet({id})"> {giaban} </td>
      <td onclick="chitiet({id})"> {soluong} </td>
    </tr>
    <tr class="chitiet" id="tr-{id}" style="display: none;" load="0">
      <td colspan="7" id="td-{id}"></td>
    </tr>
  </tbody>
  <!-- END: row -->
</table>

{navbar}
<!-- END: main -->