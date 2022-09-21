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

  .pw-input-group {
    position: relative;
    height: 55px;
    padding: 2px;
  }

  .pw-input-group.col-xs-8 {
    width: calc(33% - 4px);
    margin: 2px;
  }

  .pw-input-header {
    background: lightgreen;
    border-top-left-radius: 10px;
    border-top-right-radius: 10px;
    text-align: center;
    padding: 3px;
    width: 100%;
    position: absolute;
    top: 0px;
  }

  .pw-input-header:hover {
    cursor: pointer;
  }

  .pw-input-content {
    position: absolute;
    top: 25px;
  }

  #printable {
    display: none;
  }

  @media print {
    #printable {
      display: block;
    }

    .nonprintable {
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

<div class="modal fade" id="modal-thuno" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title"> Thu nợ khách </h4>
      </div>
      <div class="modal-body">
        <div class="form-group">
          <div class="pw-suggest-group">
            <input autocomplete="off" type="text" class="form-control" id="thuno-timkhach"
              placeholder="Tìm kiếm khách hàng">
            <div class="pw-suggest-list" id="thuno-goiytimkhach"> </div>
          </div>
        </div>

        <div class="row" id="thuno-thongtinkhachhang">
          <div class="col-xs-24"> Khách hàng <span id="thuno-khachhang"></span> </div>
          <div class="col-xs-12"> Nợ: <span id="thuno-tienno"></span> </div>
          <div class="col-xs-12"> Điểm: <span id="thuno-diem"></span> </div>
        </div>

        <div id="thuno-noidung"> </div>

        <div class="row form-group" id="thuno-thanhtoan">
          <div class="col-xs-24"> Khách thanh toán </div>
          <div class="col-xs-8 pw-input-group">
            <div class="pw-input-header" onclick="chonthanhtoanthuno(0)"> Tiền mặt </div>
            <input type="text" class="pw-input-content form-control" id="thuno-thanhtoantien" placeholder="Tiền mặt"
              onkeyup="suathanhtoanthuno(0)">
          </div>
          <div class="col-xs-8 pw-input-group">
            <div class="pw-input-header" onclick="chonthanhtoanthuno(1)"> Chuyển khoản </div>
            <input type="text" class="pw-input-content form-control" id="thuno-thanhtoanchuyenkhoan"
              placeholder="Chuyển khoản" onkeyup="suathanhtoanthuno(1)">
          </div>
          <div class="col-xs-8 pw-input-group">
            <div class="pw-input-header" onclick="chonthanhtoanthuno(2)">Điểm</div>
            <input type="text" class="pw-input-content form-control" id="thuno-thanhtoandiem" placeholder="Điểm"
              onkeyup="suathanhtoanthuno(2)">
          </div>
        </div>

        <div class="row form-group" id="thuno-blocktienthua">
          <div class="col-xs-12">  </div>
          <div class="col-xs-6"> Còn nợ </div>
          <div class="col-xs-6 pw-text-right" id="thuno-tienthua"> 0 </div>
        </div>

        <button class="insert btn btn-success btn-block" onclick="xacnhanthuno()">
          Thu nợ
        </button>
      </div>
    </div>
  </div>
</div>

<div id="pw-dismiss" onclick="antoanbo()"></div>
<div id="pw-error-panel"> </div>
<div id="printable"></div>
<div class="nonprintable">
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
        <button class="fa fa-money btn btn-info" onclick="thuno()"></button>
        <button class="fa fa-share btn btn-info"></button>
        <button class="fa fa-bars btn btn-info"></button>
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
          {thoigian}
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
      <div class="form-group">
        <div class="row">
          <div class="col-xs-12"> Nợ: <span id="khach-no">0</span> </div>
          <div class="col-xs-12"> Điểm: <span id="khach-diem">0</span> </div>
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
        <div class="col-xs-8 pw-input-group">
          <div class="pw-input-header" onclick="chonthanhtoan(0)"> Tiền mặt </div>
          <input type="text" class="pw-input-content form-control" id="thanhtoantien" placeholder="Tiền mặt"
            onkeyup="suathanhtoan(0)">
        </div>
        <div class="col-xs-8 pw-input-group">
          <div class="pw-input-header" onclick="chonthanhtoan(1)"> Chuyển khoản </div>
          <input type="text" class="pw-input-content form-control" id="thanhtoanchuyenkhoan" placeholder="Chuyển khoản"
            onkeyup="suathanhtoan(1)">
        </div>
        <div class="col-xs-8 pw-input-group">
          <div class="pw-input-header" onclick="chonthanhtoan(2)">Điểm</div>
          <input type="text" class="pw-input-content form-control" id="thanhtoandiem" placeholder="Điểm"
            onkeyup="suathanhtoan(2)">
        </div>
      </div>

      <div class="row form-group" id="blocktienthua" style="display: none;">
        <div class="col-xs-12"> Tiền thừa </div>
        <div class="col-xs-12 pw-text-right" id="tienthua"> 0 </div>
      </div>

      <div class="row form-group" id="blocktienno" style="display: none;">
        <div class="col-xs-12"> ra nợ cho khách </div>
        <div class="col-xs-12 pw-text-right" id="tienno"> 0 </div>
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
    khachhangthuno: [],
    idkhachhangthuno: 0,
    thuno: {},
    idnhanvien: '{idnhanvien}',
    thanhtoan: ['thanhtoantien', 'thanhtoanchuyenkhoan', 'thanhtoandiem'],
    thanhtoanthuno: ['thuno-thanhtoantien', 'thuno-thanhtoanchuyenkhoan', 'thuno-thanhtoandiem'],
    thututhanhtoan: [[1, 2], [0, 2], [0, 1]]
  }
  $(document).ready(() => {
    // gợi ý tìm hàng hóa
    vremind.install('#tim-hang', '#goi-y-tim-hang', (key) => {
      return new Promise(resolve => {
        vhttp.post('/pos/api/', {
          action: 'timhang',
          tukhoa: key
        }).then((resp) => {
          html = ``
          global.hanghoa = resp.danhsach
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
        }).then((resp) => {
          html = ``
          global.khachhang = resp.danhsach
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

    vremind.install('#thuno-timkhach', '#thuno-goiytimkhach', (key) => {
      return new Promise(resolve => {
        vhttp.post('/pos/api/', {
          action: 'timkhachthuno',
          tukhoa: key
        }).then((resp) => {
          html = ``
          global.khachhangthuno = resp.danhsach
          global.khachhangthuno.forEach((khachhang, i) => {
            html += `
              <div class="suggest-item" onclick="chonkhachhangthuno(`+ i + `)">
                `+ khachhang.ten + ` <span style="float: right;"> ` + khachhang.dienthoai + ` </span> <br>
                `+ khachhang.ma + `<span style="float: right; color: red; font-weight: bold;"> ` + vnumber.format(khachhang.tienno) + ` </span> 
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
    // nếu hóa đơn không có sđt mà nợ thì báo
    var thanhtoan = global.hoadon[global.chonhoadon].thanhtoan
    var tongthanhtoan = thanhtoan[0] + thanhtoan[1] + thanhtoan[2]
    var thanhtien = global.hoadon[global.chonhoadon].thanhtien
    var khachhang = global.hoadon[global.chonhoadon].khachhang.id
    if (!global.hoadon[global.chonhoadon].hanghoa.length) return vhttp.notify('Chọn hàng hóa trước khi thanh toán')
    else if (khachhang == 0 && (thanhtien > tongthanhtoan)) return vhttp.notify('Chưa chọn khách hàng nên không thể ra nợ')
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

  function chonthanhtoan(loai) {
    // kiểm tra nếu 
    global.hoadon[global.chonhoadon].thanhtoan[0] = 0
    global.hoadon[global.chonhoadon].thanhtoan[1] = 0
    global.hoadon[global.chonhoadon].thanhtoan[2] = 0

    if (loai == 2) {
      if (!global.hoadon[global.chonhoadon].khachhang.id) return 0
      var diem = global.hoadon[global.chonhoadon].khachhang.diem * 100
      global.hoadon[global.chonhoadon].thanhtoan[0] = global.hoadon[global.chonhoadon].thanhtien - diem
      global.hoadon[global.chonhoadon].thanhtoan[2] = diem
    }
    else {
      global.hoadon[global.chonhoadon].thanhtoan[loai] = global.hoadon[global.chonhoadon].thanhtien
    }
    global.hoadon[global.chonhoadon].suathanhtoan = 0
    $('#thanhtoantien').val(vnumber.format(global.hoadon[global.chonhoadon].thanhtoan[0]))
    $('#thanhtoanchuyenkhoan').val(vnumber.format(global.hoadon[global.chonhoadon].thanhtoan[1]))
    $('#thanhtoandiem').val(vnumber.format(global.hoadon[global.chonhoadon].thanhtoan[2]))
    tailaitienthua()
  }

  function suathanhtoan(loai) {
    var thanhtoan = vnumber.clear($('#' + global.thanhtoan[loai]).val())
    if (loai == 2) {
      var khachhang = global.hoadon[global.chonhoadon].khachhang
      var diem = khachhang.diem * 100
      if (!khachhang.id) thanhtoan = 0
      if (thanhtoan > diem) thanhtoan = diem
    }
    if (thanhtoan < 0) thanhtoan = 0
    global.hoadon[global.chonhoadon].thanhtoan[loai] = thanhtoan
    global.hoadon[global.chonhoadon].suathanhtoan = 0
    $('#' + global.thanhtoan[loai]).val(vnumber.format(thanhtoan))

    // ck + điểm không được > thành tiền
    var chuyenkhoan = global.hoadon[global.chonhoadon].thanhtoan[1]
    var diem = global.hoadon[global.chonhoadon].thanhtoan[2]
    var thanhtien = global.hoadon[global.chonhoadon].thanhtien

    if (thanhtien < diem + chuyenkhoan) {
      chuyenkhoan = thanhtien - diem
      global.hoadon[global.chonhoadon].thanhtoan[1] = chuyenkhoan
      $('#thanhtoanchuyenkhoan').val(vnumber.format(chuyenkhoan))
    }

    tailaitienthua()
  }

  function thuno() {
    $('#thuno-noidung').hide()
    $('#thuno-thongtinkhachhang').hide()
    $('#thuno-tienthua').text(0)
    $('#thuno-blocktienthua').hide()
    $('#thuno-thanhtoantien').val(0)
    $('#thuno-thanhtoanchuyenkhoan').val(0)
    $('#thuno-thanhtoandiem').val(0)
    $('#thuno-thanhtoan').hide()
    $('#thuno-khachhang').text('')
    $('#thuno-tienno').text('')
    $('#thuno-diem').text('')
    $('#modal-thuno').modal('show')
  }

  function chonkhachhangthuno(i) {
    var khachhang = global.khachhangthuno[i]
    vhttp.post('/pos/api/', {
      action: 'thongtinthuno',
      id: khachhang.id
    }).then((resp) => {
      // load thông tin điểm, nợ
      // load thông tin hóa đơn nợ
      $('#thuno-noidung').show()
      global.thuno = resp.dulieu
      $('#thuno-noidung').html(resp.noidung)
      $('#thuno-khachhang').text(khachhang.ten + ' ('+ khachhang.dienthoai +')')
      $('#thuno-tienno').text(vnumber.format(khachhang.tienno))
      $('#thuno-diem').text(vnumber.format(khachhang.diem))
      $('#thuno-thongtinkhachhang').show()
      $('#thuno-thanhtoan').show()
      $('#thuno-diem').text(vnumber.format(khachhang.diem))
      $('#thuno-tienthua').text(vnumber.format(khachhang.tienno))
      $('#thuno-blocktienthua').show()
    }, () => { })
  }

  function suatoathanhtoanthuno(i) {
    var tien = vnumber.clear($('#thuno-tien'+ i).val())
    var tongthanhtoan = 0
    if (tien < 0) tien = 0
    else if (tien > global.thuno.hoadon[i].conno) tien = global.thuno.hoadon[i].conno
    $('#thuno-tien'+ i).val(vnumber.format(tien))
    
    global.thuno.hoadon[i].thuthem = tien
    global.thuno.hoadon.forEach(thuno => {
      tongthanhtoan += thuno.thuthem
    });
    global.thuno.thanhtoan[0] = tongthanhtoan
    global.thuno.thanhtoan[1] = 0
    global.thuno.thanhtoan[2] = 0
    $('#thuno-thanhtoantien').val(vnumber.format(global.thuno.thanhtoan[0]))
    $('#thuno-thanhtoanchuyenkhoan').val(global.thuno.thanhtoan[1])
    $('#thuno-thanhtoandiem').val(global.thuno.thanhtoan[2])
    tinhtienconno()
  }

  function chonthanhtoanthuno(loai) {
    global.thuno.thanhtoan[0] = 0
    global.thuno.thanhtoan[1] = 0
    global.thuno.thanhtoan[2] = 0

    if (loai == 2) {
      var diem = global.thuno.khachhang.diem * 100
      console.log(diem);
      global.thuno.thanhtoan[0] = global.thuno.khachhang.tienno - diem
      global.thuno.thanhtoan[2] = diem
    }
    else {
      global.thuno.thanhtoan[loai] = global.thuno.khachhang.tienno
    }
    global.thuno.suathanhtoan = 1

    global.thuno.hoadon.forEach((hoadon, i) => {
      $('#thuno-tien'+i).val(vnumber.format(hoadon.conno))
      global.thuno.hoadon[i].thuthem = hoadon.conno
    });

    $('#thuno-thanhtoantien').val(vnumber.format(global.thuno.thanhtoan[0]))
    $('#thuno-thanhtoanchuyenkhoan').val(vnumber.format(global.thuno.thanhtoan[1]))
    $('#thuno-thanhtoandiem').val(vnumber.format(global.thuno.thanhtoan[2]))
    tinhtienconno()
  }

  function suathanhtoanthuno(loai) {
    var thanhtoan = vnumber.clear($('#' + global.thanhtoanthuno[loai]).val())
    if (loai == 2) {
      var diem = global.thuno.khachhang.diem * 100
      if (thanhtoan > diem) thanhtoan = diem
    }
    if (thanhtoan < 0) thanhtoan = 0
    global.thuno.thanhtoan[loai] = thanhtoan
    global.thuno.suathanhtoan = 0

    // kiểm tra loại thanh toán nhập vào 
    var tienmat = global.thuno.thanhtoan[0]
    var chuyenkhoan = global.thuno.thanhtoan[1]
    var diem = global.thuno.thanhtoan[2]
    var tongthanhtoan = tienmat + chuyenkhoan + diem
    var tienno = global.thuno.khachhang.tienno

    if (tongthanhtoan > tienno) {
      // tổng thanh toán lớn hơn số nợ, giữ nguyên thanh toán, giảm 2 cái còn lại
      var sodu = tongthanhtoan - tienno
      var thututhanhtoan = global.thututhanhtoan[loai]
      var loai1 = thututhanhtoan[0]
      var loai2 = thututhanhtoan[1]
      if (sodu < global.thuno.thanhtoan[loai1]) {
        global.thuno.thanhtoan[loai1] -= sodu
      }
      else {
        global.thuno.thanhtoan[loai1] = 0
        sodu -= global.thuno.thanhtoan[loai1]
        if (sodu < global.thuno.thanhtoan[loai1] + global.thuno.thanhtoan[loai2]) {
          global.thuno.thanhtoan[loai2] -= sodu
        }
        else {
          global.thuno.thanhtoan[loai2] = 0
          sodu -= global.thuno.thanhtoan[loai1]
          if (sodu < global.thuno.thanhtoan[loai]) {
            global.thuno.thanhtoan[loai] = tienno
          }
        }
      }
    }
    $('#thuno-thanhtoantien').val(vnumber.format(global.thuno.thanhtoan[0]))
    $('#thuno-thanhtoanchuyenkhoan').val(vnumber.format(global.thuno.thanhtoan[1]))
    $('#thuno-thanhtoandiem').val(vnumber.format(global.thuno.thanhtoan[2]))
    // tính lượng thanh toán

    var tienmat = global.thuno.thanhtoan[0]
    var chuyenkhoan = global.thuno.thanhtoan[1]
    var diem = global.thuno.thanhtoan[2]
    var tongthanhtoan = tienmat + chuyenkhoan + diem

    global.thuno.hoadon.forEach((hoadon, i) => {
      if (tongthanhtoan > hoadon.conno) {
        global.thuno.hoadon[i].thuthem = hoadon.conno
        tongthanhtoan -= hoadon.conno
      }
      else if (tongthanhtoan > 0) {
        global.thuno.hoadon[i].thuthem = tongthanhtoan
        tongthanhtoan = 0
      }
      else {
        global.thuno.hoadon[i].thuthem = 0
      }
      $('#thuno-tien'+ i).val(vnumber.format(global.thuno.hoadon[i].thuthem))
    })
    tinhtienconno()
  }

  function tinhtienconno() {
    var tongthanhtoan = global.thuno.thanhtoan[0] + global.thuno.thanhtoan[1] + global.thuno.thanhtoan[2]
    $('#thuno-tienthua').text(vnumber.format(global.thuno.khachhang.tienno - tongthanhtoan))
  }

  function xacnhanthuno() {
    vhttp.post('/pos/api/', {
      action: 'thuno',
      data: global.thuno
    }).then((resp) => {
      $('#modal-thuno').modal('hide')
    }, (e) => {
    })
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
      $('#thanhtoandiem').prop('disabled', false)
      $('#tim-khach').val(khachhang.ten + ' (' + khachhang.dienthoai + ')')
      $('#tim-khach').prop('readonly', true)
      $('#khach-no').text(vnumber.format(khachhang.tienno))
      $('#khach-diem').text(khachhang.diem)
      $('#them-khach').hide()
      $('#xoa-khach').show()
    }
    else {
      global.hoadon[global.chonhoadon].thanhtoan[2] = 0
      $('#thanhtoandiem').prop('disabled', true)
      $('#tim-khach').val('')
      $('#tim-khach').prop('readonly', false)
      $('#khach-no').text(0)
      $('#khach-diem').text(0)
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
      tailaikhach()
      $('#modal-them-khach').modal('hide')
    }, (e) => {
    })
  }

  function xoakhach() {
    global.hoadon[global.chonhoadon].khachhang = { id: 0, ma: '', ten: '', dienthoai: '' }
    tailaikhach()
  }

  function themhoadon() {
    global.hoadon.push({
      nguoiban: global.idnhanvien,
      soluong: 0,
      tongtien: 0,
      tonghang: 0,
      thanhtien: 0,
      giamgiatien: 0,
      giamgiaphantram: 0,
      ghichu: '',
      thanhtoan: [0, 0, 0],
      suathanhtoan: 1,
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
    tailaikhach()
    $('#thanhtoantien').val(vnumber.format(global.hoadon[global.chonhoadon].thanhtoan[0]))
    $('#thanhtoanchuyenkhoan').val(vnumber.format(global.hoadon[global.chonhoadon].thanhtoan[1]))
    $('#thanhtoandiem').val(vnumber.format(global.hoadon[global.chonhoadon].thanhtoan[2]))
    tailaitienthua()

    $('#nguoiban option[value=' + global.hoadon[global.chonhoadon].nguoiban + ']').prop('selected', true)
    $('#ghichu').val(global.hoadon[global.chonhoadon].ghichu)
    hoadon.forEach((hd, vitrichay) => {
      html += `
      <div class="pw-card pw-item">
        <div class="row pw-col">
          <div class="col-xs-1" id="#xoa-`+ vitrichay + `" onclick="xoahang(` + vitrichay + `)"> <span class="fa fa-remove"> </span> </div>
          <div class="col-xs-4" id="#ma-`+ vitrichay + `">` + hd.ma + `</div>
          <div class="col-xs-8" id="#tem-`+ vitrichay + `">` + hd.ten + `</div>
          <div class="col-xs-5"> 
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
          <div class="col-xs-2"> 
            <input autocomplete="off" class="form-control pw-text-right" id="soluong-`+ vitrichay + `" value="` + vnumber.format(hd.soluong) + `" onkeyup="tailaigia(` + vitrichay + `)" onchange="tailaigia(` + vitrichay + `)">  
          </div>
          <div class="col-xs-4 pw-text-right" id="thanhtien-`+ vitrichay + `"> ` + vnumber.format(hd.soluong * hd.giaban) + ` </div>
        </div>
      </div>`
    })
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
    var giamgiatien = vnumber.clear($('#suagiamgiatien-' + vitri).val())
    var giamgiaphantram = vnumber.clear($('#suagiamgiaphantram-' + vitri).val())

    var giaban = dongia * (100 - giamgiaphantram) / 100
    giaban -= giamgiatien

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

    if (giamgiaphantram < 0) giamgiaphantram = 0
    else if (giamgiaphantram > 100) giamgiaphantram = 100

    var giaban = (dongia * (100 - giamgiaphantram) / 100).toFixed()

    if (giamgiatien < 0) giamgiatien = 0
    else if (giamgiatien > giaban) giamgiatien = giaban
    giaban -= giamgiatien

    global.hoadon[global.chonhoadon].hanghoa[vitri].giaban = giaban
    global.hoadon[global.chonhoadon].hanghoa[vitri].giamgiatien = giamgiatien
    global.hoadon[global.chonhoadon].hanghoa[vitri].giamgiaphantram = giamgiaphantram
    $('#suagiaban-' + vitri).val(vnumber.format(giaban))
    $('#suagiamgiatien-' + vitri).val(vnumber.format(giamgiatien))
    $('#suagiamgiaphantram-' + vitri).val(vnumber.format(giamgiaphantram))
    $('#giaban-' + vitri).val(vnumber.format(giaban))
    tailaigia(vitri)
  }

  function suagiaban(vitri) {
    // kiểm tra giới hạn
    // tính giảm giá
    // cập nhật đơn giá, giảm giá
    var giaban = vnumber.clear($('#suagiaban-' + vitri).val())
    var dongia = vnumber.clear($('#suadongia-' + vitri).val())
    var giamgiatien = vnumber.clear($('#suagiamgiatien-' + vitri).val())
    var giamgiaphantram = vnumber.clear($('#suagiamgiaphantram-' + vitri).val())

    if (giaban > dongia) {
      global.hoadon[global.chonhoadon].hanghoa[vitri].dongia = giaban
      $('#dongia-' + vitri).val(vnumber.format(giaban))
    }
    else if (giaban < 0) giaban = 0
    else {
      // tính giảm giá, bỏ qua phần trăm, còn lại dồn vào giảm tiền
      var dongia = ((100 - giamgiaphantram) / 100 * dongia).toFixed(2)
      giamgia = dongia - giaban
      global.hoadon[global.chonhoadon].hanghoa[vitri].giamgiatien = giamgia
      $('#suagiamgiatien-' + vitri).val(vnumber.format(giamgia))
    }

    global.hoadon[global.chonhoadon].hanghoa[vitri].giaban = giaban
    $('#suagiaban-' + vitri).val(vnumber.format(giaban))
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
    var tonghang = 0
    var tongtien = 0
    var thanhtoan = 0
    var giamgiatien = global.hoadon[global.chonhoadon].giamgiatien
    var giamgiaphantram = global.hoadon[global.chonhoadon].giamgiaphantram

    global.hoadon[global.chonhoadon].hanghoa.forEach(hd => {
      tonghang += hd.soluong * hd.dongia
      tongtien += hd.soluong * hd.giaban
    })

    thanhtien = tongtien * (100 - giamgiaphantram) / 100
    thanhtien -= giamgiatien

    thanhtoan = tongtien
    global.hoadon[global.chonhoadon].tonghang = tonghang
    global.hoadon[global.chonhoadon].tongtien = tongtien
    global.hoadon[global.chonhoadon].thanhtien = thanhtien
    // nếu thanh toán nhiều hơn 1 loại thì khóa input thanh toán
    var loaithanhtoan = global.hoadon[global.chonhoadon].thanhtoan

    tailaitienthua()
    $('#tongtien').text(vnumber.format(tongtien))
    $('#cantra').text(vnumber.format(thanhtien))
  }

  function suagiamgiahoadon(type) {
    var tongtien = vnumber.clear($('#tongtien').text())
    var giamgiatien = vnumber.clear($('#suagiamgiatien').val())
    var giamgiaphantram = vnumber.clear($('#suagiamgiaphantram').val())

    if (giamgiaphantram < 0) giamgiaphantram = 0
    else if (giamgiaphantram > 100) giamgiaphantram = 100

    if (giamgiaphantram) tongtien = (tongtien * (100 - giamgiaphantram) / 100).toFixed()

    if (giamgiatien < 0) giamgiatien = 0
    else if (giamgiatien > tongtien) giamgiatien = tongtien

    tongtien -= giamgiatien

    global.hoadon[global.chonhoadon].giamgiatien = giamgiatien
    global.hoadon[global.chonhoadon].giamgiaphantram = giamgiaphantram
    global.hoadon[global.chonhoadon].thanhtien = tongtien
    $('#suagiamgiatien').val(vnumber.format(giamgiatien))
    $('#suagiamgiaphantram').val(vnumber.format(giamgiaphantram))
    $('#cantra').text(vnumber.format(tongtien))

    // sửa tiền ra nợ hay
    tailaitienthua()
  }

  function tailaitienthua() {
    $('#blocktienthua').hide()
    $('#blocktienno').hide()
    var thanhtien = global.hoadon[global.chonhoadon].thanhtien
    if (global.hoadon[global.chonhoadon].suathanhtoan) {
      // chưa sửa thanh toán
      // mặc định thanh toán bằng tiền mặt
      global.hoadon[global.chonhoadon].thanhtoan[0] = global.hoadon[global.chonhoadon].thanhtien
      global.hoadon[global.chonhoadon].thanhtoan[1] = 0
      global.hoadon[global.chonhoadon].thanhtoan[2] = 0
      $('#thanhtoantien').val(vnumber.format(global.hoadon[global.chonhoadon].thanhtien))
      $('#thanhtoanchuyenkhoan').val(0)
      $('#thanhtoandiem').val(0)
    }
    else {
      // đã sửa thanh toán
      // tính lại tiền thừa
      var loaithanhtoan = global.hoadon[global.chonhoadon].thanhtoan
      var tongthanhtoan = loaithanhtoan[0] + loaithanhtoan[1] + loaithanhtoan[2]
      if (tongthanhtoan == thanhtien) { }
      else if (tongthanhtoan > thanhtien) {
        $('#tienthua').text(vnumber.format(tongthanhtoan - thanhtien))
        $('#blocktienthua').show()
      }
      else {
        $('#tienno').text(vnumber.format(thanhtien - tongthanhtoan))
        $('#blocktienno').show()
      }
    }
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