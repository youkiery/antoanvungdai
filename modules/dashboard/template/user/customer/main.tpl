<!-- BEGIN: main -->
<div class="modal fade" id="modal-import" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button> <br> <br>
        <div class="text-center">
          Tệp mẫu <button class="btn btn-info" onclick="download('customer')"> <span class="fa fa-download"></span>
          </button>
          <input type="file" id="import-file" onchange="chonfile()"
            accept=".csv, application/vnd.openxmlformats-officedocument.spreadsheetml.sheet, application/vnd.ms-excel">
          <button class="btn btn-info btn-block" id="import-btn" onclick="xacnhanimport()">
            Thực hiện
          </button>
        </div>
      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="modal-xoa-khach" role="dialog">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button> <br> <br>
        <div class="text-center">
          Xác nhận xóa khách hàng
          <button class="btn btn-danger btn-block" onclick="xacnhanxoakhach()"> Xóa </button>
        </div>
      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="modal-tim-khach" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title"> Tìm kiếm khách hàng </h4>
      </div>
      <div class="modal-body">

        <div class="form-group row">
          <div class="col-xs-8"> Tên, điện thoại khách </div>
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

<div class="modal fade" id="modal-them-khach" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title"> Khách hàng </h4>
      </div>
      <div class="modal-body">
        <div class="form-group row">
          <div class="col-xs-8"> Mã khách </div>
          <div class="col-xs-16">
            <input autocomplete="off" type="text" class="form-control" id="khach-ma" placeholder="Mã khách hàng tự động" disabled>
          </div>
        </div>
        <div class="form-group row">
          <div class="col-xs-8"> Khách hàng </div>
          <div class="col-xs-16">
            <input autocomplete="off" type="text" class="form-control" id="khach-ten">
          </div>
        </div>
        <div class="form-group row">
          <div class="col-xs-8"> Điện thoại </div>
          <div class="col-xs-16">
            <input autocomplete="off" type="text" class="form-control" id="khach-dien-thoai">
          </div>
        </div>
        <div class="form-group row">
          <div class="col-xs-8"> Địa chỉ </div>
          <div class="col-xs-16">
            <textarea type="text" class="form-control" id="khach-dia-chi"></textarea>
          </div>
        </div>

        <button class="insert btn btn-success btn-block" onclick="xacnhanthemkhach()">
          Thêm khách
        </button>
        <button class="update btn btn-info btn-block" onclick="xacnhanthemkhach()">
          Cập nhật
        </button>
      </div>
    </div>
  </div>
</div>

<div class="pw-content" id="main">
  <div class="pw-header">
    Khách hàng
  </div>

  <div class="pw-card">
    <div class="pw-card-header">
      <button class="btn btn-info" onclick="importkhach()"> <span class="fa fa-file"></span> Import khách hàng </button>
      <button class="btn btn-info" onclick="timkhach()"> <span class="fa fa-search"></span> Tìm kiếm </button>
      <button class="btn btn-success" onclick="themkhach()"> <span class="fa fa-plus"></span> Thêm khách </button>
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

  function xoakhach(id) {
    global.id = id
    $('#modal-xoa-khach').modal('show')
  }

  async function xacnhanxoakhach() {
    vhttp.post('/dashboard/api/', {
      action: 'xoakhach',
      id: global.id,
    }).then((resp) => {
      $('#content').html(resp.danhsach)
      $('#modal-xoa-khach').modal('hide')
    }, (e) => { })
  }

  function themkhach() {
    $('#khach-ten').val('')
    $('#khach-dien-thoai').val($('#tim-khach').val())
    $('#khach-dia-chi').val('')
    $('.insert').show()
    $('.update').hide()
    $('#modal-them-khach').modal('show')
  }

  function suakhach(id, ma, ten, diachi, dienthoai) {
    global.id = id
    $('#khach-ma').val(ma)
    $('#khach-ten').val(ten)
    $('#khach-dien-thoai').val(dienthoai)
    $('#khach-dia-chi').val(diachi)
    $('.insert').hide()
    $('.update').show()
    $('#modal-them-khach').modal('show')
  }

  async function xacnhanthemkhach() {
    data = {
      id: 0,
      diem: 0,
      kichhoat: 0,
      tienno: 0,
      makhach: $('khach-ma').val(),
      diachi: $('#khach-dia-chi').val(),
      dienthoai: $('#khach-dien-thoai').val(),
      tenkhach: $('#khach-ten').val(),
    }
    if (!data.tenkhach.length) {
      vhttp.notify('Xin hãy nhập tên khách')
      return 0
    }
    else if (!data.dienthoai.length) {
      vhttp.notify('Xin hãy nhập số điện thoại')
      return 0
    }
    vhttp.post('/dashboard/api/', {
      action: 'themkhach',
      vitri: 'khachhang',
      id: global.id,
      data: data
    }).then((resp) => {
      $('#content').html(resp.danhsach)
      $('#modal-them-khach').modal('hide')
    }, (e) => {

    })
  }

  function timkhach() {
    $('#modal-tim-khach').modal('show')
  }

  function timkiem(page) {
    global.filter.page = page
    global.filter.tukhoa = $('#tim-tu-khoa').val()

    vhttp.post('/dashboard/api/', {
      action: 'taikhach',
      filter: global.filter
    }).then((resp) => {
      $('#content').html(resp.danhsach)
      $('#modal-tim-khach').modal('hide')
    }, (e) => { })
  }

  function chonfile() {
    var file = $('#import-file').val()
    if (file) $('#import-btn').show()
    else $('#import-btn').hide()
  }

  function importkhach() {
    $('#import-btn').hide()
    $('#import-file').val('')
    $('#modal-import').modal('show')
  }

  function download(filename) {
    vhttp.post('/dashboard/api/', {
      action: 'download',
      filename: filename
    }).then((resp) => {
      // nếu trả về link thì download
      window.location = resp.link;
    }, (e) => { })
  }

  function xacnhanimport() {
    var file = $('#import-file')[0].files[0]
    if (!file) {
      vhttp.notify('Chọn file import trước khi thực hiện')
      return 0
    }
    var form = new FormData()
    form.append('file', file); 
    form.append('action', 'importkhach');
    $.ajax({
      url: '/dashboard/api/',
      type: 'post',
      data: form,
      processData: false,
      contentType: false
    }).done((x) => {
      try {
        var json = JSON.parse(x)
        if (json.messenger.length) vhttp.notify(json.messenger)
        if (json.status) {
          setTimeout(() => {
            window.location.reload()
          }, 1000);
        }
      }
      catch (error) {

      }
    }).fail(() => { });
  }
</script>
<!-- END: main -->