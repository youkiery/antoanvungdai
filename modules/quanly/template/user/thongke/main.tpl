<!-- BEGIN: main -->
<div class="row">
  <div class="col-xs-24 col-sm-6"> {sidemenu} </div>
  <div class="col-xs-24 col-sm-18 pw-content">
    <!-- BEGIN: coquyen -->
    <div id="modal-timkiem" class="modal fade" role="dialog">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title"> Lọc dữ liệu thống kê </h4>
          </div>
          <div class="modal-body">
            <div class="form-group row">
              <div class="col-xs-6"> Tên chủ hộ </div>
              <div class="col-xs-18">
                <input type="text" class="form-control" id="timkiem-tenchu" placeholder="Tên chủ hộ">
              </div>
            </div>

            <div class="form-group row">
              <div class="col-xs-6"> Điện thoại </div>
              <div class="col-xs-18">
                <input type="text" class="form-control" id="timkiem-dienthoai" placeholder="Điện thoại">
              </div>
            </div>

            <div class="form-group row">
              <div class="col-xs-6"> Tên thú cưng </div>
              <div class="col-xs-18">
                <input type="text" class="form-control" id="timkiem-tenthucung" placeholder="Tên thú cưng">
              </div>
            </div>

            <div class="form-group row">
              <div class="col-xs-6"> Microchip </div>
              <div class="col-xs-18">
                <input type="text" class="form-control" id="timkiem-micro" placeholder="Microchip">
              </div>
            </div>

            <div class="form-group row">
              <div class="col-xs-6"> Giống Loài </div>
              <div class="col-xs-9">
                <input type="text" class="form-control" id="timkiem-loai" placeholder="Loài">
              </div>
              <div class="col-xs-9">
                <input type="text" class="form-control" id="timkiem-giong" placeholder="Giống">
              </div>
            </div>

            <div class="form-group row">
              <div class="col-xs-6"> Phường </div>
              <div class="col-xs-18">
                <input type="text" class="form-control" id="timkiem-phuong" placeholder="Phường">
              </div>
            </div>

            <div class="form-group row">
              <div class="col-xs-6"> Tiêm phòng </div>
              <div class="col-xs-6">
                <label> <input type="radio" name="tiemphong" value="0" checked> Tất cả </label>
              </div>
              <div class="col-xs-6">
                <label> <input type="radio" name="tiemphong" value="1"> Chưa tiêm </label>
              </div>
              <div class="col-xs-6">
                <label> <input type="radio" name="tiemphong" value="2"> Đã tiêm </label>
              </div>
            </div>

            <!-- <div class="form-group row">
          <div class="col-xs-6"> Thời gian tiêm </div>
          <div class="col-xs-9">
            <input type="text" class="form-control date" id="timkiem-batdau" placeholder="Từ ngày">
          </div>
          <div class="col-xs-9">
            <input type="text" class="form-control date" id="timkiem-ketthuc" placeholder="Đến ngày">
          </div>
        </div> -->

            <button class="btn btn-info btn-block" onclick="dentrang(1)">
              Lọc dữ liệu
            </button>
          </div>
        </div>
      </div>
    </div>

    <div id="thongke">
      {dulieuthongke}
    </div>

    <div class="form-group">
      <button class="btn btn-info" onclick="timkiem()">
        <span class="fa fa-search"></span> Lọc dữ liệu
      </button>
    </div>

    <div id="danhsach">
      {danhsachthongke}
    </div>

    <script>
      global = {
        trang: 1
      }

      function timkiem() {
        $('#modal-timkiem').modal('show')
      }

      function thongtintruongloc(trang) {
        return {
          'tenchu': $('#timkiem-tenchu').val(),
          'dienthoai': $('#timkiem-dienthoai').val(),
          'thucung': $('#timkiem-thucung').val(),
          'micro': $('#timkiem-micro').val(),
          'giong': $('#timkiem-giong').val(),
          'loai': $('#timkiem-loai').val(),
          'phuong': $('#timkiem-phuong').val(),
          'tiemphong': $('[name=tiemphong]:checked')[0].value,
          'trang': trang,
          // 'batdau': $('#timkiem-batdau').val(),
          // 'ketthuc': $('#timkiem-ketthuc').val(),
        }
      }

      function dentrang(trang) {
        vhttp.post('/quanly/api/', {
          action: 'timkiemthongke',
          truongloc: thongtintruongloc(trang),
        }).then((resp) => {
          $('#danhsach').html(resp.danhsachthongke)
          global.trang = 1
          $('#modal-timkiem').modal('hide')
        })
      }
    </script>
    <!-- END: coquyen -->
    <!-- BEGIN: khongquyen -->
    Tài khoản không có quyền truy cập
    <!-- END: khongquyen -->
  </div>
</div>
<!-- END: main -->