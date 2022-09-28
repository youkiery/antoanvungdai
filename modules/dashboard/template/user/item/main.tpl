<!-- BEGIN: main -->
<div class="modal fade" id="modal-import" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button> <br> <br>
        <div class="text-center">
          Tệp mẫu <button class="btn btn-info" onclick="download('item')"> <span class="fa fa-download"></span>
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

<div class="modal fade" id="modal-xoa-hang" role="dialog">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button> <br> <br>
        <div class="text-center">
          Xác nhận xóa hàng hóa
          <button class="btn btn-danger btn-block" onclick="xacnhanxoa()"> Xóa </button>
        </div>
      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="modal-tim-hang" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title"> Tìm kiếm hàng hóa </h4>
      </div>
      <div class="modal-body">

        <div class="form-group row">
          <div class="col-xs-8"> Từ khóa tìm kiếm </div>
          <div class="col-xs-16">
            <input type="text" class="form-control" id="tim-tu-khoa">
          </div>
        </div>

        <div class="form-group row">
          <div class="col-xs-8"> Loại hàng </div>
          <div class="col-xs-16">
            <select id="tim-loai-hang" class="form-control">
              {loaihang}
            </select>
          </div>
        </div>

        <button class="btn btn-info btn-block" onclick="timkiem(1)">
          Tìm kiếm
        </button>

      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="modal-them-hang" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title"> Thêm hàng hóa </h4>
      </div>
      <div class="modal-body">

        <div class="form-group row">
          <div class="col-xs-8"> Mã Hàng </div>
          <div class="col-xs-16">
            <input type="text" class="modal-them form-control" id="them-ma-hang" placeholder="Mã hàng tự động">
          </div>
        </div>
        <div class="form-group row">
          <div class="col-xs-8"> Tên Hàng </div>
          <div class="col-xs-16">
            <input type="text" class="modal-them form-control" id="them-ten-hang">
          </div>
        </div>
        <div class="form-group row">
          <div class="col-xs-8"> Loại hàng </div>
          <div class="col-xs-16">
            <select id="them-loai-hang" class="modal-them form-control">
              {loaihang}
            </select>
          </div>
        </div>
        <div class="form-group row">
          <div class="col-xs-8"> Giá nhập </div>
          <div class="col-xs-16">
            <input type="text" class="modal-them form-control" id="them-gia-nhap">
          </div>
        </div>
        <div class="form-group row">
          <div class="col-xs-8"> Giá bán </div>
          <div class="col-xs-16">
            <input type="text" class="modal-them form-control" id="them-gia-ban">
          </div>
        </div>
        <div class="form-group row">
          <div class="col-xs-8"> Đơn vị </div>
          <div class="col-xs-16">
            <input type="text" class="modal-them form-control" id="them-don-vi">
          </div>
        </div>
        <div class="form-group row">
          <div class="col-xs-8"> Giới thiệu </div>
          <div class="col-xs-16">
            <textarea type="text" class="modal-them form-control" id="them-gioi-thieu"></textarea>
          </div>
        </div>
        <div class="pw-image-panel" id="them-hinh"> </div>

        <button class="insert btn btn-success btn-block" onclick="xacnhanthem()">
          Thêm hàng
        </button>
        <button class="update btn btn-info btn-block" onclick="xacnhansua()">
          Sửa hàng
        </button>
      </div>
    </div>
  </div>
</div>

<div class="pw-content" id="main">
  <div class="pw-header">
    Hàng hóa
  </div>

  <div class="pw-card">
    <div class="pw-card-header">
      <button class="btn btn-info" onclick="importhang()"> <span class="fa fa-file"></span> </button>
      <button class="btn btn-info" onclick="timhang()"> <span class="fa fa-search"></span> </button>
      <button class="btn btn-success" onclick="themhang()"> <span class="fa fa-plus"></span> </button>
    </div>
    <div class="pw-card-content" id="content">
      {danhsachhang}
    </div>
  </div>
</div>

