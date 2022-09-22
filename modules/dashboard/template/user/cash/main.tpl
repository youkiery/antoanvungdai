<!-- BEGIN: main -->
<div class="modal fade" id="modal-themphieuthu" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title"> Thêm phiếu thu </h4>
      </div>
      <div class="modal-body">
        <div class="form-group row">
          <div class="col-xs-8"> Tiền thu </div>
          <div class="col-xs-16">
            <input type="text" class="form-control" id="phieuthutien" onkeyup="tiente('phieuthutien')">
          </div>
        </div>

        <div class="form-group row">
          <div class="col-xs-8"> Loại thu </div>
          <div class="col-xs-16">
            <div class="input-group">
              <select class="form-control" id="phieuthuloai">
                {{loaithu}}
              </select>
              <div class="input-group-btn">
                <button class="btn btn-success" onclick="themloaithu(0)">
                  <span class="fa fa-plus"></span>
                </button>
              </div>
            </div>
          </div>
        </div>

        <div class="form-group row">
          <div class="col-xs-8"> Ghi chú </div>
          <div class="col-xs-16">
            <textarea type="text" class="form-control" id="phieuthughichu"></textarea>
          </div>
        </div>

        <button class="btn btn-success btn-block" onclick="xacnhanthemphieuthu()">
          Thêm
        </button>
      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="modal-themphieuchi" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title"> Thêm phiếu chi </h4>
      </div>
      <div class="modal-body">
        <div class="form-group row">
          <div class="col-xs-8"> Tiền chi </div>
          <div class="col-xs-16">
            <input type="text" class="form-control" id="phieuchitien" onkeyup="tiente('phieuchitien')">
          </div>
        </div>

        <div class="form-group row">
          <div class="col-xs-8"> Loại chi </div>
          <div class="col-xs-16">
            <div class="input-group">
              <select class="form-control" id="phieuchiloai">
                {{loaichi}}
              </select>
              <div class="input-group-btn">
                <button class="btn btn-success" onclick="themloaithu(1)">
                  <span class="fa fa-plus"></span>
                </button>
              </div>
            </div>
          </div>
        </div>

        <div class="form-group row">
          <div class="col-xs-8"> Ghi chú </div>
          <div class="col-xs-16">
            <textarea type="text" class="form-control" id="phieuchighichu"></textarea>
          </div>
        </div>

        <button class="btn btn-success btn-block" onclick="xacnhanthemphieuchi()">
          Thêm
        </button>
      </div>
    </div>
  </div>
</div>

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
        <h4 class="modal-title"> Lọc thu chi </h4>
      </div>
      <div class="modal-body">
        <div class="form-group row">
          <div class="col-xs-8"> Thời gian </div>
          <div class="col-xs-8">
            <input type="text" class="date form-control" id="tim-thoigiandau" value="{batdau}">
          </div>
          <div class="col-xs-8">
            <input type="text" class="date form-control" id="tim-thoigiancuoi" value="{ketthuc}">
          </div>
        </div>

        <div class="form-group row">
          <div class="col-xs-8"> Loại tiền </div>
          <div class="col-xs-16"> 
            <input type="radio" name="loaitien" id="3" value="3" checked> <label for="3"> Toàn bộ </label>
            <input type="radio" name="loaitien" id="0" value="0"> <label for="0"> Tiền mặt </label>
            <input type="radio" name="loaitien" id="1" value="1"> <label for="1"> Chuyển khoản </label>
            <input type="radio" name="loaitien" id="2" value="2"> <label for="2"> Điểm </label> 
          </div>
        </div>

        <div class="form-group row">
          <div class="col-xs-8"> Ghi chú </div>
          <div class="col-xs-16">
            <input type="text" class="form-control" id="tim-ghichu">
          </div>
        </div>

        <button class="btn btn-info btn-block" onclick="timkiem(1)">
          Tìm kiếm
        </button>
      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="modal-themloaithuchi" role="dialog">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title"> Thêm loại thu chi </h4>
      </div>
      <div class="modal-body">
        <div class="form-group row">
          <div class="col-xs-8"> Loại thu chi </div>
          <div class="col-xs-16">
            <input type="text" class="form-control" id="them-loaithuchi">
          </div>
        </div>

        <button class="btn btn-info btn-block" onclick="xacnhanthemloaithuchi(1)">
          Thêm
        </button>
      </div>
    </div>
  </div>
</div>

