<!-- BEGIN: main -->
<div class="row">
  <div class="col-xs-24 col-sm-6"> {sidemenu} </div>
  <div class="col-xs-24 col-sm-18 pw-content">
    <!-- BEGIN: coquyen -->
    <div id="modal-xoatiemphong" class="modal fade" role="dialog">
      <div class="modal-dialog modal-sm">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title"> Xóa tiêm phòng </h4>
          </div>
          <div class="modal-body text-center">
            Xác nhận xóa mũi tiêm phòng này
            <button class="btn btn-danger btn-block" onclick="xacnhanxoatiemphong()">
              Xóa
            </button>
          </div>
        </div>
      </div>
    </div>


    <div class="modal fade" id="modal-import" role="dialog">
      <div class="modal-dialog ">
        <div class="modal-content">
          <div class="modal-header">
            Import tiêm phòng
            <button type="button" class="close" data-dismiss="modal">&times;</button>
          </div>

          <div class="modal-body">
            <div id="loi-import" style="color: red; font-weight: bold"></div>
            <div class="text-center" id="mau-import">
              <button class="btn btn-info" onclick="download('purchase')"> <span class="fa fa-download"></span>
                Tải về tệp mẫu
              </button>
              <input type="file" id="import-file" onchange="chonfile()"
                accept=".csv, application/vnd.openxmlformats-officedocument.spreadsheetml.sheet, application/vnd.ms-excel">
              <button class="btn btn-info btn-block" id="import-btn" onclick="xacnhanimport()">
                Import
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div id="modal-timkiem" class="modal fade" role="dialog">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title"> Tìm kiếm tiêm phòng </h4>
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
              <div class="col-xs-6"> Thời gian tiêm </div>
              <div class="col-xs-9">
                <input type="text" class="form-control date" id="timkiem-batdau" placeholder="Từ ngày">
              </div>
              <div class="col-xs-9">
                <input type="text" class="form-control date" id="timkiem-ketthuc" placeholder="Đến ngày">
              </div>
            </div>

            <button class="btn btn-info btn-block" onclick="dentrang(1)">
              Tìm kiếm
            </button>
          </div>
        </div>
      </div>
    </div>

    <div id="modal-themtiemphong" class="modal fade" role="dialog">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title"> Thêm tiêm phòng </h4>
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

            <div class="form-group"> Thời gian tiêm phòng (nếu không chọn thú cưng sẽ được thêm nhưng không có trong danh sách) </div>
            <div class="form-group">
              <input type="text" class="form-control date" id="thoigiantiem">
            </div>

            <div class="row">
              <div class="col-sm-6"> Hình ảnh </div>
              <div class="col-sm-18" id="hinhanh"> </div>
            </div>

            <button class="btn btn-success btn-block them" onclick="xacnhanthemtiemphong()">
              Thêm
            </button>
            <button class="btn btn-info btn-block capnhat" onclick="xacnhanthemtiemphong()">
              Cập nhật
            </button>
          </div>
        </div>
      </div>
    </div>

    <div class="form-group">
      <button class="btn btn-success" onclick="themtiemphong()">
        <span class="fa fa-plus-circle"></span> Thêm tiêm phòng
      </button>
      <button class="btn btn-info" onclick="timkiem()">
        <span class="fa fa-search"></span> Tìm kiếm
      </button>
      <button class="btn btn-info" onclick="importtiemphong()">
        <span class="fa fa-file"></span> Import
      </button>
    </div>

    <div id="tiemphong" class="tab-pane fade in active">
      {danhsachtiemphong}
    </div>

    <script>
      var global = {
        id: 0,
        idchu: 0,
        idthucung: 0,
        homnay: '{homnay}',
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
        vhttp.alert()
        $('.date').datepicker({
          dateFormat: 'dd/mm/yy'
        })

        firebase.initializeApp(config);
        vimage.path = '/vungdai/images'
        vimage.install('hinhanh')

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

        vremind.install('#thucung', '#goiythucung', (key) => {
          return new Promise(resolve => {
            vhttp.post('/quanly/api/', {
              action: 'timkiemthucung',
              idchu: global.idchu,
              tukhoa: key,
            }).then((phanhoi) => {
              resolve(phanhoi.danhsach)
            })
          })
        }, 300, 300)

        vremind.install('#giongloai', '#goiygiongloai', (key) => {
          return new Promise(resolve => {
            vhttp.post('/quanly/api/', {
              action: 'timkiemgiongloai',
              tukhoa: key,
            }).then((phanhoi) => {
              resolve(phanhoi.danhsach)
            })
          })
        }, 300, 300)
      })

      function timkiem() {
        $('#modal-timkiem').modal('show')
      }

      function importtiemphong() {
        $('#modal-import').modal('show')
      }

      function download(filename) {
        window.location = '/assets/excel/MauImportVaccine.xlsx';
      }

      function xacnhanimport() {
        // kiểm tra nếu chưa có file thì thông báo
        if (!$('#import-file')[0].files.length) vhttp.notify('Chọn file trước khi thêm')
        else {
          var form = new FormData()
          form.append('file', $('#import-file')[0].files[0]);
          form.append('action', 'importtiemphong');
          $.ajax({
            url: '/quanly/api/',
            type: 'post',
            data: form,
            processData: false,
            contentType: false
          }).done((x) => {
            try {
              var json = JSON.parse(x)
              if (json.messenger && json.messenger.length) vhttp.notify(json.messenger)
              if (json.loi && json.loi.length) {
                $('#loi-import').html(json.loi)
                $('#loi-import').show()
                return 0
              }
              if (json.status) {
                setTimeout(() => {
                  window.location.reload()
                }, 1000);
              }
            }
            catch (error) { }
          }).fail(() => { });
        }
      }

      function chonfile() {
        var file = $('#import-file').val()
        $('#loi-import').hide()
        if (file) $('#import-btn').show()
        else $('#import-btn').hide()
      }

      function dentrang(trang) {
        vhttp.post('/quanly/api/', {
          action: 'chuyentrangtiemphong',
          truongloc: thongtintruongloc(trang),
        }).then((resp) => {
          $('#tiemphong').html(resp.danhsachtiemphong)
          $('#modal-timkiem').modal('hide')
          keolen()
          global.trang = trang
        })
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
          'batdau': $('#timkiem-batdau').val(),
          'ketthuc': $('#timkiem-ketthuc').val(),
          'trang': trang,
        }
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

      function chonchuho(idchu, ten, diachi, dienthoai, idphuong) {
        global.idchu = idchu
        $('#tenchu').val(ten)
        $('#diachi').val(diachi)
        $('#dienthoai').val(dienthoai)
        $('#phuong option[value=' + idphuong + ']')[0].selected = true
      }

      function chonthucung(idthucung, tenthucung, micro, giong, loai, tenchu, diachi, dienthoai) {
        global.idthucung = idthucung
        $('#tenthucung').val(tenthucung)
        $('#micro').val(micro)
        $('#giong').val(giong)
        $('#loai').val(loai)
        $('#tenchu').val(tenchu)
        $('#diachi').val(diachi)
        $('#dienthoai').val(dienthoai)
      }

      function chongiongloai(giong, loai) {
        $('#giong').val(giong)
        $('#loai').val(loai)
      }

      function xoatiemphong(id) {
        global.id = id
        $('#modal-xoatiemphong').modal('show')
      }

      function xacnhanxoatiemphong() {
        vhttp.post('/quanly/api/', {
          action: 'xoatiemphong',
          id: global.id,
          truongloc: thongtintruongloc(global.trang),
        }).then((phanhoi) => {
          $('#tiemphong').html(phanhoi.danhsachtiemphong)
          $('#modal-xoatiemphong').modal('hide')
        })
      }

      function themtiemphong() {
        global.id = 0
        hienthinut()
        $('#chuho').val('')
        $('#tenchu').val('')
        $('#dienthoai').val('')
        $('#diachi').val('')
        $('#thucung').val('')
        $('#tenthucung').val('')
        $('#micro').val('')
        $('#giongloai').val('')
        $('#loai').val('')
        $('#giong').val('')
        $('#ngaysinh').val(global.homnay)
        $('#thoigiantiem').val('')
        vimage.clear('hinhanh')
        $('#modal-themtiemphong').modal('show')
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
          $('#modal-themtiemphong').modal('show')
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
          tenthucung: $('#tenthucung').val(),
          micro: $('#micro').val(),
          loai: $('#loai').val(),
          giong: $('#giong').val(),
          ngaysinh: $('#ngaysinh').val(),
          thoigiantiem: $('#thoigiantiem').val(),
        }
        if (!dulieu.tenchu.length) vhttp.notify('Không được để trống tên chủ hộ')
        else if (!dulieu.dienthoai.length) vhttp.notify('Không được để trống số điện thoại')
        else if (!dulieu.diachi.length) vhttp.notify('Không được để trống địa chỉ')
        else if (!dulieu.tenthucung.length) vhttp.notify('Không được để trống tên thú cưng')
        else if (!dulieu.micro.length) vhttp.notify('Không được để trống số Microchip')
        else if (!dulieu.giong.length) vhttp.notify('Không được để trống tên giống')
        else if (!dulieu.loai.length) vhttp.notify('Không được để trống tên loài')
        else if (dulieu.thoigiantiem.length && !kiemtrangaythang(dulieu.thoigiantiem)) vhttp.notify('Ngày tháng không hợp lệ')
        else if (!kiemtrangaythang(dulieu.ngaysinh)) vhttp.notify('Ngày sinh không hợp lệ')
        else {
          vimage.uploadimage('hinhanh').then(() => {
            dulieu.hinhanh = vimage.data['hinhanh']
            vhttp.post('/quanly/api/', {
              action: 'themtiemphong',
              id: global.id,
              dulieu: dulieu,
              truongloc: thongtintruongloc(global.trang),
            }).then((phanhoi) => {
              $('#tiemphong').html(phanhoi.danhsachtiemphong)
              $('#modal-themtiemphong').modal('hide')
            })
          })
        }
      }
      
      function keolen() {
        $("html, body").animate({ scrollTop: $("#tiemphong").offset().top }, "slow");
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