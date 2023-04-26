<!-- BEGIN: main -->
<p> 
  <!-- BEGIN: msg -->
  Tìm kiếm {keyword} từ {from} đến {end} trong {count} kết quả
  <!-- END: msg -->
</p>
<table class="table table-bordered">
  <tr>
    <th> STT </th>
    <th> Người chi </th>
    <th> Nội dung </th>
    <th> Số tiền </th>
    <th> Ngày chi </th>
    <th> </th>
  </tr>
  <!-- BEGIN: row -->
  <tbody>
    <tr class="clickable-row" data-href=''>
      <td> {index} </td>
      <td> {fullname} </td>
      <td> {content} </td>
      <td> {price} </td>
      <td> {time} </td>
      <td> 
        <button class="btn btn-danger btn-xs" onClick="removePay({id})"> xóa  </button>
      </td>
    </tr>
  </tbody>
  <!-- END: row -->
</table>
{nav}
<!-- END: main -->
