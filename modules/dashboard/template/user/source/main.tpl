<!-- BEGIN: main -->
<div class="modal fade" id="modal-xoa-nguon" role="dialog">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button> <br> <br>
        <div class="text-center">
          Xác nhận xóa nguồn cung
          <button class="btn btn-danger btn-block" onclick="xacnhanxoanguon()"> Xóa </button>
        </div>
      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="modal-tim-nguon" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title"> Tìm kiếm nguồn cung </h4>
      </div>
      <div class="modal-body">

        <div class="form-group row">
          <div class="col-xs-8"> Mã hàng hoặc tên hàng </div>
          <div class="col-xs-16">
            <input autocomplete="off" type="text" class="form-control" id="tim-tu-khoa">
          </div>
        </div>

        <button class="btn btn-info btn-block" onclick="timkiem(1)">
          Tìm kiếm
        </button>

      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="modal-them-nguon" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title"> Nguồn cung </h4>
      </div>
      <div class="modal-body">
        <div class="form-group row">
          <div class="col-xs-8"> Mã nguồn cung </div>
          <div class="col-xs-16">
            <input autocomplete="off" type="text" class="form-control" id="nguon-ma" placeholder="Mã nguồn cung tự động" disabled>
          </div>
        </div>
        <div class="form-group row">
          <div class="col-xs-8"> Nhà cung cấp </div>
          <div class="col-xs-16">
            <input autocomplete="off" type="text" class="form-control" id="nguon-ten">
          </div>
        </div>
        <div class="form-group row">
          <div class="col-xs-8"> Điện thoại </div>
          <div class="col-xs-16">
            <input autocomplete="off" type="text" class="form-control" id="nguon-dien-thoai">
          </div>
        </div>
        <div class="form-group row">
          <div class="col-xs-8"> Địa chỉ </div>
          <div class="col-xs-16">
            <textarea type="text" class="form-control" id="nguon-dia-chi"></textarea>
          </div>
        </div>

        <button class="insert btn btn-success btn-block" onclick="xacnhanthemnguon()">
          Thêm nguồn cung
        </button>
        <button class="update btn btn-info btn-block" onclick="xacnhanthemnguon()">
          Cập nhật
        </button>
      </div>
    </div>
  </div>
</div>

<div class="pw-content" id="main">
  <div class="pw-header">
    Nguồn cung
  </div>

  <div class="pw-card">
    <div class="pw-card-header">
      <button class="btn btn-info" onclick="timnguon()"> <span class="fa fa-search"></span> Tìm kiếm </button>
      <button class="btn btn-success" onclick="themnguon()"> <span class="fa fa-plus"></span> Thêm nguồn </button>
    </div>
    <div class="pw-card-content" id="content">
      {danhsach}
    </div>
  </div>
</div>

<script>
  var global = {
    id: 0,
    filter: {
      page: 1,
      tukhoa: '',
    }
  }

  $(document).ready(() => {
    // install filter
    vhttp.alert()
  })

  function xoanguon(id) {
    global.id = id
    $('#modal-xoa-nguon').modal('show')
  }

  async function xacnhanxoanguon() {
    vhttp.post('/dashboard/api/', {
      action: 'xoanguon',
      id: global.id,
    }).then((resp) => {
      $('#content').html(resp.danhsach)
      $('#modal-xoa-nguon').modal('hide')
    }, (e) => {

    })
  }

  function themnguon() {
    $('#nguon-ten').val('')
    $('#nguon-dien-thoai').val('')
    $('#nguon-dia-chi').val('')
    $('.insert').show()
    $('.update').hide()
    $('#modal-them-nguon').modal('show')
  }

  function suanguon(id, ma, ten, diachi, dienthoai) {
    global.id = id
    $('#nguon-ma').val(ma)
    $('#nguon-ten').val(ten)
    $('#nguon-dien-thoai').val(diachi)
    $('#nguon-dia-chi').val(dienthoai)
    $('.insert').hide()
    $('.update').show()
    $('#modal-them-nguon').modal('show')
  }

  async function xacnhanthemnguon() {
    data = {
      ten: $('#nguon-ten').val(),
      dienthoai: $('#nguon-dien-thoai').val(),
      diachi: $('#nguon-dia-chi').val(),
    }
    if (!data.ten.length) {
      vhttp.notify('Xin hãy nhập tên nguồn')
      return 0
    }
    vhttp.post('/dashboard/api/', {
      action: 'themnguon',
      vitri: 'nguonhang',
      id: global.id,
      data: data
    }).then((resp) => {
      $('#content').html(resp.danhsach)
      $('#modal-them-nguon').modal('hide')
    }, (e) => {

    })
  }

  function timnguon() {
    $('#modal-tim-nguon').modal('show')
  }

  function timkiem(page) {
    global.filter.page = page
    global.filter.tukhoa = $('#tim-tu-khoa').val()

    vhttp.post('/dashboard/api/', {
      action: 'tainguon',
      filter: global.filter
    }).then((resp) => {
      $('#content').html(resp.danhsach)
      $('#modal-tim-nguon').modal('hide')
    }, (e) => { })
  }
</script>
<!-- END: main -->