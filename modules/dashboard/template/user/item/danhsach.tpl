<!-- BEGIN: main -->
<table class="table table-bordered"> 
  <thead>
    <tr>
      <th style="width: 64px;"> Hình ảnh </th>
      <th> Mã hàng </th>
      <th> Tên hàng </th>
      <th> Giá nhập </th>
      <th> Giá bán </th>
      <th> Số lượng </th>
      <th>  </th>
    </tr>
  </thead>
  <!-- BEGIN: row -->
  <tbody>
    <tr>
      <td> <div class="pw-thumb-box"> <img class="pw-thumb" src="{hinhanh}"> </div> </th>
      <td> {mahang} </td>
      <td> {tenhang} </td>
      <td> {gianhap} </td>
      <td> {giaban} </td>
      <td> {soluong} </td>
      <td> 
        <button class="btn btn-info btn-xs" onclick="suahang({id})">
          sửa
        </button>
        <button class="btn btn-danger btn-xs" onclick="xoahang({id})">
          xóa
        </button>
      </td>
    </tr>
  </tbody>
  <!-- END: row -->
</table>

{navbar}
<!-- END: main -->