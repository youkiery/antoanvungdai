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

<div class="modal fade" id="modal-timhoadon" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title"> Tìm hóa đơn </h4>
      </div>
      <div class="modal-body">

        <div class="form-group row">
          <div class="col-xs-8"> Mã hóa đơn </div>
          <div class="col-xs-16">
            <input autocomplete="off" type="text" class="form-control" id="tim-hoadon">
          </div>
        </div>

        <div class="form-group row">
          <div class="col-xs-8"> Mã hàng, tên hàng </div>
          <div class="col-xs-16">
            <input autocomplete="off" type="text" class="form-control" id="tim-hanghoa">
          </div>
        </div>

        <div class="form-group row">
          <div class="col-xs-8"> Khách hàng </div>
          <div class="col-xs-16">
            <input autocomplete="off" type="text" class="form-control" id="tim-khachhang">
          </div>
        </div>

        <div class="form-group row">
          <div class="col-xs-8"> Thời gian </div>
          <div class="col-xs-8">
            <input autocomplete="off" type="text" class="date form-control" id="tim-thoigiandau" value="{dauthang}">
          </div>
          <div class="col-xs-8">
            <input autocomplete="off" type="text" class="date form-control" id="tim-thoigiancuoi" value="{cuoithang}">
          </div>
        </div>

        <div class="form-group">
          <button class="btn btn-info btn-xs" onclick="chonngay(1)"> Hôm nay </button>
          <button class="btn btn-info btn-xs" onclick="chonngay(2)"> Hôm qua </button>
          <button class="btn btn-info btn-xs" onclick="chonngay(3)"> Tuần này </button>
          <button class="btn btn-info btn-xs" onclick="chonngay(4)"> Tuần trước </button>
          <button class="btn btn-info btn-xs" onclick="chonngay(5)"> Tháng này </button>
          <button class="btn btn-info btn-xs" onclick="chonngay(6)"> Tháng trước </button>
          <button class="btn btn-info btn-xs" onclick="chonngay(7)"> Năm nay </button>
          <button class="btn btn-info btn-xs" onclick="chonngay(8)"> Năm ngoái </button>
        </div>

        <div class="form-group row">
          <div class="col-xs-8"> Người bán </div>
          <div class="col-xs-16">
            <select class="form-control" id="tim-nguoiban">
              <option value="0"> Chọn nhân viên </option>
              {tuychonnhanvien}
            </select>
          </div>
        </div>

        <div class="form-group row">
          <div class="col-xs-8"> Người ra toa </div>
          <div class="col-xs-16">
            <select class="form-control" id="tim-nguoiratoa">
              <option value="0"> Chọn nhân viên </option>
              {tuychonnhanvien}
            </select>
          </div>
        </div>

        <div class="form-group row">
          <div class="col-xs-8"> Ghi chú </div>
          <div class="col-xs-16">
            <input autocomplete="off" type="text" class="form-control" id="tim-ghichu">
          </div>
        </div>

        <button class="btn btn-info btn-block" onclick="timkiem(1)">
          Tìm kiếm
        </button>

      </div>
    </div>
  </div>
</div>

<div id="printable"></div>
<div class="pw-content nonprintable">
  <div class="pw-header">
    Hóa đơn
  </div>

  <div class="pw-card">
    <div class="pw-card-header">
      <button class="btn btn-info" onclick="lochoadon()"> <span class="fa fa-search"></span> Lọc hóa đơn </button>
      <!-- BEGIN: import -->
      <button class="btn btn-info"> <span class="fa fa-file"></span> Import </button>
      <!-- END: import -->
      <!-- BEGIN: export -->
      <button class="btn btn-info"> <span class="fa fa-file"></span> Export </button>
      <!-- END: export -->
    </div>
    <div class="pw-card-content" id="content">
      {danhsach}
    </div>
  </div>
</div>