<script>
  var config = {
    apiKey: "AIzaSyDWt6y4laxeTBq2RYDY6Jg4_pOkdxwsjUE",
    authDomain: "directed-sonar-241507.firebaseapp.com",
    databaseURL: "https://directed-sonar-241507.firebaseio.com",
    projectId: "directed-sonar-241507",
    storageBucket: "directed-sonar-241507.appspot.com",
    messagingSenderId: "816396321770",
    appId: "1:816396321770:web:193e84ee21b16d41"
  }
  var global = {
    id: 0,
    filter: {
      page: 1,
      tukhoa: '',
      loaihang: '',
    }
  }

  $(document).ready(() => {
    // install filter
    // load()
    vnumber.install('#them-gia-nhap')
    vnumber.install('#them-gia-ban')
    firebase.initializeApp(config);
    vimage.path = '/pw/images'
    vimage.install('them-hinh')
  })

  function chonfile() {
    var file = $('#import-file').val()
    if (file) $('#import-btn').show()
    else $('#import-btn').hide()
  }

  function importhang() {
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
    var form = new FormData()
    form.append('action', 'importhang');
    form.append('file', $('#import-file')[0].files[0]); 
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

  function themhang() {
    $('#them-ma-hang').val('')
    $('#them-ten-hang').val('')
    $('#them-gia-nhap').val(0)
    $('#them-gia-ban').val(0)
    $('.modal-them').prop('disabled', false)
    $('.insert').show()
    $('.update').hide()
    vimage.clear('them-hinh')
    $('#modal-them-hang').modal('show')
  }

  async function xacnhanthem() {
    let ketqua = await kiemtrahang()
    if (!ketqua) return 0
    $('.modal-them').prop('disabled', true)
    await vimage.uploadimage('them-hinh')
    vhttp.post('/dashboard/api/', {
      action: 'themhang',
      filter: global.filter,
      data: {
        mahang: $('#them-ma-hang').val(),
        tenhang: $('#them-ten-hang').val(),
        loaihang: $('#them-loai-hang').val(),
        gianhap: $('#them-gia-nhap').val(),
        giaban: $('#them-gia-ban').val(),
        donvi: $('#them-don-vi').val(),
        gioithieu: $('#them-gioi-thieu').val(),
        hinhanh: vimage.data['them-hinh'],
      }
    }).then((resp) => {
      $('#content').html(resp.danhsach)
      $('#modal-them-hang').modal('hide')
    }, (e) => {

    })
  }

  function suahang(id) {
    $('.modal-them').prop('disabled', true)
    $('.insert').hide()
    $('.update').show()
    global.id = id
    vhttp.post('/dashboard/api/', {
      action: 'thongtinhang',
      id: id,
    }).then((resp) => {
      data = resp.data
      $('#them-ma-hang').val(data.mahang),
        $('#them-ten-hang').val(data.tenhang),
        $('#them-loai-hang').val(data.loaihang),
        $('#them-gia-nhap').val(data.gianhap),
        $('#them-gia-ban').val(data.giaban),
        $('#them-don-vi').val(data.donvi),
        $('#them-gioi-thieu').val(data.gioithieu),
        vimage.data['them-hinh'] = data.hinhanh
      vimage.reload('them-hinh')
      $('.modal-them').prop('disabled', false)
      $('#modal-them-hang').modal('show')
    }, (e) => { })
  }

  async function xacnhansua() {
    let ketqua = await kiemtrahang()
    if (!ketqua) return 0
    $('.modal-them').prop('disabled', true)
    await vimage.uploadimage('them-hinh')
    vhttp.post('/dashboard/api/', {
      action: 'suahang',
      id: global.id,
      data: {
        mahang: $('#them-ma-hang').val(),
        tenhang: $('#them-ten-hang').val(),
        loaihang: $('#them-loai-hang').val(),
        gianhap: $('#them-gia-nhap').val(),
        giaban: $('#them-gia-ban').val(),
        donvi: $('#them-don-vi').val(),
        gioithieu: $('#them-gioi-thieu').val(),
        hinhanh: vimage.data['them-hinh'],
      }
    }).then((resp) => {
      $('#content').html(resp.danhsach)
      $('#modal-them-hang').modal('hide')
    }, (e) => { })
  }

  async function kiemtrahang() {
    return new Promise((resolve) => {
      let tinnhan = ''
      if (!$('#them-ten-hang').val().length) tinnhan = 'Xin hãy nhập tên hàng'
      if (tinnhan.length) {
        vhttp.notify(tinnhan)
        resolve(0)
      }
      resolve(1)
    })
  }

  function xoahang(id) {
    global.id = id
    $('#modal-xoa-hang').modal('show')
  }

  function xacnhanxoa() {
    vhttp.post('/dashboard/api/', {
      action: 'xoahang',
      id: global.id,
    }).then((resp) => {
      $('#content').html(resp.danhsach)
      $('#modal-xoa-hang').modal('hide')
    }, (e) => { })
  }

  function timhang() {
    $('#modal-tim-hang').modal('show')
  }

  function timkiem(page) {
    global.filter.page = page
    global.filter.tukhoa = $('#tim-tu-khoa').val()
    global.filter.loaihang = $('#tim-loai-hang').val()

    vhttp.post('/dashboard/api/', {
      action: 'taihang',
      filter: global.filter
    }).then((resp) => {
      $('#content').html(resp.danhsach)
      $('#modal-tim-hang').modal('hide')
    }, (e) => { })
  }

  // async function xacnhanthem() {
  //   await vimage.uploadimage('them-hinh')
  //   vhttp.post('/dashboard/api/', {
  //     action: 'themhang',
  //     filter: global.filter,
  //     data: {
  //       mahang: $('#them-ma-hang').val(),
  //       tenhang: $('#them-ten-hang').val(),
  //       loaihang: $('#them-loai-hang').val(),
  //       gianhap: $('#them-gia-nhap').val(),
  //       giaban: $('#them-gia-ban').val(),
  //       donvi: $('#them-don-vi').val(),
  //       gioithieu: $('#them-gioi-thieu').val(),
  //       hinhanh: vimage.data['them-hinh'],
  //     }
  //   }).then((resp) => {
  //     $('#content').html(resp.list)
  //     $('#modal-them-hang').modal('show')
  //   }, (e) => {})
  // }

  function filter() {
    global.filter = {
      page: 1,
      keyword: ''
    }
    load()
  }
</script>
<!-- END: main -->