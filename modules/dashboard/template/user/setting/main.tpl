<!-- BEGIN: main -->
<div class="modal fade" id="modal-xoahoadon" role="dialog">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title"> Cấu hình hóa đơn </h4>
      </div>
      <div class="modal-body">

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
    Cài đặt
  </div>

  <div class="pw-card">
    <div class="form-group">
      <button class="btn btn-info" onclick="cauhinhhoadon()">
        Cấu hình hóa đơn
      </button>
      <div style="float: right;">
        <button class="btn btn-success" onclick="themnhanvien()">
          <span class="fa fa-plus"></span>
          Thêm nhân viên
        </button>
      </div>
    </div>

    <table class="table table-bordered">
      <tr>
        <th colspan="5" class="text-center"> Danh sách nhân viên </th>
      </tr>
      <tr>
        <th> STT </th>
        <th> Nhân viên </th>
        <th> Tài khoản </th>
        <th> Chức vụ </th>
        <th>  </th>
      </tr>
    </table>
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

  function cauhinhhoadon() {
    $('#modal-cau-hinh').modal('show')
  }

  function themnhanvien() {
    
  }

  function timkiem(page) {
    vhttp.post('/dashboard/api/', {
      action: 'taihoadon',
      filter: global.filter
    }).then((resp) => {
      $('#content').html(resp.danhsach)
      $('#modal-timhoadon').modal('hide')
    }, (e) => { })
  }
</script>
<!-- END: main -->