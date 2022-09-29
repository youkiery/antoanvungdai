<!-- BEGIN: main -->
<div class="modal fade" id="modal-xoa-nhap" role="dialog">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button> <br> <br>
        <div class="text-center">
          Xác nhận xóa phiếu nhập
          <button class="btn btn-danger btn-block" onclick="xacnhanxoanhap()"> Xóa </button>
        </div>
      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="modal-tim-nhap" role="dialog">
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
          <div class="col-xs-8"> Lọc theo thời gian </div>
          <div class="col-xs-8">
            <div class="input-group">
              <input type="text" class="form-control date" id="tim-bat-dau" value="{batdau}">
              <div class="input-group-addon"> <span class="fa fa-calendar"></span> </div>
            </div>
          </div>
          <div class="col-xs-8">
            <div class="input-group">
              <input type="text" class="form-control date" id="tim-ket-thuc" value="{ketthuc}">
              <div class="input-group-addon"> <span class="fa fa-calendar"></span> </div>
            </div>
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
          <div class="col-xs-8"> Nhà cung cấp </div>
          <div class="col-xs-16">
            <input type="text" class="form-control" id="nguon-ten">
          </div>
        </div>
        <div class="form-group row">
          <div class="col-xs-8"> Điện thoại </div>
          <div class="col-xs-16">
            <input type="text" class="form-control" id="nguon-dien-thoai">
          </div>
        </div>
        <div class="form-group row">
          <div class="col-xs-8"> Địa chỉ </div>
          <div class="col-xs-16">
            <textarea type="text" class="form-control" id="nguon-dia-chi"></textarea>
          </div>
        </div>

        <button class="btn btn-success btn-block" onclick="xacnhanthemnguon()">
          Thêm nguồn
        </button>
      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="modal-them-nhap" role="dialog">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title"> Nhập hàng hóa </h4>
      </div>

      <div class="modal-body">
        <div class="form-group relative">
          <div class="input-group">
            <input type="text" class="form-control" id="them-nhap-hang" placeholder="Tìm kiếm hàng hóa">
            <div class="input-group-btn">
              <button class="btn btn-success" onclick="themhang()"> <span class="fa fa-plus"></span> </button>
            </div>
          </div>
          <div class="suggest" id="goiy-them-nhap-hang"> </div>
        </div>

        <div class="form-group">
          <div class="input-group">
            <select class="form-control" id="them-nguon-cung">
              {nguoncung}
            </select>
            <div class="input-group-btn">
              <button class="btn btn-success" onclick="themnguon()"> <span class="fa fa-plus"></span> </button>
            </div>
          </div>
        </div>

        <div id="danh-sach-nhap"></div>

        <div id="loi-import" style="color: red; font-weight: bold">

        </div>
        <div class="text-center" id="mau-import">
          Tệp mẫu <button class="btn btn-info" onclick="download('customer')"> <span class="fa fa-download"></span>
          </button>
          <input type="file" id="import-file" onchange="chonfile()"
            accept=".csv, application/vnd.openxmlformats-officedocument.spreadsheetml.sheet, application/vnd.ms-excel">
          <button class="btn btn-info btn-block" id="import-btn" onclick="xacnhanimport()">
            Thực hiện
          </button>
        </div>

        <div> <b> Thành tiền: </b> <span id="thanh-tien"></span> </div>

        <div class="row">
          <div class="col-xs-12">
            <button class="insert btn btn-success btn-block" onclick="xacnhanthemnhap(1)">
              Xác nhận
            </button>
          </div>
          <div class="col-xs-12">
            <button class="insert btn btn-success btn-block" onclick="xacnhanthemnhap(0)">
              Lưu tạm
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<div class="pw-content" id="main">
  <div class="pw-header">
    Nhập hàng
  </div>

  <div class="pw-card">
    <div class="pw-card-header">
      <button class="btn btn-info" onclick="timnhap()"> <span class="fa fa-search"></span> </button>
      <button class="btn btn-success" onclick="themnhap()"> <span class="fa fa-plus"></span> </button>
    </div>
    <div class="pw-card-content" id="content">
      {danhsach}
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
    danhsach: [],
    thanhtien: 0,
    hanghoa: [],
    filter: {
      page: 1,
      tukhoa: '',
      batdau: '',
      ketthuc: '',
    }
  }

  $(document).ready(() => {
    // install filter
    // load()
    $('.date').datepicker({
      dateFormat: 'dd/mm/yy'
    })

    vremind.install('#them-nhap-hang', '#goiy-them-nhap-hang', (tukhoa) => {
      return new Promise((resolve) => {
        vhttp.post('/dashboard/api/', {
          action: 'timnhaphang',
          tukhoa: tukhoa
        }).then((phanhoi) => {
          global.hanghoa = phanhoi.danhsach
          if (!global.hanghoa.length) resolve('Không có hàng hóa phù hợp')

          let html = ''
          global.hanghoa.forEach((hanghoa, thutu) => {
            html += `
            <div class="suggest-item suggest-item-lg" onclick="themhanghoa(`+ thutu + `)">
              <div class="pw-suggest-image"> <img src="`+ hanghoa.hinhanh + `"> </div>
              <div class="pw-suggest-info">
                <b>`+ hanghoa.mahang + `</b> <br>
                `+ hanghoa.tenhang + ` <br>
                `+ (hanghoa.donvi.length ? '(' + hanghoa.donvi + ')' : '') + `
              </div>
            </div>`
          });
          resolve(html)
        }, () => { })
      })
    }, 300, 300)

    vhttp.alert()
    vnumber.install('#them-gia-nhap')
    vnumber.install('#them-gia-ban')
    firebase.initializeApp(config);
    vimage.path = '/pw/images'
    vimage.install('them-hinh')
  })

  function themnhap() {
    global.danhsach = []
    global.thanhtien = 0
    global.id = 0
    $('#loi-import').hide()
    $('#import-file').val(null)
    $('#them-nguon-cung option:first-child').prop('selected', true)
    $('#thanh-tien').text('0')
    tailaidanhsach()
    $('#modal-them-nhap').modal('show')
  }

  function suanhap(id) {
    vhttp.post('/dashboard/api/', {
      action: 'thongtinnhap',
      id: id,
    }).then((resp) => {
      global.id = id
      global.danhsach = resp.danhsach
      tailaidanhsach()
      $('#loi-import').hide()
      $('#import-file').val(null)
      $('#them-nguon-cung').val(resp.nguoncung)
      $('#modal-them-nhap').modal('show')
    }, (e) => { })
  }

  function xoanhap(id) {
    global.id = id
    $('#modal-xoa-nhap').modal('show')
  }

  function xacnhanxoanhap() {
    vhttp.post('/dashboard/api/', {
      action: 'xoanhap',
      id: global.id,
    }).then((resp) => {
      $('#content').html(resp.danhsach)
      $('#modal-xoa-nhap').modal('show')
    }, (e) => { })
  }

  function tailaidanhsach(submit = false) {
    let thanhtien = 0
    let html = `
    <table class="table table-bordered">
      <tr> 
        <th>Mã hàng</th>
        <th>Tên hàng</th>
        <th>Đơn giá</th>
        <th>Số lượng</th>
        <th>Thành tiền</th>
        <th></th>
      </tr>`
    global.danhsach.forEach((hanghoa, thutu) => {
      html += `
      <tr id="hanghoa-`+ thutu + `" thutu="` + thutu + `">
        <td> `+ hanghoa.mahang + ` </td>
        <td> `+ hanghoa.tenhang + ` </td>
        <td> <input class="form-control" id="dongia-`+ thutu + `" onkeyup="lienketdulieu('dongia', ` + thutu + `)" value="` + vnumber.format(hanghoa.dongia) + `"> </td>
        <td> <input class="form-control" id="soluong-`+ thutu + `" onkeyup="lienketdulieu('soluong', ` + thutu + `)" value="` + vnumber.format(hanghoa.soluong) + `"> </td>
        <td id="thanhtien-`+ thutu + `"> ` + vnumber.format(hanghoa.thanhtien) + ` </td>
        <td> <button class="btn btn-danger btn-xs" onclick="xoahanghoa(`+ thutu + `)">xóa</button> </td>
      </tr>`
      thanhtien += Number(vnumber.clear(hanghoa.thanhtien))
    })
    $('#danh-sach-nhap').html(html + `</table>`)

    if (global.danhsach.length) $('#mau-import').hide()
    else $('#mau-import').show()
    global.thanhtien = thanhtien
    $('#thanh-tien').text(vnumber.format(thanhtien))
  }

  function themhanghoa(thutu) {
    var vitri = -1
    var hanghoa = global.hanghoa[thutu]
    global.danhsach.forEach((hang, vitrichay) => {
      if (hang.mahang == hanghoa.mahang) {
        vitri = vitrichay
      }
    });
    // neu chua, them vao
    if (vitri < 0) {
      global.danhsach.push({
        id: global.hanghoa[thutu].id,
        mahang: global.hanghoa[thutu].mahang,
        tenhang: global.hanghoa[thutu].tenhang,
        hinhanh: global.hanghoa[thutu].hinhanh,
        dongia: global.hanghoa[thutu].dongia,
        soluong: 0,
        thanhtien: global.hanghoa[thutu].dongia,
      })
      vitri = global.danhsach.length - 1
    }
    // so luong + 1, day len dau danh sach
    global.danhsach[vitri].soluong++
    for (let i = vitri; i > 0; i--) {
      // hoa doi vi tri voi phan tu phia truoc
      bientam = global.danhsach[i]
      global.danhsach[i] = global.danhsach[i - 1]
      global.danhsach[i - 1] = bientam
    }
    tailaidanhsach()
  }

  function xoahanghoa(thutu) {
    global.danhsach = global.danhsach.filter((hanghoa, thutuhanghoa) => {
      return thutu !== thutuhanghoa
    })
    tailaidanhsach()
  }

  function lienketdulieu(dulieu, thutu) {
    let giatri = $('#' + dulieu + '-' + thutu).val()
    giatri = vnumber.clear(giatri)
    if (!giatri || giatri < 0) giatri = 0
    global.danhsach[thutu][dulieu] = giatri
    $('#' + dulieu + '-' + thutu).val(vnumber.format(giatri))

    global.danhsach[thutu].thanhtien = vnumber.clear($('#dongia-' + thutu).val()) * vnumber.clear($('#soluong-' + thutu).val())
    $('#thanhtien' + '-' + thutu).text(vnumber.format(global.danhsach[thutu].thanhtien))

    let thanhtien = 0
    global.danhsach.forEach(hanghoa => {
      thanhtien += Number(vnumber.clear(hanghoa.thanhtien))
    });
    global.thanhtien = thanhtien
    $('#thanh-tien').text(vnumber.format(thanhtien))
  }

  async function xacnhanthemnhap(trangthai) {
    let tinnhan = ''
    let nguoncung = $('#them-nguon-cung').val()
    if (!global.danhsach.length) tinnhan = 'Xin hãy nhập ít nhất 1 loại hàng hóa'
    else if (!(nguoncung > 0)) tinnhan = 'Xin hãy chọn nguồn cung'
    if (tinnhan.length) {
      vhttp.notify(tinnhan)
      return 0
    }
    vhttp.post('/dashboard/api/', {
      action: 'themnhaphang',
      id: global.id,
      filter: global.filter,
      idnguoncung: nguoncung,
      trangthai: trangthai,
      danhsach: global.danhsach
    }).then((resp) => {
      $('#content').html(resp.danhsach)
      $('#modal-them-nhap').modal('hide')
    }, (e) => { })
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
      vitri: 'nhaphang',
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
      global.danhsach.push({
        id: resp.data.id,
        mahang: resp.data.mahang,
        tenhang: resp.data.tenhang,
        hinhanh: resp.data.hinhanh,
        dongia: resp.data.dongia,
        soluong: 1,
        thanhtien: resp.data.dongia,
      })
      tailaidanhsach()
      $('#modal-them-hang').modal('hide')
    }, (e) => {

    })
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

  function themnguon() {
    $('#nguon-ten').val('')
    $('#nguon-dien-thoai').val('')
    $('#nguon-dia-chi').val('')
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
      vitri: 'nhaphang',
      data: data
    }).then((resp) => {
      $('#them-nguon-cung').html(resp.nguoncung)
      $('#them-nguon-cung').val(resp.idnguoncung)
      $('#modal-them-nguon').modal('hide')
    }, (e) => {

    })
  }

  function timnhap() {
    $('#modal-tim-nhap').modal('show')
  }

  function timkiem(page) {
    global.filter.page = page
    global.filter.tukhoa = $('#tim-tu-khoa').val()
    global.filter.batdau = $('#tim-bat-dau').val()
    global.filter.ketthuc = $('#tim-ket-thuc').val()

    vhttp.post('/dashboard/api/', {
      action: 'tainhap',
      filter: global.filter
    }).then((resp) => {
      $('#content').html(resp.danhsach)
      $('#modal-tim-nhap').modal('hide')
    }, (e) => { })
  }
  
  function chonfile() {
    var file = $('#import-file').val()
    $('#loi-import').hide()
    if (file) $('#import-btn').show()
    else $('#import-btn').hide()
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
    form.append('action', 'importnhaphang');
    $.ajax({
      url: '/dashboard/api/',
      type: 'post',
      data: form,
      processData: false,
      contentType: false
    }).done((x) => {
      try {
        var json = JSON.parse(x)
        if (json.messenger && json.messenger.length) vhttp.notify(json.messenger)
        if (json.status) {
          $('#import-file').val(null)
          if (json.loi && json.loi.length) {
            $('#loi-import').text(json.loi)
            $('#loi-import').show()
            return 0
          }
          json.danhsach.forEach(hanghoa => {
            global.danhsach.push({
              id: hanghoa.id,
              mahang: hanghoa.mahang,
              tenhang: hanghoa.tenhang,
              hinhanh: hanghoa.hinhanh,
              dongia: hanghoa.dongia,
              soluong: hanghoa.soluong,
              thanhtien: hanghoa.thanhtien,
            })
          });
          tailaidanhsach()
        }
      }
      catch (error) {

      }
    }).fail(() => { });
  }
</script>
<!-- END: main -->