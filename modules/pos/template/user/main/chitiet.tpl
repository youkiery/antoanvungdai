<!-- BEGIN: main -->
<table class="table table-bordered">
  <thead>
    <tr>
      <th> Thời gian </th>
      <th> Mã hóa đơn </th>
      <th> Đã thu </th>
      <th> Còn nợ </th>
      <th style="width: 50%;"> </th>
    </tr>
  </thead>
  <tbody>
    <!-- BEGIN: row -->
    <tr>
      <td> {thoigian} </td>
      <td> {mahoadon} </td>
      <td> {dathu} </td>
      <td> {conno} </td>
      <td> <input autocomplete="off" type="text" class="form-control" id="thuno-tien{i}" value="0" onkeyup="suatoathanhtoanthuno({i})"> </td>
    </tr>
    <!-- END: row -->
  </tbody>
</table>

<!-- END: main -->