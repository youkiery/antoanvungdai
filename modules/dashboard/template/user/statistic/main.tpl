<!-- BEGIN: main -->
<div class="modal fade" id="modal-xoahoadon" role="dialog">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title"> Xóa hóa đơn </h4>
      </div>
      <div class="modal-body">
        <div class="text-center">
          Hóa đơn sau khi xóa sẽ biến mất
        </div>

        <button class="btn btn-danger btn-block" onclick="xacnhanxoahoadon()">
          Xác nhận
        </button>

      </div>
    </div>
  </div>
</div>

<div id="printable"></div>
<div class="pw-content nonprintable">
  <div class="pw-header">
    Thống kê
  </div>

  <div class="pw-card">
    <div class="pw-card-header">
      <!-- <button class="btn btn-success" onclick="themkhach()"> <span class="fa fa-plus"></span> </button> -->
    </div>
    <div class="row">
      <div class="col-xs-12">
        <input type="text" class="date form-control" id="batdau" value="{homnay}">
      </div>
      <div class="col-xs-12">
        <div class="input-group">
          <input type="text" class="date form-control" id="ketthuc" value="{homnay}">
          <div class="input-group-btn">
            <button class="btn btn-success" onclick="thongke()"> <span class="fa fa-line-chart"></span> </button>
          </div>
        </div>
      </div>
    </div>
    <div class="pw-card-content" id="content">
      {danhsach}
    </div>
  </div>
</div>

<script>
  $(document).ready(() => {
    $('.date').datepicker({
      dateFormat: 'dd/mm/yy'
    })
  })

  function thongke() {
    vhttp.post('/dashboard/api/', {
      action: 'xemthongke',
      batdau: $('#batdau').val(),
      ketthuc: $('#ketthuc').val()
    }).then((resp) => {
      $('#content').html(resp.html)
    }, (e) => { })
  }
</script>
<!-- END: main -->