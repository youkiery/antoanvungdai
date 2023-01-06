<!-- BEGIN: main -->
<!-- BEGIN: phieutam -->
<table class="table table-bordered"> 
  <thead style="background: lightcyan;">
    <tr>
      <th colspan="6" class="text-center"> Phiếu tạm + chưa thanh toán </th>
    </tr>
    <tr>
      <th> Mã nhập </th>
      <th> Thời gian </th>
      <th> Nguồn cung </th>
      <th> Thành tiền </th>
      <th> Thanh toán </th>
      <th> Trạng thái </th>
    </tr>
  </thead>
  <!-- BEGIN: row -->
  <tbody>
    <tr onclick="chitiet('phieutam', {id})">
      <td> {manhap} </td>
      <td> {thoigian} </td>
      <td> {nguoncung} </td>
      <td> {tongtien} </td>
      <td class="{classthanhtoan}"> {thanhtoan} </td>
      <td class="{classtrangthai}"> {trangthai} </td>
    </tr>
    <tr class="chitiet" id="phieutam-{id}" style="display: none;" load="0">
      <td colspan="6" id="tdphieutam-{id}"></td>
    </tr>
  </tbody>
  <!-- END: row -->
</table>
<!-- END: phieutam -->

<table class="table table-bordered"> 
  <thead style="background: lightcyan;">
    <tr>
      <th colspan="5" class="text-center"> Phiếu nhập </th>
    </tr>
    <tr>
      <th> Mã nhập </th>
      <th> Thời gian </th>
      <th> Nguồn cung </th>
      <th> Tổng tiền </th>
      <th> Trạng thái </th>
    </tr>
  </thead>
  <!-- BEGIN: row -->
  <tbody>
    <tr onclick="chitiet('hoanthanh', {id})">
      <td> {manhap} </td>
      <td> {thoigian} </td>
      <td> {nguoncung} </td>
      <td> {tongtien} </td>
      <td> {trangthai} </td>
    </tr>
    <tr class="chitiet" id="hoanthanh-{id}" style="display: none;" load="0">
      <td colspan="5" id="tdhoanthanh-{id}"></td>
    </tr>
  </tbody>
  <!-- END: row -->
  <!-- BEGIN: khongco -->
  <tbody>
    <tr>
      <td colspan="5" class="text-center"> Không có phiếu nhập </td>
    </tr>
  </tbody>
  <!-- END: khongco -->
</table>

{navbar}
<!-- END: main -->