<!-- BEGIN: main -->
<style>
  /* .pw-col > .col-xs-1, .pw-col > .col-xs-3, .pw-col > .col-xs-4, .pw-col > .col-xs-8 {
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
  } */
  .input-group-addon {
    width: 40px !important;
    line-height: normal !important;
  }

  .input-group {
    width: 100%;
  }

  #printable {
    display: none;
  }

  #nonprintable {
    display: block;
  }

  @media print {
    #printable {
      display: block;
    }

    #nonprintable {
      display: none;
    }
  }
</style>

<div class="modal fade" id="modal-them-khach" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title"> Khách hàng </h4>
      </div>
      <div class="modal-body">
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

<div class="modal fade" id="modal-thanh-toan" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title"> Thu tiền khách trả </h4>
      </div>
      <div class="modal-body">
        <div class="row form-group">
          <div class="col-xs-12">
            Số tiền
          </div>
          <div class="col-xs-12">
            <input autocomplete="off" type="text" class="form-control pw-text-right" id="thanh-toan-tien">
          </div>
        </div>

        <div class="row form-group">
          <div class="col-xs-8">
            <button class="btn btn-block btn-default btn-block">
              Tiền mặt
            </button>
          </div>
          <div class="col-xs-8">
            <button class="btn btn-default btn-block">
              Điểm
            </button>
          </div>
          <div class="col-xs-8">
            <button class="btn btn-default btn-block">
              Chuyển khoản
            </button>
          </div>
        </div>

        <div class="row form-group">
          <div class="col-xs-12"> Khách cần trả </div>
          <div class="col-xs-12" id="thanh-toan-can-tra"> </div>
        </div>

        <div class="row form-group">
          <div class="col-xs-12"> Khách thanh toán </div>
          <div class="col-xs-12" id="thanh-toan-khach"> </div>
        </div>

        <div class="row form-group">
          <div class="col-xs-12"> Tiền thừa </div>
          <div class="col-xs-12" id="thanh-toan-tien-thua"> </div>
        </div>
      </div>
    </div>
  </div>
</div>

