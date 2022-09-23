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

<div id="printable"></div>
<div class="pw-content nonprintable">
  <div class="pw-header">
    Thống kê
  </div>

  <div class="pw-card">
    <div class="pw-card-header">
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