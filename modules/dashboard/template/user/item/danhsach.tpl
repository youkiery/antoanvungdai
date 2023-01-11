<!-- BEGIN: main -->
<table class="table table-bordered"> 
  <thead>
    <tr>
      <th style="width: 64px;"> Hình ảnh </th>
      <th> Mã hàng </th>
      <th> Tên hàng </th>
      <!-- BEGIN: gianhap -->
      <th> Giá nhập </th>
      <!-- END: gianhap -->
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
      <!-- BEGIN: gianhap2 -->
      <td> {gianhap} </td>
      <!-- END: gianhap2 -->
      <td> {giaban} </td>
      <td> {soluong} </td>
      <td> 
        <!-- BEGIN: sua -->
        <button class="btn btn-info btn-xs" onclick="suahang({id})">
          sửa
        </button>
        <!-- END: sua -->
        <!-- BEGIN: xoa -->
        <button class="btn btn-danger btn-xs" onclick="xoahang({id})">
          xóa
        </button>
        <!-- END: xoa -->
      </td>
    </tr>
  </tbody>
  <!-- END: row -->
</table>

{navbar}
<!-- END: main -->