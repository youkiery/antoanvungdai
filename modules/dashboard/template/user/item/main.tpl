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

<div class="modal fade" id="modal-xoa-danh-muc" role="dialog">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-header">
        Xóa danh mục
        <button type="button" class="close" data-dismiss="modal">&times;</button> <br> <br>
      </div>
      <div class="modal-body text-center">
        <div class="form-group">
          Chuyển hàng hóa sang danh mục

          <select type="text" class="form-control" id="danh-muc-den"></select>
        </div>

        <button class="btn btn-danger btn-block" onclick="xacnhanxoadanhmuc()">
          Xác nhận
        </button>
      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="modal-them-danh-muc" role="dialog">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-header">
        Thêm danh mục
        <button type="button" class="close" data-dismiss="modal">&times;</button> <br> <br>
      </div>
      <div class="modal-body text-center">
        <div class="form-group row">
          <div class="col-xs-6">
            Tên danh mục
          </div>
          <div class="col-xs-18">
            <input type="text" class="form-control" id="ten-danh-muc">
          </div>
        </div>
        <button class="btn btn-success btn-block" onclick="xacnhanthemdanhmuc()">
          Xác nhận
        </button>
      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="modal-danh-muc" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        Danh sách danh mục
        <button type="button" class="close" data-dismiss="modal">&times;</button> <br> <br>
      </div>
      <div class="modal-body">
        <div class="form-group">
          <button class="btn btn-success" onclick="themdanhmuc()">
            <span class="fa fa-plus"></span> Thêm
          </button>
        </div>

        <div id="danh-sach-danh-muc"> </div>
      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="modal-xoa-hang-loat" role="dialog">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button> <br> <br>
        <div class="text-center">
          Các hàng hóa đang chọn sẽ bị xóa
          <button class="btn btn-danger btn-block" onclick="xacnhanxoahangloat()">
            Xác nhận
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
            <input autocomplete="off" type="text" class="form-control" id="tim-tu-khoa">
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

