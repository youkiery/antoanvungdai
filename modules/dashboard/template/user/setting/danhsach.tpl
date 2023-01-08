<!-- BEGIN: main -->
<table class="table table-bordered">
  <tr>
    <th colspan="5" class="text-center"> Danh sách nhân viên </th>
  </tr>
  <tr>
    <th> STT </th>
    <th> Nhân viên </th>
    <th> Tài khoản </th>
  </tr>
  <!-- BEGIN: nhanvien -->
  <tr onclick="chitiet({userid})">
    <td> {thutu} </td>
    <td> {tennhanvien} </td>
    <td> {taikhoan} </td>
  </tr>
  <tr class="chitiet" id="{userid}" style="display: none;" load="0">
    <td colspan="3" id="td-{userid}">
    </td>
  </tr>
  <!-- END: nhanvien -->
  <!-- BEGIN: khongco -->
  <tr>
    <td colspan="3" class="text-center">
      Không có nhân viên
    </td>
  </tr>
  <!-- END: khongco -->
</table>
<!-- END: main -->