<!-- BEGIN: main -->
<style>
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
      <button class="btn btn-info" onclick="lochoadon()"> <span class="fa fa-search"></span> </button>
      <!-- <button class="btn btn-success" onclick="themkhach()"> <span class="fa fa-plus"></span> </button> -->
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
</script>
<!-- END: main -->