<div class="modal fade" id="modal-them-loai-hang" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title"> Thêm loại hàng </h4>
      </div>
      <div class="modal-body">
        <div class="form-group row">
          <div class="col-xs-8"> Loại hàng </div>
          <div class="col-xs-16">
            <input autocomplete="off" type="text" class="form-control" id="ten-loai-hang">
          </div>
        </div>

        <button class="btn btn-success btn-block" onclick="xacnhanthemloaihang()">
          Thêm
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
            <input autocomplete="off" type="text" class="form-control" id="them-ma-hang" placeholder="Mã hàng tự động" disabled>
          </div>
        </div>
        <div class="form-group row">
          <div class="col-xs-8"> Tên Hàng </div>
          <div class="col-xs-16">
            <input autocomplete="off" type="text" class="modal-them form-control" id="them-ten-hang">
          </div>
        </div>
        <div class="form-group row">
          <div class="col-xs-8"> Loại hàng </div>
          <div class="col-xs-16">
            <div class="input-group">
              <select id="them-loai-hang" class="modal-them form-control">
                {loaihang}
              </select>
              <div class="input-group-btn">
                <button class="btn btn-success" onclick="themloaihang()"> <span class="fa fa-plus"></span> </button>
              </div>
            </div>
          </div>
        </div>
        <div class="form-group row">
          <div class="col-xs-8"> Giá nhập </div>
          <div class="col-xs-16">
            <input autocomplete="off" type="text" class="modal-them form-control" id="them-gia-nhap">
          </div>
        </div>
        <div class="form-group row">
          <div class="col-xs-8"> Giá bán </div>
          <div class="col-xs-16">
            <input autocomplete="off" type="text" class="modal-them form-control" id="them-gia-ban">
          </div>
        </div>
        <div class="form-group row">
          <div class="col-xs-8"> Đơn vị </div>
          <div class="col-xs-16">
            <input autocomplete="off" type="text" class="modal-them form-control" id="them-don-vi">
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
      <!-- BEGIN: danhmuc -->
      <button class="btn btn-info" onclick="danhmuc()"> <span class="fa fa-folder-open"></span> Danh mục </button>
      <!-- END: danhmuc -->
    <div class="pw-card-header">
      <!-- BEGIN: import -->
      <button class="btn btn-info" onclick="importhang()"> <span class="fa fa-file"></span> Import </button>
      <!-- END: import -->
      <!-- BEGIN: export -->
      <button class="btn btn-info"> <span class="fa fa-file"></span> Export </button>
      <!-- END: export -->
      <!-- BEGIN: danhsach2 -->
      <button class="btn btn-info" onclick="timhang()"> <span class="fa fa-search"></span> Tìm kiếm </button>
      <!-- END: danhsach2 -->
      <!-- BEGIN: them -->
      <button class="btn btn-success" onclick="themhang()"> <span class="fa fa-plus"></span> Thêm hàng </button>
      <!-- END: them -->
      <!-- BEGIN: xoa -->
      <button class="btn btn-danger" id="congcu" onclick="xoahangloat()" style="display: none;"> <span class="fa fa-close"></span> Xóa đã chọn </button>
      <!-- END: xoa -->
    </div>
    <!-- BEGIN: danhsach -->
    <div class="pw-card-content" id="content">
      {danhsachhang}
    </div>
    <!-- END: danhsach -->
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
    },
    khoitaodanhmuc: false
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
    var file = $('#import-file')[0].files[0]
    if (!file) {
      vhttp.notify('Chọn file import trước khi thực hiện')
      return 0
    }
    var form = new FormData()
    form.append('file', file); 
    form.append('action', 'importhang');
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

  function themloaihang() {
    $('#ten-loai-hang').val('')
    $('#modal-them-loai-hang').modal('show')
  }

  function xacnhanthemloaihang() {
    vhttp.post('/dashboard/api/', {
      action: 'themloaihang',
      loaihang: $('#ten-loai-hang').val()
    }).then((resp) => {
      $('#them-loai-hang').html(resp.danhsach)
      $('#them-loai-hang').val(resp.id)
      $('#modal-them-loai-hang').modal('hide')
    }, (e) => { })
  }

  function themdanhmuc() {
    global.id = 0
    $('#ten-danh-muc').val('')
    $('#modal-them-danh-muc').modal('show')
  }

  function suadanhmuc(id, ten) {
    global.id = id
    $('#ten-danh-muc').val(ten)
    $('#modal-them-danh-muc').modal('show')
  }

  function xoadanhmuc(id) {
    global.id = id
    $('#modal-xoa-danh-muc').modal('show')
  }

  function xacnhanthemdanhmuc() {
    tendanhmuc = $('#ten-danh-muc').val()
    if (!tendanhmuc.length) vhttp.notify('Hãy điền tên danh mục')
    else {
      vhttp.post('/dashboard/api/', {
        action: 'themdanhmuc',
        tendanhmuc: tendanhmuc,
        id: global.id
      }).then((resp) => {
        $('#danh-sach-danh-muc').html(resp.html)
        $('#danh-muc-den').html(resp.option)
        $('#modal-them-danh-muc').modal('hide')
      }, (e) => { })
    }
  }

  function xacnhanxoadanhmuc() {
    danhmucden = $('#danh-muc-den').val()
    if (global.id == danhmucden) vhttp.notify('Xin hãy chọn danh mục khác')
    else {
      vhttp.post('/dashboard/api/', {
        action: 'xoadanhmuc',
        id: global.id,
        danhmucden: danhmucden
      }).then((resp) => {
        $('#danh-sach-danh-muc').html(resp.html)
        $('#danh-muc-den').html(resp.option)
        $('#modal-xoa-danh-muc').modal('hide')
      }, (e) => { })
    }
  }

  function danhmuc() {
    if (global.khoitaodanhmuc) $('#modal-danh-muc').modal('show')
    else { 
      vhttp.post('/dashboard/api/', {
        action: 'khoitaodanhmuc',
      }).then((resp) => {
        global.khoitaodanhmuc = true
        $('#danh-sach-danh-muc').html(resp.html)
        $('#danh-muc-den').html(resp.option)
        $('#modal-danh-muc').modal('show')
      }, (e) => { })
    }
  }

  function xoahangloat() {
    $('#modal-xoa-hang-loat').modal('show')
  }

  function xacnhanxoahangloat() {
    danhsach = []
    $('.checkbox:checked').each((index, item) => {
      danhsach.push(item.getAttribute('ref'))
    })
    vhttp.post('/dashboard/api/', {
      action: 'xoahangloat',
      danhsach: danhsach
    }).then((resp) => {
      $('#content').html(resp.html)
      $('#congcu').hide()
      $('#modal-xoa-hang-loat').modal('hide')
    }, (e) => { })
  }

  function kiemtra(e) {
    if (e.currentTarget.getAttribute('id') == 'all') $('.checkbox').prop('checked', $('#all').prop('checked'))
    else $('#all').prop('checked', false)
    if ($('.checkbox:checked').length) $('#congcu').show()
    else $('#congcu').hide()
  }

  function chitiet(id) {
    var load = $('#tr-' + id)
    if (load.attr('load') == '0') {
      vhttp.post('/dashboard/api/', {
        action: 'chitiethang',
        id: id
      }).then((resp) => {
        load.attr('load', '1')
        $('#td-' + id).html(resp.html)
      }, (e) => { })
    }
    if (load.css('display') == 'none') {
      $('.chitiet:visible').hide().delay(200)
      load.fadeToggle()
    }
    else load.fadeToggle()
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