<div id="pw-dismiss" onclick="antoanbo()"></div>
<div id="pw-error-panel"> </div>
<div id="printable"></div>
<div id="nonprintable">
  <div class="pw-navbar">
    <div class="row">
      <div class="col-xs-8">
        <div class="input-group">
          <div class="input-group-addon"> <span class="fa fa-search"></span> </div>
          <div class="pw-suggest-group">
            <input autocomplete="off" type="text" class="form-control" id="tim-hang" placeholder="Tìm kiếm mặt hàng">
            <div class="pw-suggest-list" id="goi-y-tim-hang"> </div>
          </div>
        </div>
      </div>
      <div class="col-xs-12" id="danhsachhoadon"></div>
      <div class="col-xs-4 pw-head-menu">
        Menu
      </div>
    </div>
  </div>
  <div class="pw-content">
    <div class="pw-left-panel" id="danh-sach-hoa-don">
    </div>
    <div class="pw-right-panel">
      <div class="row form-group">
        <div class="col-xs-14 pw-subtext">
          <select class="form-control" id="nguoiban" onchange="thaydoinguoiban()">
            {danhsachnhanvien}
          </select>
        </div>
        <div class="col-xs-2"> </div>
        <div class="col-xs-8 pw-subtext">
          07/06/2022 16:52
        </div>
      </div>
      <div class="input-group form-group">
        <div class="pw-suggest-group">
          <input autocomplete="off" type="text" class="form-control" id="tim-khach" placeholder="Tìm kiếm khách hàng"
            onclick="suakhach()">
          <div class="pw-suggest-list" id="goi-y-tim-khach"> </div>
        </div>

        <div class="input-group-btn">
          <button class="btn btn-success" id="them-khach" onclick="themkhach()">
            +
          </button>
          <button class="btn btn-danger" style="display: none;" id="xoa-khach" onclick="xoakhach()">
            x
          </button>
        </div>
      </div>
      <select class="form-control form-group">
        <option value="1"> bảng giá chung </option>
      </select>
      <div class="pw-bill">
        <div class="pw-bill-header"> Hóa đơn </div>
      </div>
      <div class="row form-group">
        <div class="col-xs-12"> Tổng đơn Hàng </div>
        <div class="col-xs-12 pw-text-right" id="tongtien"> 0 </div>
      </div>
      <div class="row">
        <div class="col-xs-12 form-group"> Giảm giá </div>
        <div class="col-xs-12 pw-text-right">
          <div class="form-group input-group">
            <input autocomplete="off" class="form-control pw-text-right" id="suagiamgiaphantram" value="0"
            onkeyup="suagiamgiahoadon()">
            <div class="input-group-addon"> % </div>
          </div>
          <div class="form-group input-group">
            <input autocomplete="off" class="form-control pw-text-right" id="suagiamgiatien" value="0"
            onkeyup="suagiamgiahoadon()">
            <div class="input-group-addon"> VND </div>
          </div>
        </div>
      </div>

      <div class="row form-group">
        <div class="col-xs-12"> Thành tiền </div>
        <div class="col-xs-12 pw-text-right" id="cantra"> 0 </div>
      </div>

      <div class="row form-group">
        <div class="col-xs-24"> Khách thanh toán </div>
        <div class="col-xs-8">
          <input type="text" class="form-control" placeholder="Tiền mặt">
        </div>
        <div class="col-xs-8">
          <input type="text" class="form-control" placeholder="Chuyển khoản">
        </div>
        <div class="col-xs-8">
          <input type="text" class="form-control" placeholder="Điểm">
        </div>
      </div>

      <div class="row form-group">
        <div class="col-xs-12"> Tiền thừa </div>
        <div class="col-xs-12 pw-text-right" id="tienthua"> 0 </div>
      </div>

      <div class="form-group">
        <textarea class="form-control" rows="3" id="ghichu" maxlength="100" placeholder="Ghi chú"
          onchange="thaydoighichu()"></textarea>
      </div>

      <div class="pw-footer-panel">
        <button class="btn btn-success btn-block btn-lg" style="margin-bottom: 20px;" onclick="thanhtoan()">
          Thanh toán
        </button>
        Power by Petcoffee.work 2022 <br>
      </div>
    </div>
  </div>
</div>