<div id="printable"></div>
<div class="pw-content nonprintable">
  <div class="pw-header">
    Thu chi
  </div>

  <div class="pw-card">
    <div class="pw-card-header">
      <button class="btn btn-success" onclick="themphieuthu()"> <span class="fa fa-plus"></span> </button>
      <button class="btn btn-warning" onclick="themphieuchi()"> <span class="fa fa-plus"></span> </button>
      <button class="btn btn-info" onclick="lochoadon()"> <span class="fa fa-search"></span> </button>
    </div>
    <div class="pw-card-content" id="content">
      {danhsach}
    </div>
  </div>
</div>

<script>
  var global = {
    loai: 0,
    modal: ['phieuthuloai', 'phieuchiloai'],
    filter: {
      page: 1,
      batdau: '{batdau}',
      ketthuc: '{ketthuc}',
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

  function themphieuthu() {
    $('#phieuthutien').val('0')
    $('#phieuthuloai option:first-child').prop('selected', true)
    $('#phieuthughichu').val('')
    $('#modal-themphieuthu').modal('show')
  }

  function themphieuchi() {
    $('#phieuchitien').val('0')
    $('#phieuchiloai option:first-child').prop('selected', true)
    $('#phieuchighichu').val('')
    $('#modal-themphieuchi').modal('show')
  }

  function tiente(selector) {
    $('#'+ selector).val(vnumber.format(vnumber.clear($('#'+ selector).val())))
  }

  function timkiem(page) {
    vhttp.post('/dashboard/api/', {
      action: 'taisoquy',
      filter: laydieukienloc()
    }).then((resp) => {
      global.page = page
      $('#content').html(resp.danhsach)
      $('#modal-timhoadon').modal('hide')
    }, (e) => { })
  }

  function themloaithu(loai) {
    global.loai = loai
    $('#them-loaithuchi').val('')
    $('#modal-themloaithuchi').modal('show')
  }

  function xacnhanthemloaithuchi() {
    vhttp.post('/dashboard/api/', {
      action: 'themloaithuchi',
      ten: $('#them-loaithuchi').val(),
      loai: global.loai
    }).then((resp) => {
      $('#' + global.modal[global.loai]).html(resp.html)
      $('#' + global.modal[global.loai] + ' option:last-child').prop('selected', true)
      $('#modal-themloaithuchi').modal('hide')
    }, (e) => { })
  }

  // function chitiet(id) {
  //   if ($('#tr-' + id).attr('load') == '0') {
  //     vhttp.post('/dashboard/api/', {
  //       action: 'chitiethoadon',
  //       id: id
  //     }).then((resp) => {
  //       $('#tr-' + id).attr('load', '1')
  //       $('#td-' + id).html(resp.html)
  //     }, (e) => { })
  //   }
  //   $('.chitiet').hide()
  //   $('#tr-' + id).show()
  // }

  // function xoahoadon(id) {
  //   global.id = id
  //   $('#modal-xoahoadon').modal('show')
  // }

  // function xacnhanxoahoadon(id) {
  //   vhttp.post('/dashboard/api/', {
  //     action: 'xoahoadon',
  //     id: global.id
  //   }).then((resp) => {
  //     $('#content').html(resp.danhsach
  //     $('#modal-xoahoadon').modal('hide')
  //   }, (e) => { })
  // }

  function laydieukienloc() {
    return {
      page: global.page,
      batdau: $('#tim-thoigiandau').val(),
      ketthuc: $('#tim-thoigiancuoi').val(),
      loaitien: $('[name=loaitien]:checked').attr('id'),
      ghichu: $('#tim-ghichu').val(),
    }
  }

  function xacnhanthemphieuthu() {
    vhttp.post('/dashboard/api/', {
      action: 'themphieuthu',
      data: {
        sotien: $('#phieuthutien').val(),
        loai: $('#phieuthuloai').val(),
        ghichu: $('#phieuthughichu').val(),
      },
      filter: laydieukienloc()
    }).then((resp) => {
      $('#content').html(resp.html)
      $('#modal-themphieuthu').modal('hide')
    }, (e) => { })
  }

  function xacnhanthemphieuchi() {
    vhttp.post('/dashboard/api/', {
      action: 'themphieuchi',
      data: {
        sotien: $('#phieuchitien').val(),
        loai: $('#phieuchiloai').val(),
        ghichu: $('#phieuchighichu').val(),
      },
      filter: laydieukienloc()
    }).then((resp) => {
      $('#content').html(resp.html)
      $('#modal-themphieuchi').modal('hide')
    }, (e) => { })
  }
</script>
<!-- END: main -->