<script>
  var global = {
    filter: {
      page: 1,
      hoadon: '',
      hanghoa: '',
      khachhang: '',
      thoigiandau: '',
      thoigiancuoi: '',
      nguoiban: '',
      nguoiratoa: '',
      ghichu: '',
    }
  }

  $(document).ready(() => {
    $('.date').datepicker({
      dateFormat: 'dd/mm/yy'
    })
  })

  function lochoadon() {
    $('#modal-timhoadon').modal('show')
  }

  function timkiem(page) {
    global.filter = {
      page: page,
      hoadon: $('#tim-hoadon').val(),
      hanghoa: $('#tim-hanghoa').val(),
      khachhang: $('#tim-khachhang').val(),
      thoigiandau: $('#tim-thoigiandau').val(),
      thoigiancuoi: $('#tim-thoigiancuoi').val(),
      nguoiban: $('#tim-nguoiban').val(),
      nguoiratoa: $('#tim-nguoiratoa').val(),
      ghichu: $('#tim-ghichu').val(),
    }

    vhttp.post('/dashboard/api/', {
      action: 'taihoadon',
      filter: global.filter
    }).then((resp) => {
      $('#content').html(resp.danhsach)
      $('#modal-timhoadon').modal('hide')
    }, (e) => { })
  }

  function chitiet(id) {
    if ($('#tr-' + id).attr('load') == '0') {
      vhttp.post('/dashboard/api/', {
        action: 'chitiethoadon',
        id: id
      }).then((resp) => {
        $('#tr-' + id).attr('load', '1')
        $('#td-' + id).html(resp.html)
      }, (e) => { })
    }
    $('.chitiet').hide()
    $('#tr-' + id).show()
  }

  function inhoadon(id) {
    vhttp.post('/dashboard/api/', {
      action: 'inhoadon',
      id: id
    }).then((resp) => {
      // thanh toán xong xóa hóa đơn hiện tại
      setTimeout(() => {
        $('#printable').html(resp.html)
        window.print()
      }, 500);
    }, (e) => { })
  }

  function xoahoadon(id) {
    global.id = id
    $('#modal-xoahoadon').modal('show')
  }

  function xacnhanxoahoadon(id) {
    vhttp.post('/dashboard/api/', {
      action: 'xoahoadon',
      id: global.id
    }).then((resp) => {
      $('#content').html(resp.danhsach)
      $('#modal-xoahoadon').modal('hide')
    }, (e) => { })
  }

  function chonngay(loai) {
    var batdau = $('#tim-thoigiandau')
    var ketthuc = $('#tim-thoigiancuoi')
    var homnay = new Date()
    var cuoithang = new Date(homnay.getFullYear(), homnay.getMonth() + 1, 0);
    
    switch (loai) {
      case 1:
        // hôm nay 
        batdau.val(timetodate(homnay.getTime()))
        ketthuc.val(timetodate(homnay.getTime()))
      break;
      case 2:
        // hôm qua 
        batdau.val(timetodate(homnay.getTime() - 60 * 60 * 24 * 1000))
        ketthuc.val(timetodate(homnay.getTime() - 60 * 60 * 24 * 1000))
      break;
      case 3:
        // tuần này 
        date = homnay.getDay()
        if (date == 0) date = 7
        batdau.val(timetodate(homnay.getTime() - (date - 1) * 60 * 60 * 24 * 1000))
        ketthuc.val(timetodate(homnay.getTime() + (7 - date) * 60 * 60 * 24 * 1000))
      break;
      case 4:
        // tuần trước 
        date = homnay.getDay()
        if (date == 0) date = 7
        batdau.val(timetodate(homnay.getTime() + (1 - date - 7) * 60 * 60 * 24 * 1000))
        ketthuc.val(timetodate(homnay.getTime() - date * 60 * 60 * 24 * 1000))
      break;
      case 5:
        // tháng này
        var cuoithang = new Date(homnay.getFullYear(), homnay.getMonth() + 1, 0);
        batdau.val('01/' + dienso(cuoithang.getMonth() + 1) +'/'+ cuoithang.getFullYear())
        ketthuc.val(cuoithang.getDate() + '/' + dienso(cuoithang.getMonth() + 1) +'/'+ cuoithang.getFullYear()) 
      break;
      case 6:
        // tháng trước
        var cuoithang = new Date(homnay.getFullYear(), homnay.getMonth(), 0);
        batdau.val('01/' + dienso(cuoithang.getMonth() + 1) +'/'+ cuoithang.getFullYear())
        ketthuc.val(cuoithang.getDate() + '/' + dienso(cuoithang.getMonth() + 1) +'/'+ cuoithang.getFullYear()) 
      break;
      case 7:
        // năm này
        var cuoinam = new Date(homnay.getFullYear() + 1, 0, 0);
        batdau.val('01/01/'+ cuoinam.getFullYear())
        ketthuc.val(cuoinam.getDate() +'/'+ (cuoinam.getMonth() + 1) +'/'+ cuoinam.getFullYear())
      break;
      case 8:
        // năm trước
        var cuoinam = new Date(homnay.getFullYear(), 0, 0);
        batdau.val('01/01/'+ cuoinam.getFullYear())
        ketthuc.val(cuoinam.getDate() +'/'+ (cuoinam.getMonth() + 1) +'/'+ cuoinam.getFullYear())
      break;
    }    
  }  
</script>
<!-- END: main -->