<script>
  var global = {
    chonhoadon: 0,
    hoadon: [],
    hanghoa: [],
    khachhang: [],
    idnhanvien: '{idnhanvien}',
    giamgia: {
      'tien': {
        'tien': 'btn-info',
        'phantram': 'btn-default'
      },
      'phantram': {
        'tien': 'btn-default',
        'phantram': 'btn-info'
      }
    }
  }
  $(document).ready(() => {
    // gợi ý tìm hàng hóa
    vremind.install('#tim-hang', '#goi-y-tim-hang', (key) => {
      return new Promise(resolve => {
        vhttp.post('/pos/api/', {
          action: 'timhang',
          tukhoa: key
        }).then((phanhoi) => {
          html = ``
          global.hanghoa = phanhoi.danhsach
          global.hanghoa.forEach((hanghoa, i) => {
            html += `
            <div class="suggest-item suggest-item-lg" onclick="themhanghoa(`+ i + `)">
              <div class="pw-suggest-image"> <img src="`+ hanghoa.hinhanh + `"> </div>
              <div class="pw-suggest-info">
                <b>`+ hanghoa.ten + ` ` + (hanghoa.donvi.length ? '(' + hanghoa.donvi + ')' : '') + `</b> <br>
                `+ hanghoa.ma + ` <br>
                Giá: `+ vnumber.format(hanghoa.giaban) + `
                <span style="float: right;"> Tồn: `+ vnumber.format(hanghoa.soluong) + ` </span>
              </div>
            </div>`
          });
          if (!html.length) html = `Không có kết quả`
          resolve(html)
        }, () => {
          resolve('Không có kết quả')
        })
      })
    }, 300, 300)

    // gợi ý tìm khách hàng
    vremind.install('#tim-khach', '#goi-y-tim-khach', (key) => {
      return new Promise(resolve => {
        vhttp.post('/pos/api/', {
          action: 'timkhach',
          tukhoa: key
        }).then((phanhoi) => {
          html = ``
          global.khachhang = phanhoi.danhsach
          global.khachhang.forEach((khachhang, i) => {
            html += `
              <div class="suggest-item" onclick="chonkhachhang(`+ i + `)">
                `+ khachhang.ten + ` <span style="float: right;"> ` + khachhang.dienthoai + ` </span> <br>
                `+ khachhang.ma + `
              </div>`
          })
          if (!html.length) html = `Không có kết quả`
          resolve(html)
        }, () => {
          resolve('Không có kết quả')
        })
      })
    }, 300, 300)

    themhoadon()
  })

  function thanhtoan() {
    // nếu hóa đơn hiện tại không có hàng hóa, thông báo
    if (!global.hoadon[global.chonhoadon].hanghoa.length) return vhttp.notify('Chọn hàng hóa trước khi thanh toán')
    else {
      vhttp.post('/pos/api/', {
        action: 'thanhtoan',
        data: global.hoadon[global.chonhoadon]
      }).then((resp) => {
        // thanh toán xong xóa hóa đơn hiện tại
        global.hoadon[global.chonhoadon].hanghoa = []
        xoahoadon(global.chonhoadon)
        setTimeout(() => {
          $('#printable').html(resp.html)
          window.print()
        }, 500);
      }, (e) => { })
    }
  }

  function xacnhanthanhtoan() {

  }

  function suathanhtoan() {
    // kiểm tra thanh toán hoa đơn có loại nào hơn 0 hay không
    // nếu có chỉ 1, thay đổi
  }

  function thaydoinguoiban() {
    global.hoadon[global.chonhoadon].nguoiban = $('#nguoiban option:selected')[0].value
  }

  function thaydoighichu() {
    global.hoadon[global.chonhoadon].ghichu = $('#ghichu').val()
  }

  function chonkhachhang(i) {
    global.hoadon[global.chonhoadon].khachhang = global.khachhang[i]
    tailaikhach()
  }

  function tailaikhach() {
    var khachhang = global.hoadon[global.chonhoadon].khachhang
    if (khachhang.dienthoai.length) {
      $('#tim-khach').val(khachhang.ten + ' (' + khachhang.dienthoai + ')')
      $('#tim-khach').prop('readonly', true)
      $('#them-khach').hide()
      $('#xoa-khach').show()
    }
    else {
      $('#tim-khach').val('')
      $('#tim-khach').prop('readonly', false)
      $('#them-khach').show()
      $('#xoa-khach').hide()
    }
  }

  function themkhach() {
    global.id = 0
    $('#khach-ten').val('')
    $('#khach-dien-thoai').val($('#tim-khach').val())
    $('#khach-dia-chi').val('')
    $('.insert').show()
    $('.update').hide()
    $('#modal-them-khach').modal('show')
  }

  function suakhach() {
    khachhang = global.hoadon[global.chonhoadon].khachhang
    if (khachhang.id) {
      global.id = khachhang.id
      $('#khach-ten').val(khachhang.ten)
      $('#khach-dien-thoai').val(khachhang.dienthoai)
      $('#khach-dia-chi').val(khachhang.diachi)
      $('.insert').hide()
      $('.update').show()
      $('#modal-them-khach').modal('show')
    }
  }

  async function xacnhanthemkhach() {
    data = {
      ten: $('#khach-ten').val(),
      dienthoai: $('#khach-dien-thoai').val(),
      diachi: $('#khach-dia-chi').val(),
    }
    if (!data.ten.length) {
      vhttp.notify('Xin hãy nhập tên khách')
      return 0
    }
    else if (!data.dienthoai.length) {
      vhttp.notify('Xin hãy nhập số điện thoại')
      return 0
    }
    vhttp.post('/dashboard/api/', {
      action: 'themkhach',
      vitri: 'banhang',
      id: global.id,
      data: data
    }).then((resp) => {
      global.hoadon[global.chonhoadon].khachhang = resp.data
      $('#modal-them-khach').modal('hide')
    }, (e) => {
    })
  }

  function xoakhach() {
    global.hoadon[global.chonhoadon].khachhang = { id: 0, ma: '', ten: '', dienthoai: '' }
    tailaikhach()
  }

  function chonthanhtoan() {
    $('#thanh-toan-tien').val(0)
    $('#thanh-toan-can-tra').text()
    $('#thanh-toan-khach').text()
    $('#thanh-toan-tien-thua').text()
    $('#modal-thanh-toan').modal('show')
  }

  function themhoadon() {
    global.hoadon.push({
      nguoiban: global.idnhanvien,
      soluong: 0,
      tongtien: 0,
      thanhtien: 0,
      giamgiatien: 0,
      giamgiaphantram: 0,
      ghichu: '',
      thanhtoan: [0, 0, 0],
      khachhang: { id: 0, ma: '', ten: '', dienthoai: '' },
      hanghoa: []
    })
    global.chonhoadon = global.hoadon.length - 1
    tailaidanhsachhoadon()
  }

  function tailaidanhsachhoadon() {
    var html = ``
    global.hoadon.forEach((hd, vitrichay) => {
      html += `
      <button class="pw-bill-tab btn `+ (global.chonhoadon == vitrichay ? 'btn-warning' : 'btn-info') + `" onclick="chonhoadon(` + vitrichay + `)">
        <span class="pw-bill-close" onclick="xoahoadon(`+ vitrichay + `)"> x </span>
        `+ (vitrichay + 1) + `
      </button>`
    })
    html += `
    <button class="btn btn-info" onclick="themhoadon()">
      +
    </button>`
    $('#danhsachhoadon').html(html)
    tailaihoadon()
    tailaigia()
  }

  function xoahoadon(vitri) {
    setTimeout(() => {
      if (!global.hoadon[vitri].hanghoa.length || confirm('Xác nhận xóa hóa đơn')) {
        global.hoadon = global.hoadon.filter((hd, vitrichay) => {
          return vitri != vitrichay
        })
        if (global.hoadon.length) {
          global.chonhoadon = global.hoadon.length - 1
          tailaidanhsachhoadon()
        }
        else {
          themhoadon()
        }
      }
    }, 100);
  }

  function chonhoadon(vitri) {
    global.chonhoadon = vitri
    tailaidanhsachhoadon()
  }

  function themhanghoa(i) {
    // tim xem ma hang co trong hoa don chua
    var vitri = -1
    var hoadon = global.hoadon[global.chonhoadon].hanghoa
    hoadon.forEach((hd, vitrichay) => {
      if (hd.ma == global.hanghoa[i].ma) {
        vitri = vitrichay
      }
    });
    // neu chua, them vao
    if (vitri < 0) {
      global.hoadon[global.chonhoadon].hanghoa.push({
        id: global.hanghoa[i].id,
        ma: global.hanghoa[i].ma,
        ten: global.hanghoa[i].ten,
        dongia: global.hanghoa[i].giaban,
        giaban: global.hanghoa[i].giaban,
        donvi: global.hanghoa[i].donvi,
        soluong: 0,
        giamgiatien: 0,
        giamgiaphantram: 0,
      })
      vitri = global.hoadon[global.chonhoadon].hanghoa.length - 1
    }
    // so luong + 1, day len dau danh sach
    global.hoadon[global.chonhoadon].hanghoa[vitri].soluong++
    for (let i = vitri; i > 0; i--) {
      // hoa doi vi tri voi phan tu phia truoc
      bientam = global.hoadon[global.chonhoadon].hanghoa[i]
      hoadon[i] = global.hoadon[global.chonhoadon].hanghoa[i - 1]
      global.hoadon[global.chonhoadon].hanghoa[i - 1] = bientam
    }
    tailaihoadon()
    tailaigia()
  }

  function tailaihoadon() {
    let html = ``
    var hoadon = global.hoadon[global.chonhoadon].hanghoa
    var soluong = 0
    var tongtien = 0
    $('#nguoiban option[value=' + global.hoadon[global.chonhoadon].nguoiban + ']').prop('selected', true)
    $('#ghichu').val(global.hoadon[global.chonhoadon].ghichu)
    hoadon.forEach((hd, vitrichay) => {
      soluong += hd.soluong
      tongtien += hd.soluong * hd.giaban
      html += `
      <div class="pw-card pw-item">
        <div class="row pw-col">
          <div class="col-xs-1" id="#xoa-`+ vitrichay + `" onclick="xoahang(` + vitrichay + `)"> <span class="fa fa-remove"> </span> </div>
          <div class="col-xs-4" id="#ma-`+ vitrichay + `">` + hd.ma + `</div>
          <div class="col-xs-8" id="#tem-`+ vitrichay + `">` + hd.ten + `</div>
          <div class="col-xs-4"> 
            <div class="input-group">
              <div class="input-group-btn">
                <button class="btn btn-info" onclick="bangsuagia(`+ vitrichay + `)">
                  <span class="fa fa-credit-card">
                </button>
              </div>
              <input autocomplete="off" class="form-control pw-text-right" id="giaban-`+ vitrichay + `" value="` + vnumber.format(hd.giaban) + `" onkeyup="tailaigia(` + vitrichay + `)">  
            </div>
            <div class="pw-discount-panel" id="banggia-`+ vitrichay + `">
              <div class="row">
                <div class="col-xs-6">
                  <div class="form-group">Đơn giá</div>
                </div>
                <div class="col-xs-18">
                  <div class="form-group"> <input autocomplete="off" class="form-control" id="suadongia-`+ vitrichay + `" onkeyup="suadongia(` + vitrichay + `)"> </div>
                </div>
              </div>
              <div class="row">
                <div class="col-xs-6">
                  <div class="form-group">Giảm giá</div>
                </div>
                <div class="col-xs-18">
                  <div class="form-group input-group">
                    <input autocomplete="off" class="form-control" id="suagiamgiaphantram-`+ vitrichay + `" onkeyup="suagiamgia(` + vitrichay + `)"> 
                    <div class="input-group-addon"> % </div>
                    </div>
                  <div class="form-group input-group">
                    <input autocomplete="off" class="form-control" id="suagiamgiatien-`+ vitrichay + `" onkeyup="suagiamgia(` + vitrichay + `)"> 
                    <div class="input-group-addon">
                      VND
                    </div>
                  </div>
                </div>
              </div>
              
              <div class="row">
                <div class="col-xs-6">
                  <div class="form-group">Giá bán</div>
                </div>
                <div class="col-xs-18">
                  <div class="form-group"> <input autocomplete="off" class="form-control" id="suagiaban-`+ vitrichay + `" onkeyup="suagiaban(` + vitrichay + `)"> </div>
                </div>
              </div>
            </div>
          </div>
          <div class="col-xs-3"> 
            <input autocomplete="off" class="form-control pw-text-right" id="soluong-`+ vitrichay + `" value="` + vnumber.format(hd.soluong) + `" onkeyup="tailaigia(` + vitrichay + `)" onchange="tailaigia(` + vitrichay + `)">  
          </div>
          <div class="col-xs-4 pw-text-right" id="thanhtien-`+ vitrichay + `"> ` + vnumber.format(hd.soluong * hd.giaban) + ` </div>
        </div>
      </div>`
    })
    global.hoadon[global.chonhoadon].soluong = soluong
    global.hoadon[global.chonhoadon].tongtien = tongtien
    global.hoadon[global.chonhoadon].thanhtien = tongtien - global.hoadon[global.chonhoadon].giamgia
    $(function () {
      $('[data-toggle="popover"]').popover()
    })
    $('#danh-sach-hoa-don').html(html)
  }

  function xoahang(vitri) {
    var hoadon = global.hoadon[global.chonhoadon].hanghoa
    global.hoadon[global.chonhoadon].hanghoa = hoadon.filter((hd, vitrichay) => {
      return vitri !== vitrichay
    })
    tailaihoadon()
    tailaigia()
  }

  function suadongia(vitri) {
    // thay đổi đơn giá
    // kiểm tra giảm giá khác 0 thì cập nhật giảm giá
    // cập nhật giá bán
    var dongia = vnumber.clear($('#suadongia-' + vitri).val())
    var giamgia = vnumber.clear($('#suagiamgia-' + vitri).val())
    if (global.hoadon[global.chonhoadon].hanghoa[vitri].loaigiamgia == 'tien') {
      var giaban = dongia - giamgia
    }
    else {
      var giaban = Math.floor(dongia * (100 - giamgia) / 100)
    }
    global.hoadon[global.chonhoadon].hanghoa[vitri].dongia = dongia
    global.hoadon[global.chonhoadon].hanghoa[vitri].giaban = giaban
    $('#suagiaban-' + vitri).val(vnumber.format(giaban))
    $('#suadongia-' + vitri).val(vnumber.format(dongia))
    $('#giaban-' + vitri).val(vnumber.format(giaban))
    tailaigia(vitri)
  }

  function suagiamgia(vitri) {
    // kiểm tra giới hạn giảm gia
    // cập nhật giá bán, giảm giá
    var dongia = vnumber.clear($('#suadongia-' + vitri).val())
    var giamgiatien = vnumber.clear($('#suagiamgiatien-' + vitri).val())
    var giamgiaphantram = vnumber.clear($('#suagiamgiaphantram-' + vitri).val())

    

    global.hoadon[global.chonhoadon].hanghoa[vitri].giaban = giaban
    global.hoadon[global.chonhoadon].hanghoa[vitri].giamgia = giamgia
    $('#suagiaban-' + vitri).val(vnumber.format(giaban))
    $('#suagiamgia-' + vitri).val(vnumber.format(giamgia))
    $('#giaban-' + vitri).val(vnumber.format(giaban))
    tailaigia(vitri)
  }

  function suagiaban(vitri) {
    // kiểm tra giới hạn
    // tính giảm giá
    // cập nhật đơn giá, giảm giá
    var giaban = vnumber.clear($('#suagiaban-' + vitri).val())
    var dongia = vnumber.clear($('#suadongia-' + vitri).val())
    if (giaban > dongia) dongia = giaban

    if (global.hoadon[global.chonhoadon].hanghoa[vitri].loaigiamgia == 'tien') {
      var giamgia = dongia - giaban
    } else {
      var giamgia = Math.floor((dongia - giaban) * 100 / dongia)
    }
    global.hoadon[global.chonhoadon].hanghoa[vitri].giaban = giaban
    global.hoadon[global.chonhoadon].hanghoa[vitri].giamgia = giamgia
    $('#suadongia-' + vitri).val(vnumber.format(dongia))
    $('#suagiaban-' + vitri).val(vnumber.format(giaban))
    $('#suagiamgia-' + vitri).val(vnumber.format(giamgia))
    $('#giaban-' + vitri).val(vnumber.format(giaban))
    tailaigia(vitri)
  }

  function tailaigia(vitri = -1) {
    if (vitri >= 0) {
      var soluong = vnumber.clear($('#soluong-' + vitri).val())
      var giaban = vnumber.clear($('#giaban-' + vitri).val())
      var thanhtien = soluong * giaban
      global.hoadon[global.chonhoadon].hanghoa[vitri].soluong = soluong
      global.hoadon[global.chonhoadon].hanghoa[vitri].giaban = giaban
      $('#thanhtien-' + vitri).text(vnumber.format(thanhtien))
      $('#giaban-' + vitri).val(vnumber.format(giaban))
      $('#soluong-' + vitri).val(vnumber.format(soluong))
    }
    var tongtien = 0
    var thanhtoan = 0
    var tienthua = 0
    var giamgiatien = global.hoadon[global.chonhoadon].giamgiatien
    var giamgiaphantram = global.hoadon[global.chonhoadon].giamgiaphantram

    global.hoadon[global.chonhoadon].hanghoa.forEach(hd => {
      tongtien += hd.soluong * hd.giaban
    })

    thanhtien = tongtien * (100 - giamgiaphantram) / 100
    thanhtien -= giamgiatien

    thanhtoan = tongtien
    tienthua = tienthua
    global.hoadon[global.chonhoadon].tongtien = tongtien
    global.hoadon[global.chonhoadon].thanhtien = thanhtien
    // nếu thanh toán nhiều hơn 1 loại thì khóa input thanh toán
    var loaithanhtoan = global.hoadon[global.chonhoadon].thanhtoan

    $('#tongtien').text(vnumber.format(tongtien))
    $('#cantra').text(vnumber.format(thanhtien))
    $('#tienthua').text(vnumber.format(tienthua))
  }

  function chonloaigiam(vitri, giamgiamoi) {
    var giamgiacu = global.hoadon[global.chonhoadon].hanghoa[vitri].loaigiamgia
    if (giamgiacu !== giamgiamoi) {
      var dongia = vnumber.clear($('#suadongia-' + vitri).val())
      var giamgia = vnumber.clear($('#suagiamgia-' + vitri).val())
      if (dongia == 0) {
        giamgia = 0
        giaban = 0
      }
      else if (giamgiacu == 'tien') {
        var giamgia = Math.floor(giamgia * 100 / dongia)
        var giaban = dongia * (100 - giamgia) / 100
      }
      else {
        var giamgia = Math.floor(giamgia * dongia / 100)
        var giaban = dongia - giamgia
      }

      global.hoadon[global.chonhoadon].hanghoa[vitri].loaigiamgia = giamgiamoi
      global.hoadon[global.chonhoadon].hanghoa[vitri].giamgia = giamgia
      global.hoadon[global.chonhoadon].hanghoa[vitri].giaban = giaban
      var giam = global.giamgia[global.hoadon[global.chonhoadon].hanghoa[vitri].loaigiamgia]
      $('#suagiamgia-' + vitri).val(vnumber.format(giamgia))
      $('#suagiaban-' + vitri).val(vnumber.format(giaban))
      $('#giaban-' + vitri).val(vnumber.format(giaban))
      $('#giamtien-' + vitri).attr('class', 'btn ' + giam.tien)
      $('#giamphantram-' + vitri).attr('class', 'btn ' + giam.phantram)
    }
  }

  function chonloaigiamhoadon(giamgiamoi) {
    var giamgiacu = global.hoadon[global.chonhoadon].loaigiamgia
    var giamgia = global.hoadon[global.chonhoadon].giamgia
    if (giamgiacu !== giamgiamoi) {
      var tongtien = vnumber.clear($('#tongtien').text())
      if (tongtien == 0) {
        giamgia = 0
        giaban = 0
      }
      else if (giamgiacu == 'tien') {
        var giamgia = Math.floor(giamgia * 100 / tongtien)
        var giaban = tongtien * (100 - giamgia) / 100
      }
      else {
        var giamgia = Math.floor(giamgia * tongtien / 100)
        var giaban = tongtien - giamgia
      }

      global.hoadon[global.chonhoadon].loaigiamgia = giamgiamoi
      global.hoadon[global.chonhoadon].giamgia = giamgia
      $('#cantra').text(vnumber.format(giaban))
      $('#suagiamgia').val(vnumber.format(giamgia))
      $('#giamtien').attr('class', 'btn ' + global.giamgia[global.hoadon[global.chonhoadon].loaigiamgia].tien)
      $('#giamphantram').attr('class', 'btn ' + global.giamgia[global.hoadon[global.chonhoadon].loaigiamgia].phantram)
    }
  }

  function suagiamgiahoadon(type) {
    var tongtien = vnumber.clear($('#tongtien').text())
    var giamgiatien = vnumber.clear($('#suagiamgiatien').val())
    var giamgiaphantram = vnumber.clear($('#suagiamgiaphantram').val())

    if (giamgiaphantram < 0) giamgiaphantram = 0
    else if (giamgiaphantram > 100) giamgiaphantram = 100

    if (giamgiaphantram) tongtien = tongtien * (100 - giamgiaphantram) / 100

    if (giamgiatien < 0) giamgiatien = 0
    else if (giamgiatien > tongtien) giamgiatien = tongtien

    tongtien -= giamgiatien

    global.hoadon[global.chonhoadon].giamgiatien = giamgiatien
    global.hoadon[global.chonhoadon].giamgiaphantram = giamgiaphantram
    $('#suagiamgia').val(vnumber.format(giamgiatien))
    $('#suagiamgia').val(vnumber.format(giamgiaphantram))
    $('#cantra').text(vnumber.format(tongtien))
  }

  function bangsuagia(vitri) {
    if ($('#banggia-' + vitri).css('display') == 'block') {
      $('#banggia-' + vitri).hide()
      $('#pw-dismiss').hide()
    }
    else {
      let hanghoa = global.hoadon[global.chonhoadon].hanghoa[vitri]
      $('#suadongia-' + vitri).val(vnumber.format(hanghoa.dongia))
      $('#suagiamgiatien-' + vitri).val(vnumber.format(hanghoa.giamgiatien))
      $('#suagiamgiaphantram-' + vitri).val(vnumber.format(hanghoa.giamgiaphantram))
      $('#suagiaban-' + vitri).val(vnumber.format(hanghoa.giaban))
      $('#banggia-' + vitri).show()
      $('#pw-dismiss').show()
    }
  }

  function antoanbo() {
    $('.pw-discount-panel').hide()
    $('#pw-dismiss').hide()
  }

  function alert(text) {
    let randomid = generate_random_string()
    var html = `
    <div id="`+ randomid + `" class="alert alert-info alert-dismissible fade in" role="alert">
      <button type="button" class="close" data-dismiss="alert" aria-label="Close">
        <span aria-hidden="true">×</span>
      </button>
      <strong> `+ text + ` </strong>
    </div>`
    $('#pw-error-panel').append(html)
    $('#' + randomid).delay(2000).fadeOut(1000)
    setTimeout(() => {
      $('#' + randomid).remove()
    }, 3000);
  }

  function alias(str) {
    str = str.toLowerCase();
    str = str.replace(/à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ/g, "a");
    str = str.replace(/è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ/g, "e");
    str = str.replace(/ì|í|ị|ỉ|ĩ/g, "i");
    str = str.replace(/ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ/g, "o");
    str = str.replace(/ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ/g, "u");
    str = str.replace(/ỳ|ý|ỵ|ỷ|ỹ/g, "y");
    str = str.replace(/đ/g, "d");
    str = str.trim();
    return str;
  }

  function generate_random_string(length = 20) {
    chars = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    charrange = chars.length - 1;
    randomstring = '';
    for (i = 0; i < length; i++) {
      randomstring += chars[Math.floor(Math.random() * charrange)];
    }
    return randomstring;
  }
</script>
<!-- END: main -->