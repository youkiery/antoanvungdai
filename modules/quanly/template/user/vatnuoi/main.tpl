<!-- BEGIN: main -->
<div class="row">
  <div class="col-xs-24 col-sm-6"> {sidemenu} </div>
  <div class="col-xs-24 col-sm-18 pw-content">
    <!-- BEGIN: coquyen -->
    <style>
      .red { background: pink; }
      .green { background: lightgreen; }
      .orange { background: orange; }
    </style>

    <div id="modal-thongtin" class="modal fade" role="dialog">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title"> Cập nhật thông tin </h4>
          </div>
          <div class="modal-body text-center">
            <div class="form-group row">
              <div class="col-xs-6"> Tên chủ hộ </div>
              <div class="col-xs-18">
                <input type="text" class="form-control" id="thongtin-tenchuho" placeholder="Tên chủ hộ">
              </div>
            </div>
            <div class="form-group row">
              <div class="col-xs-6"> Địa chỉ </div>
              <div class="col-xs-18">
                <input type="text" class="form-control" id="thongtin-diachi" placeholder="Địa chỉ">
              </div>
            </div>

            <div class="form-group row">
              <div class="col-xs-6"> Phường </div>
              <div class="col-xs-18">
                <select class="form-control" id="thongtin-phuong">
                  <option value="0"> --- </option>
                  <!-- BEGIN: phuong -->
                  <option value="{idphuong}"> {tenphuong} </option>
                  <!-- END: phuong -->
                </select>
              </div>
            </div>

            <div class="form-group row">
              <div class="col-xs-6"> Điện thoại </div>
              <div class="col-xs-18">
                <input type="text" class="form-control" id="thongtin-dienthoai" placeholder="Điện thoại">
              </div>
            </div>

            <button class="btn btn-info btn-block" onclick="xacnhancapnhat()">
              Cập nhật
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
      <button class="btn btn-info" onclick="capnhatthongtin()">
        Cập nhật
      </button>
      <button style="float: right;" class="btn btn-success" onclick="themvatnuoi()">
        Thêm vật nuôi
      </button>
    </div>
    <div class="form-group">
      <div> Chủ hộ: {tenchuho} {xetduyettenchuho} </div>
      <div> Địa chỉ: {diachi} {xetduyetdiachi} </div>
      <div> Phường: {tenphuong} {xetduyettenphuong} </div>
      <div> Điện thoại: {dienthoai} {xetduyetdienthoai} </div>
    </div>

    <div class="form-group" id="danhsachvatnuoi">
      {danhsachvatnuoi}
    </div>

    <script>
      let global = {
        trang: 1,
        id: 0,
        idchu: '{idchu}'
      }
      let thongtin = {
        tenchuho: '{tenchuho}',
        diachi: '{diachi}',
        phuong: '{phuong}',
        tenphuong: '{tenphuong}',
        dienthoai: '{dienthoai}',
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

        vremind.install('#thucung', '#goiythucung', (key) => {
          return new Promise(resolve => {
            vhttp.post('/quanly/vatnuoi/', {
              action: 'timkiemthucung',
              idchu: global.idchu,
              tukhoa: key,
            }).then((phanhoi) => {
              resolve(phanhoi.danhsach)
            }, (error) => { })
          })
        }, 300, 300)

        vremind.install('#giongloai', '#goiygiongloai', (key) => {
          return new Promise(resolve => {
            vhttp.post('/quanly/vatnuoi/', {
              action: 'timkiemgiongloai',
              tukhoa: key,
            }).then((phanhoi) => {
              resolve(phanhoi.danhsach)
            }, (error) => { })
          })
        }, 300, 300)
      })

      function themvatnuoi() {
        global.id = 0
        hienthinut()
        $('#thucung').val('')
        $('#tenthucung').val('')
        $('#micro').val('')
        $('#giongloai').val('')
        $('#loai').val('')
        $('#giong').val('')
        $('#ngaysinh').val(global.homnay)
        vimage.clear('hinhanh')
        $('#modal-themtiemphong').modal('show')
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
          id: global.id,
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
          vimage.uploadimage('hinhanh').then(() => {
            dulieu.hinhanh = vimage.data['hinhanh']
            vhttp.post('/quanly/vatnuoi/', {
              action: 'themtiemphong',
              idchu: global.idchu,
              dulieu: dulieu,
            }).then((phanhoi) => {
              window.location.reload()
            }, (error) => { })
          })
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

      function capnhatthongtin() {
        $("#thongtin-tenchuho").val(thongtin.tenchuho)
        $("#thongtin-diachi").val(thongtin.diachi)
        $("#thongtin-phuong").val(thongtin.phuong)
        $("#thongtin-dienthoai").val(thongtin.dienthoai)
        $("#modal-thongtin").modal("show")
      }

      function chitiet(id) {
        vhttp.post('/quanly/vatnuoi/', {
          action: 'laythongtinthucung',
          id: id
        }).then((phanhoi) => {
          global.id = id
          hienthinut()
          $('#thucung').val('')
          $('#tenthucung').val(phanhoi.tenthucung)
          $('#micro').val(phanhoi.micro)
          $('#giongloai').val(phanhoi.giongloai)
          $('#loai').val(phanhoi.loai)
          $('#giong').val(phanhoi.giong)
          $('#ngaysinh').val(phanhoi.ngaysinh)
          vimage.data['hinhanh'] = [phanhoi.hinhanh]
          vimage.reload('hinhanh')
          $('#modal-themtiemphong').modal('show')
        }, (error) => { })
      }

      function xacnhancapnhat() {
        let dulieu = {
          tenchuho: $("#thongtin-tenchuho").val(),
          diachi: $("#thongtin-diachi").val(),
          phuong: $("#thongtin-phuong").val(),
          dienthoai: $("#thongtin-dienthoai").val(),
        }
        if (Number(dulieu.phuong) <= 0) return vhttp.notify("Xin hãy chọn 1 phường")
        vhttp.post('/quanly/vatnuoi/', {
          action: 'capnhatthongtin',
          dulieu: dulieu
        }).then((phanhoi) => {
          setTimeout(() => {
            window.location.reload()
          }, 1000);
        }, (error) => { })
      }

      function dentrang(trang) {
        vhttp.post('/quanly/vatnuoi/', {
          action: 'chuyentrangvatnuoi',
          truongloc: global
        }).then((phanhoi) => {
          $('#danhsachvatnuoi').html(phanhoi.danhsachvatnuoi)
          global.trang = trang
        }, (error) => { })
      }

      function chonthucung(idthucung, tenthucung, micro, giong, loai, tenchu, diachi, dienthoai) {
        global.idthucung = idthucung
        $('#tenthucung').val(tenthucung)
        $('#micro').val(micro)
        $('#giong').val(giong)
        $('#loai').val(loai)
      }

      function chongiongloai(giong, loai) {
        $('#giong').val(giong)
        $('#loai').val(loai)
      }
    </script>
    <!-- END: coquyen -->
    <!-- BEGIN: khongquyen -->
    Tài khoản không có quyền truy cập
    <!-- END: khongquyen -->
  </div>
</div>
<!-- END: main -->