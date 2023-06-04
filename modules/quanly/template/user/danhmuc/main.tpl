<!-- BEGIN: main -->
<div id="modal-xoaphuong" class="modal fade" role="dialog">
  <div class="modal-dialog modal-sm">
    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title"> Xóa phường </h4>
      </div>
      <div class="modal-body text-center">
        Xác nhận xóa phường này
        <button class="btn btn-danger btn-block" onclick="xacnhanxoaphuong()">
          Xóa
        </button>
      </div>
    </div>
  </div>
</div>

<div id="modal-xoagiong" class="modal fade" role="dialog">
  <div class="modal-dialog modal-sm">
    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title"> Xóa giống </h4>
      </div>
      <div class="modal-body text-center">
        Xác nhận xóa giống này
        <button class="btn btn-danger btn-block" onclick="xacnhanxoagiong()">
          Xóa
        </button>
      </div>
    </div>
  </div>
</div>

<div id="modal-themphuong" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title"> Thêm phường </h4>
      </div>
      <div class="modal-body">
        <div class="form-group row">
          <div class="col-xs-8"> Tên phường </div>
          <div class="col-xs-16">
            <input type="text" class="form-control" id="tenphuong" placeholder="Tên phường">
          </div>
        </div>

        <button class="btn btn-success btn-block them" onclick="xacnhanthemphuong()">
          Thêm
        </button>
        <button class="btn btn-info btn-block capnhat" onclick="xacnhanthemphuong()">
          Cập nhật
        </button>
      </div>
    </div>
  </div>
</div>

<div id="modal-themgiong" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title"> Thêm giống </h4>
      </div>
      <div class="modal-body">
        <div class="form-group row">
          <div class="col-xs-8">
            Tên giống
          </div>
          <div class="col-xs-16">
            <input type="text" class="form-control" id="tengiong" placeholder="Tên giống">
          </div>
        </div>

        <button class="btn btn-success btn-block them" onclick="xacnhanthemgiong()">
          Thêm
        </button>
        <button class="btn btn-info btn-block capnhat" onclick="xacnhanthemgiong()">
          Cập nhật
        </button>
      </div>
    </div>
  </div>
</div>

<div class="margin-left-sm">
  <a href="/quanly" class="margin-right-lg">
    <em class="fa fa-caret-right margin-right-sm"></em> Trở về quản lý
  </a>
</div>

<div class="form-group">
  <button class="btn btn-success" onclick="themphuong()">
    <span class="fa fa-plus-circle"></span> Thêm phường
  </button>
  <button class="btn btn-success" onclick="themgiong()">
    <span class="fa fa-plus-circle"></span> Thêm giống
  </button>
</div>

<ul class="nav nav-tabs">
  <li class="active"><a data-toggle="tab" href="#phuong">Danh sách phường phường</a></li>
  <li><a data-toggle="tab" href="#giong"> Danh mục giống loài</a></li>
</ul>

<div class="form-group"></div>

<div class="tab-content">
  <div id="phuong" class="tab-pane fade in active">
    {danhsachphuong}
  </div>
  <div id="giong" class="tab-pane fade">
    {danhsachgiong}
  </div>
</div>

<script>
  var global = {
    id: 0
  }

  function hienthinut() {
    if (global.id) {
      $('.them').hide()
      $('.capnhat').show()
    }
    else {
      $('.capnhat').hide()
      $('.them').show()
    }
  }

  function xoaphuong(id) {
    global.id = id
    $('#modal-xoaphuong').modal('show')
  }

  function xoagiong(id) {
    global.id = id
    $('#modal-xoagiong').modal('show')
  }

  function themphuong() {
    global.id = 0
    hienthinut()
    $('#tenphuong').val('')
    $('#modal-themphuong').modal('show')
  }

  function capnhatphuong(id, tenphuong) {
    global.id = id
    hienthinut()
    $('#tenphuong').val(tenphuong)
    $('#modal-themphuong').modal('show')
  }

  function xacnhanxoaphuong() {
    vhttp.post('/quanly/api/', {
      action: 'xoaphuong',
      id: global.id,
    }).then((phanhoi) => {
      $('#phuong').html(phanhoi.danhsachphuong)
      $('#modal-xoaphuong').modal('hide')
    })
  }

  function xacnhanxoagiong() {
    vhttp.post('/quanly/api/', {
      action: 'xoagiong',
      id: global.id,
    }).then((phanhoi) => {
      $('#giong').html(phanhoi.danhsachgiong)
      $('#modal-xoagiong').modal('hide')
    })
  }

  function xacnhanthemphuong() {
    vhttp.post('/quanly/api/', {
      action: 'themphuong',
      id: global.id,
      tenphuong: $('#tenphuong').val()
    }).then((phanhoi) => {
      $('#phuong').html(phanhoi.danhsachphuong)
      $('.nav-tabs a[href="#phuong"]').tab('show');
      $('#modal-themphuong').modal('hide')
    })
  }

  function themgiong() {
    global.id = 0
    hienthinut()
    $('#tengiong').val('')
    $('#modal-themgiong').modal('show')
  }

  function capnhatgiong(id, tengiong) {
    global.id = id
    hienthinut()
    $('#tengiong').val(tengiong)
    $('#modal-themgiong').modal('show')
  }

  function xacnhanthemgiong() {
    vhttp.post('/quanly/api/', {
      action: 'themgiong',
      id: global.id,
      tengiong: $('#tengiong').val()
    }).then((phanhoi) => {
      $('#giong').html(phanhoi.danhsachgiong)
      $('.nav-tabs a[href="#giong"]').tab('show');
      $('#modal-themgiong').modal('hide')
    })
  }
</script>
<!-- END: main -->