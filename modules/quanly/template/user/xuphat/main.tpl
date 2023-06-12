<!-- BEGIN: main -->
<div class="row">
  <div class="col-xs-24 col-sm-6"> {sidemenu} </div>
  <div class="col-xs-24 col-sm-18 pw-content">
    <!-- BEGIN: coquyen -->
    <div id="modal-xoaxuphat" class="modal fade" role="dialog">
      <div class="modal-dialog modal-sm">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title"> Xóa xử phạt </h4>
          </div>
          <div class="modal-body text-center">
            Xác nhận phiếu xử phạt này
            <button class="btn btn-danger btn-block" onclick="xacnhanxoaxuphat()">
              Xóa
            </button>
          </div>
        </div>
      </div>
    </div>

    <div id="modal-dongphat" class="modal fade" role="dialog">
      <div class="modal-dialog modal-sm">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title"> Đóng phạt </h4>
          </div>
          <div class="modal-body">
            <div class="form-group"> Ngày đóng phạt </div>
            <div class="form-group">
              <input type="text" class="form-control date" id="dongphat-thoigian">
            </div>

            <button class="btn btn-warning btn-block" onclick="xacnhandongphat()">
              Đóng phạt
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
            <h4 class="modal-title"> Thông tin thú cưng </h4>
          </div>
          <div class="modal-body" id="chitiet">
          </div>
        </div>
      </div>
    </div>

    <div id="modal-themxuphat" class="modal fade" role="dialog">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title"> Thêm xử phạt </h4>
          </div>
          <div class="modal-body">
            <div class="form-group"> <b>Chủ hộ</b> </div>
            <div class="form-group goiy">
              <input type="text" class="form-control" id="chuho"
                placeholder="Tìm kiếm chủ hộ theo tên, địa chỉ, số điện thoại">
              <div class="danhsachgoiy" id="goiychuho"></div>
            </div>

            <div class="form-group row">
              <div class="col-xs-6"> Tên chủ hộ </div>
              <div class="col-xs-18">
                <input type="text" class="form-control" id="tenchu" placeholder="Tên chủ hộ">
              </div>
            </div>

            <div class="form-group row">
              <div class="col-xs-6"> Điện thoại </div>
              <div class="col-xs-18">
                <input type="text" class="form-control" id="dienthoai" placeholder="Điện thoại">
              </div>
            </div>

            <div class="form-group row">
              <div class="col-xs-6"> Địa chỉ </div>
              <div class="col-xs-18">
                <input type="text" class="form-control" id="diachi" placeholder="Địa chỉ">
              </div>
            </div>

            <div class="form-group row">
              <div class="col-xs-6"> Phường </div>
              <div class="col-xs-18">
                <select class="form-control" id="phuong">
                  <!-- BEGIN: phuong -->
                  <option value="{idphuong}">
                    {tenphuong}
                  </option>
                  <!-- END: phuong -->
                </select>
              </div>
            </div>

            <div class="form-group row">
              <div class="col-xs-6"> Nội dung </div>
              <div class="col-xs-18">
                <input type="text" class="form-control" id="noidung" placeholder="Nội dung">
              </div>
            </div>

            <div class="form-group row">
              <div class="col-xs-6"> Mức phạt </div>
              <div class="col-xs-18">
                <input type="text" class="form-control" id="mucphat" placeholder="Mức phạt">
              </div>
            </div>

            <div class="form-group"> Ngày phạt </div>
            <div class="form-group">
              <input type="text" class="form-control date" id="thoigianphat">
            </div>

            <div class="form-group"> Ngày đóng phạt (nếu không chọn sẽ mặc định là chưa đóng phạt) </div>
            <div class="form-group">
              <input type="text" class="form-control date" id="thoigiandong">
            </div>

            <button class="btn btn-success btn-block them" onclick="xacnhanthemxuphat()">
              Thêm
            </button>
            <button class="btn btn-info btn-block capnhat" onclick="xacnhanthemxuphat()">
              Cập nhật
            </button>
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
              <div class="col-xs-6"> Phường </div>
              <div class="col-xs-18">
                <input type="text" class="form-control" id="timkiem-phuong" placeholder="Phường">
              </div>
            </div>

            <div class="form-group row">
              <div class="col-xs-6"> Nội dung </div>
              <div class="col-xs-18">
                <input type="text" class="form-control" id="timkiem-noidung" placeholder="Nội dung">
              </div>
            </div>

            <div class="form-group row">
              <div class="col-xs-6"> Đóng phạt </div>
              <div class="col-xs-6">
                <label> <input type="radio" name="dongphat" value="0" checked> Tất cả </label>
              </div>
              <div class="col-xs-6">
                <label> <input type="radio" name="dongphat" value="1"> Chưa đóng </label>
              </div>
              <div class="col-xs-6">
                <label> <input type="radio" name="dongphat" value="2"> Đã đóng </label>
              </div>
            </div>

            <div class="form-group row">
              <div class="col-xs-6"> Thời gian phạt </div>
              <div class="col-xs-9">
                <input type="text" class="form-control date" id="timkiem-batdau" placeholder="Từ ngày">
              </div>
              <div class="col-xs-9">
                <input type="text" class="form-control date" id="timkiem-ketthuc" placeholder="Đến ngày">
              </div>
            </div>

            <button class="btn btn-info btn-block" onclick="dentrang(1)">
              Lọc dữ liệu
            </button>
          </div>
        </div>
      </div>
    </div>

    <div class="form-group">
      <button class="btn btn-success" onclick="themxuphat()">
        <span class="fa fa-plus"></span> Thêm xử phạt
      </button>
      <button class="btn btn-info" onclick="timkiem()">
        <span class="fa fa-search"></span> Lọc dữ liệu
      </button>
    </div>

    <div id="danhsach">
      {danhsachxuphat}
    </div>

    <script>
      global = {
        trang: 1,
        homnay: '{homnay}'
      }

      $(document).ready(() => {
        vhttp.alert()
        $('.date').datepicker({
          dateFormat: 'dd/mm/yy'
        })

        vnumber.install("#mucphat")
        vremind.install('#chuho', '#goiychuho', (key) => {
          return new Promise(resolve => {
            vhttp.post('/quanly/api/', {
              action: 'timkiemchuho',
              tukhoa: key,
            }).then((phanhoi) => {
              resolve(phanhoi.danhsach)
            })
          })
        }, 300, 300)
      })

      function chonchuho(idchu, ten, diachi, dienthoai, idphuong) {
        global.idchu = idchu
        $('#tenchu').val(ten)
        $('#diachi').val(diachi)
        $('#dienthoai').val(dienthoai)
        $('#phuong option[value=' + idphuong + ']')[0].selected = true
      }

      function timkiem() {
        $('#modal-timkiem').modal('show')
      }

      function thongtintruongloc(trang) {
        return {
          'tenchu': $('#timkiem-tenchu').val(),
          'dienthoai': $('#timkiem-dienthoai').val(),
          'phuong': $('#timkiem-phuong').val(),
          'noidung': $('#timkiem-noidung').val(),
          'dongphat': $('[name=dongphat]:checked')[0].value,
          'trang': trang,
          'batdau': $('#timkiem-batdau').val(),
          'ketthuc': $('#timkiem-ketthuc').val(),
        }
      }

      function dentrang(trang) {
        vhttp.post('/quanly/api/', {
          action: 'timkiemxuphat',
          truongloc: thongtintruongloc(trang),
        }).then((resp) => {
          $('#danhsach').html(resp.danhsachxuphat)
          global.trang = 1
          keolen()
          $('#modal-timkiem').modal('hide')
        })
      }

      // function chitiet(id) {
      //   vhttp.post('/danhsach/api/', {
      //     action: 'laychitiet',
      //     id: id,
      //   }).then((resp) => {
      //     $('#chitiet').html(resp.chitiet)
      //     $('#modal-chitiet').modal('show')
      //   })
      // }

      function dongphat(id) {
        global.id = id
        $('#dongphat-thoigian').val(global.homnay)
        $('#modal-dongphat').modal('show')
      }

      function xacnhandongphat() {
        let thoigian = $('#dongphat-thoigian').val()
        if (!thoigian.length || !kiemtrangaythang(thoigian)) vhttp.notify('Thời gian không hợp lệ')
        else {
          vhttp.post('/quanly/api/', {
            action: 'dongphat',
            id: global.id,
            thoigian: thoigian,
            truongloc: thongtintruongloc(global.trang),
          }).then((phanhoi) => {
            $('#danhsach').html(phanhoi.danhsachxuphat)
            $('#modal-dongphat').modal('hide')
          })
        }
      }

      function xoaxuphat(id) {
        global.id = id
        $('#modal-xoaxuphat').modal('show')
      }

      function xacnhanxoaxuphat() {
        vhttp.post('/quanly/api/', {
          action: 'xoaxuphat',
          id: global.id,
          truongloc: thongtintruongloc(global.trang),
        }).then((phanhoi) => {
          $('#danhsach').html(phanhoi.danhsachxuphat)
          $('#modal-xoaxuphat').modal('hide')
        })
      }

      function hienthinut() {
        if (global.id) {
          $('.them').hide()
          $('.capnhat').show()
        }
        else {
          $('.capnhat').hide()
          $('.them').show()
        }
      }

      function themxuphat() {
        global.id = 0
        hienthinut()
        $('#chuho').val('')
        $('#tenchu').val('')
        $('#dienthoai').val('')
        $('#diachi').val('')
        $('#noidung').val('')
        $('#mucphat').val('0')
        $('#thoigianphat').val(global.homnay)
        $('#thoigiandong').val('')
        $('#modal-themxuphat').modal('show')
      }

      function capnhattiemphong(id) {
        vhttp.post('/quanly/api/', {
          action: 'laythongtintiemphong',
          id: id,
        }).then((phanhoi) => {
          global.id = id
          hienthinut()
          $('#chuho').val('')
          $('#tenchu').val(phanhoi.tenchu)
          $('#dienthoai').val(phanhoi.dienthoai)
          $('#diachi').val(phanhoi.diachi)
          $('#thucung').val('')
          $('#tenthucung').val(phanhoi.tenthucung)
          $('#micro').val(phanhoi.micro)
          $('#giongloai').val(phanhoi.giongloai)
          $('#loai').val(phanhoi.loai)
          $('#giong').val(phanhoi.giong)
          $('#ngaysinh').val(phanhoi.ngaysinh)
          $('#thoigiantiem').val(phanhoi.thoigiantiem)
          phuong = $('#phuong option[value=' + phanhoi.idphuong + ']').prop('selected', true)
          vimage.data['hinhanh'] = [phanhoi.hinhanh]
          vimage.reload('hinhanh')
          $('#modal-themxuphat').modal('show')
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

      function xacnhanthemxuphat() {
        var phuong = $('#phuong option:selected')
        if (!phuong.length) {
          vhttp.notify('Chọn 1 phường trước khi thêm')
          return 0
        }
        var dulieu = {
          tenchu: $('#tenchu').val(),
          dienthoai: $('#dienthoai').val(),
          diachi: $('#diachi').val(),
          idphuong: phuong[0].value,
          noidung: $('#noidung').val(),
          mucphat: $('#mucphat').val().replace(/,/g, ''),
          thoigianphat: $('#thoigianphat').val(),
          thoigiandong: $('#thoigiandong').val(),
        }
        if (!Number(dulieu.mucphat)) dulieu.mucphat = 0
        if (!dulieu.tenchu.length) vhttp.notify('Không được để trống tên chủ hộ')
        else if (!dulieu.dienthoai.length) vhttp.notify('Không được để trống số điện thoại')
        else if (!dulieu.diachi.length) vhttp.notify('Không được để trống địa chỉ')
        else if (!dulieu.mucphat.length) vhttp.notify('Mức phạt phải > 0')
        else if (!kiemtrangaythang(dulieu.thoigianphat)) vhttp.notify('Ngày tháng không hợp lệ')
        else if (!kiemtrangaythang(dulieu.thoigiandong)) vhttp.notify('Ngày tháng không hợp lệ')
        else {
          vhttp.post('/quanly/api/', {
            action: 'themxuphat',
            id: global.id,
            dulieu: dulieu,
            truongloc: thongtintruongloc(global.trang),
          }).then((phanhoi) => {
            $('#danhsach').html(phanhoi.danhsachxuphat)
            $('#modal-themxuphat').modal('hide')
          })
        }
      }

      function keolen() {
        $("html, body").animate({ scrollTop: $("#tiemphong").offset().top }, "slow");
        return false;
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