<!-- BEGIN: main -->
<div class="row">
  <div class="col-xs-24 col-sm-6"> {sidemenu} </div>
  <div class="col-xs-24 col-sm-18 pw-content">
    <!-- BEGIN: coquyen -->
    <div id="modal-xoa" class="modal fade" role="dialog">
      <div class="modal-dialog modal-sm">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title"> Xác nhận xoá vật nuôi </h4>
          </div>
          <div class="modal-body text-center">
            Sau khi xác nhận vật nuôi sẽ bị xoá vĩnh viễn
            <button class="btn btn-danger btn-block" onclick="xacnhanxoa()">
              Xoá
            </button>
          </div>
        </div>
      </div>
    </div>

    <div id="modal-capnhat" class="modal fade" role="dialog">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title"> Cập nhật vật nuôi </h4>
          </div>
          <div class="modal-body">
            <div class="form-group"> <b>Thú cưng</b> </div>
            <div class="form-group goiy">
              <input type="text" class="form-control" id="thucung" placeholder="Tìm kiếm thú cưng theo tên, microchip">
              <div class="danhsachgoiy" id="goiythucung"></div>
            </div>

            <div class="form-group row">
              <div class="col-xs-6"> Tên thú cưng </div>
              <div class="col-xs-18">
                <input type="text" class="form-control" id="tenthucung" placeholder="Tên thú cưng">
              </div>
            </div>

            <div class="form-group row">
              <div class="col-xs-6"> Microchip </div>
              <div class="col-xs-18">
                <input type="text" class="form-control" id="micro" placeholder="Microchip">
              </div>
            </div>

            <div class="form-group row">
              <div class="col-xs-6"> Giống loài </div>
              <div class="col-xs-18 goiy">
                <input type="text" class="form-control" id="giongloai" placeholder="Tìm kiếm giống loài">
                <div class="danhsachgoiy" id="goiygiongloai"></div>
              </div>
            </div>

            <div class="form-group row">
              <div class="col-xs-6"> </div>
              <div class="col-xs-9">
                <input type="text" class="form-control" id="loai" placeholder="Loài">
              </div>
              <div class="col-xs-9">
                <input type="text" class="form-control" id="giong" placeholder="Giống">
              </div>
            </div>

            <div class="form-group"> Ngày sinh </div>
            <div class="form-group">
              <input type="text" class="form-control date" id="ngaysinh">
            </div>

            <div class="row">
              <div class="col-sm-6"> Hình ảnh </div>
              <div class="col-sm-18" id="hinhanh"> </div>
            </div>

            <button class="btn btn-info btn-block capnhat" onclick="xacnhanthemtiemphong()">
              Cập nhật
            </button>
          </div>
        </div>
      </div>
    </div>

    <div id="modal-chitiet" class="modal fade" role="dialog">
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title"> Chi tiết chủ hộ </h4>
          </div>
          <div class="modal-body" id="chitiet">
          </div>
        </div>
      </div>
    </div>

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
                <select class="form-control" id="timkiem-phuong">
                  <option value="0"> --- </option>
                  <!-- BEGIN: timkiemphuong -->
                  <option value="{idphuong}"> {tenphuong} </option>
                  <!-- END: timkiemphuong -->
                </select>
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

    <!-- <div id="thongke">
      {dulieuthongke}
    </div> -->

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
        idchu: 0,
        idthucung: 0,
        trang: 1
      }
      var config = {
        apiKey: "AIzaSyDWt6y4laxeTBq2RYDY6Jg4_pOkdxwsjUE",
        authDomain: "directed-sonar-241507.firebaseapp.com",
        databaseURL: "https://directed-sonar-241507.firebaseio.com",
        projectId: "directed-sonar-241507",
        storageBucket: "directed-sonar-241507.appspot.com",
        messagingSenderId: "816396321770",
        appId: "1:816396321770:web:193e84ee21b16d41"
      }

      $(document).ready(() => {
        $('.date').datepicker({
          dateFormat: 'dd/mm/yy'
        })

        firebase.initializeApp(config);
        vimage.path = '/vungdai/images'
        vimage.install('hinhanh')

        vremind.install('#giongloai', '#goiygiongloai', (key) => {
          return new Promise(resolve => {
            vhttp.post('/quanly/api/', {
              action: 'timkiemgiongloai',
              tukhoa: key,
            }).then((phanhoi) => {
              resolve(phanhoi.danhsach)
            }, (error) => { })
          })
        }, 300, 300)
      })

      function timkiem() {
        $('#modal-timkiem').modal('show')
      }

      function chongiongloai(giong, loai) {
        $('#giong').val(giong)
        $('#loai').val(loai)
      }

      function thongtintruongloc(trang) {
        return {
          'tenchu': $('#timkiem-tenchu').val(),
          'dienthoai': $('#timkiem-dienthoai').val(),
          'thucung': $('#timkiem-tenthucung').val(),
          'micro': $('#timkiem-micro').val(),
          'giong': $('#timkiem-giong').val(),
          'loai': $('#timkiem-loai').val(),
          'phuong': $('#timkiem-phuong').val(),
          'tiemphong': $('[name=tiemphong]:checked')[0].value,
          'trang': trang,
        }
      }

      function dentrang(trang) {
        vhttp.post('/quanly/api/', {
          action: 'timkiemthongke',
          truongloc: thongtintruongloc(trang),
        }).then((phanhoi) => {
          $('#danhsach').html(phanhoi.danhsachthongke)
          global.trang = 1
          keolen()
          $('#modal-timkiem').modal('hide')
        }, (error) => { })
      }

      function chitiet(id) {
        vhttp.post('/quanly/api/', {
          action: 'laychitiet',
          idchu: id,
        }).then((phanhoi) => {
          global.idchu = id
          $('#chitiet').html(phanhoi.chitiet)
          $('#modal-chitiet').modal('show')
        }, (error) => { })
      }

      function xoa(id) {
        global.idthucung = id
        $("#modal-xoa").modal("show")
      }

      function xacnhanxoa() {
        vloading.freeze()
        vhttp.post('/quanly/api/', {
          action: 'xoachitietchuho',
          truongloc: thongtintruongloc(global.trang),
          id: global.idthucung,
          idchu: global.idchu,
        }).then((phanhoi) => {
          vloading.defreeze()
          $('#chitiet').html(phanhoi.chitiet)
          $('#danhsach').html(phanhoi.danhsachthongke)
          $('#modal-xoa').modal('hide')
        }, (error) => {
          vloading.defreeze()
        })
      }

      function capnhat(id) {
        vloading.freeze()
        vhttp.post('/quanly/api/', {
          action: 'laythongtinthucung',
          id: id,
        }).then((phanhoi) => {
          vloading.defreeze()
          global.idthucung = id
          $('#thucung').val('')
          $('#tenthucung').val(phanhoi.tenthucung)
          $('#micro').val(phanhoi.micro)
          $('#giongloai').val(phanhoi.giongloai)
          $('#loai').val(phanhoi.loai)
          $('#giong').val(phanhoi.giong)
          $('#ngaysinh').val(phanhoi.ngaysinh)
          vimage.data['hinhanh'] = [phanhoi.hinhanh]
          vimage.reload('hinhanh')
          $('#modal-capnhat').modal('show')
        }, (error) => {
          vloading.defreeze()
        })
      }

      function kiemtrangaythang(ngay) {
        if (!ngay.length) return true
        var kiemtra = /\d{1,2}\/\d{1,2}\/\d{4}/.test(ngay)
        if (!kiemtra) return false;
        var parts = ngay.split("/");
        var day = parseInt(parts[0], 10);
        var month = parseInt(parts[1], 10);
        var year = parseInt(parts[2], 10);

        if (year < 1000 || year > 3000 || month == 0 || month > 12) return false;
        var monthLength = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
        if (year % 400 == 0 || (year % 100 != 0 && year % 4 == 0)) monthLength[1] = 29;
        return day > 0 && day <= monthLength[month - 1];
      }

      function xacnhanthemtiemphong() {
        var dulieu = {
          tenthucung: $('#tenthucung').val(),
          micro: $('#micro').val(),
          loai: $('#loai').val(),
          giong: $('#giong').val(),
          ngaysinh: $('#ngaysinh').val(),
        }
        if (!dulieu.tenthucung.length) vhttp.notify('Không được để trống tên thú cưng')
        else if (!dulieu.micro.length) vhttp.notify('Không được để trống số Microchip')
        else if (!dulieu.giong.length) vhttp.notify('Không được để trống tên giống')
        else if (!dulieu.loai.length) vhttp.notify('Không được để trống tên loài')
        else if (!kiemtrangaythang(dulieu.ngaysinh)) vhttp.notify('Ngày sinh không hợp lệ')
        else {
          vloading.freeze()
          vimage.uploadimage('hinhanh').then(() => {
            dulieu.hinhanh = vimage.data['hinhanh']
            vhttp.post('/quanly/api/', {
              action: 'capnhatthucung',
              id: global.idthucung,
              idchu: global.idchu,
              dulieu: dulieu,
              truongloc: thongtintruongloc(global.trang),
            }).then((phanhoi) => {
              vloading.defreeze()
              $('#chitiet').html(phanhoi.chitiet)
              $('#danhsach').html(phanhoi.danhsachthongke)
              $('#modal-capnhat').modal('hide')
            }, (error) => {
              vloading.defreeze()
            })
          })
        }
      }

      function keolen() {
        $("html, body").animate({ scrollTop: $("#danhsach").offset().top }, "slow");
        return false;
      }
    </script>
    <!-- END: coquyen -->
    <!-- BEGIN: khongquyen -->
    Tài khoản không có quyền truy cập
    <!-- END: khongquyen -->
  </div>
</div>
<!-- END: main -->