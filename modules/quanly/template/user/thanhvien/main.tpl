<!-- BEGIN: main -->
<div class="row">
  <div class="col-xs-24 col-sm-6"> {sidemenu} </div>
  <div class="col-xs-24 col-sm-18 pw-content">
    <!-- BEGIN: coquyen -->
    <div id="modal-xoakichhoat" class="modal fade" role="dialog">
      <div class="modal-dialog modal-sm">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title"> Vô hiệu hóa thành viên </h4>
          </div>
          <div class="modal-body text-center">
            Thành viên sẽ không thể đăng nhập cho đến khi được kích hoạt trở lại
            <button class="btn btn-warning btn-block" onclick="xacnhanxoakichhoatthanhvien()">
              Vô hiệu hóa
            </button>
          </div>
        </div>
      </div>
    </div>

    <div id="modal-xoathanhvien" class="modal fade" role="dialog">
      <div class="modal-dialog modal-sm">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title"> Xóa thành viên </h4>
          </div>
          <div class="modal-body text-center">
            Xác nhận xóa thành viên này
            <button class="btn btn-danger btn-block" onclick="xacnhanxoathanhvien()">
              Xóa
            </button>
          </div>
        </div>
      </div>
    </div>

    <div id="modal-kichhoatthanhvien" class="modal fade" role="dialog">
      <div class="modal-dialog modal-sm">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title"> Kích hoạt thành viên </h4>
          </div>
          <div class="modal-body text-center">
            Kích hoạt thành viên này
            <button class="btn btn-info btn-block" onclick="xacnhankichhoatthanhvien()">
              Kích hoạt
            </button>
          </div>
        </div>
      </div>
    </div>

    <div id="modal-themthanhvien" class="modal fade" role="dialog">
      <div class="modal-dialog">
        <!-- Modal content-->
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title"> Thêm nhân viên </h4>
          </div>
          <div class="modal-body">
            <div class="form-group row">
              <div class="col-xs-8"> Họ tên </div>
              <div class="col-xs-16"> <input type="text" class="form-control" id="hoten" placeholder="Họ tên"> </div>
            </div>

            <div class="form-group row">
              <div class="col-xs-8"> Email </div>
              <div class="col-xs-16"> <input type="email" class="form-control" id="email" placeholder="Email"> </div>
            </div>

            <div class="form-group row matkhau">
              <div class="col-xs-8"> Tên đăng nhập </div>
              <div class="col-xs-16"> <input type="text" class="form-control" id="tendangnhap"
                  placeholder="Tên đăng nhập">
              </div>
            </div>

            <div class="form-group row matkhau">
              <div class="col-xs-8"> Mật khẩu </div>
              <div class="col-xs-16"> <input type="password" class="form-control" id="matkhau" placeholder="Mật khẩu">
              </div>
            </div>

            <div class="form-group row matkhau">
              <div class="col-xs-8"> Xác nhận mật khẩu </div>
              <div class="col-xs-16"> <input type="password" class="form-control" id="xacnhanmatkhau"
                  placeholder="Xác nhận mật khẩu"> </div>
            </div>

            <div class="form-group row">
              <div class="col-xs-6"> Giới tính </div>
              <div class="col-xs-6"> <label> <input name="gioitinh" type="radio" value="M"> Nam </label> </div>
              <div class="col-xs-6"> <label> <input name="gioitinh" type="radio" value="F"> Nữ </label> </div>
              <div class="col-xs-6"> <label> <input name="gioitinh" type="radio" value="N"> N/A </label> </div>
            </div>

            <div class="form-group row">
              <div class="col-xs-6"> Phân quyền </div>
              <div class="col-xs-6"> <label> <input name="phanquyen" type="radio" value="0" onchange="phanquyen()">
                  Thành
                  viên </label> </div>
              <div class="col-xs-6"> <label> <input name="phanquyen" type="radio" value="1" onchange="phanquyen()"> Nhân
                  viên </label> </div>
              <div class="col-xs-6"> <label> <input name="phanquyen" type="radio" value="2" onchange="phanquyen()"> Quản
                  lý
                </label> </div>
            </div>

            <div class="form-group" id="phuong">
              <div class="input-group">
                <select class="form-control" id="themquyen">
                  <!-- BEGIN: phuong -->
                  <option value="{idphuong}">
                    {tenphuong}
                  </option>
                  <!-- END: phuong -->
                </select>
                <div class="input-group-btn">
                  <button class="btn btn-success" onclick="themquyen()">
                    <span class="fa fa-plus-circle"></span> Thêm
                  </button>
                </div>
              </div>
            </div>

            <div class="form-group" id="quyen"></div>

            <button class="btn btn-success btn-block them" onclick="xacnhanthemthanhvien()">
              Thêm
            </button>
            <button class="btn btn-info btn-block capnhat" onclick="xacnhanthemthanhvien()">
              Cập nhật
            </button>
          </div>
        </div>
      </div>
    </div>

    <div class="form-group">
      <button class="btn btn-success" onclick="themthanhvien()">
        <span class="fa fa-plus-circle"></span> Thêm thành viên
      </button>
    </div>

    <ul class="nav nav-tabs">
      <li class="active"><a data-toggle="tab" href="#thanhvien"> Danh sách thành viên </a></li>
      <li><a data-toggle="tab" href="#xetduyet"> Danh sách cần xét duyệt </a></li>
    </ul>

    <div class="form-group"></div>

    <div class="tab-content">
      <div id="thanhvien" class="tab-pane fade in active">
        {danhsachthanhvien}
      </div>
      <div id="xetduyet" class="tab-pane fade">
        {danhsachxetduyet}
      </div>
    </div>

    <script>
      global = {
        id: 0,
        quyen: [],
      }

      $(document).ready(() => {
        vhttp.alert()
      })

      function hienthinut() {
        if (global.id) {
          $('.matkhau').hide()
          $('.them').hide()
          $('.capnhat').show()
        }
        else {
          $('.matkhau').show()
          $('.capnhat').hide()
          $('.them').show()
        }
      }

      function kiemtraphanquyen() {
        var quyen = $('[name=phanquyen]:checked')
        if (!quyen.length) return quyen = 0
        return quyen[0].value
      }

      function phanquyen() {
        var quyen = kiemtraphanquyen()

        if (quyen == 1) $('#phuong').show()
        else $('#phuong').hide()
        tailaiquyen()
      }

      function themquyen() {
        var themquyen = $('#themquyen option:selected')
        if (themquyen.length) {
          // kiểm tra quyền này đã có chưa, nếu chưa thì thêm
          var dulieutam = {
            id: themquyen[0].value,
            ten: trim(themquyen[0].innerText),
          }
          var kiemtra = true
          global.quyen.forEach(q => {
            if (q.id == dulieutam.id) kiemtra = false
          })
          if (kiemtra) global.quyen.push(dulieutam)
          tailaiquyen()
        }
        else {
          vhttp.notify('Hãy thêm ít nhất 1 quyền')
          // báo chưa chọn quyền
        }
      }

      function tailaiquyen() {
        // nếu là thành viên thì hiển thị chỉ được xem
        // nếu là nhân viên, hiển thị số lượng phường quản lý, danh sách phường
        // nếu là quản lý hiển thị được xem dữ liệu tất cả các phường
        var quyen = kiemtraphanquyen()
        var html = 'Thành viên chỉ được chỉnh sửa dữ liệu bản thân'
        switch (quyen) {
          case '1':
            // đếm số phường từ danh sách global
            // click để xóa phường
            var soluong = global.quyen.length
            var danhsachphuong = []
            global.quyen.forEach((q, i) => {
              danhsachphuong.push(`
          <button class="btn btn-info btn-xs" onclick="xoaphuong(`+ i + `)">
            `+ q.ten + `
          </button>`)
            });
            html = "Nhân viên được quản lý " + soluong + " phường" + (danhsachphuong.length ? '<br>' + danhsachphuong.join(' ') : '')
            break;
          case '2':
            html = 'Quản lý được xem, chỉnh sửa dữ liệu tất cả các phường';
            break;
        }
        $('#quyen').html(html)
      }

      function xoaphuong(tt) {
        global.quyen = global.quyen.filter((q, i) => {
          return tt !== i
        });
        tailaiquyen()
      }

      function themthanhvien() {
        global.id = 0
        global.quyen = []
        $('[name=gioitinh]')[0].checked = true
        $('[name=phanquyen]')[0].checked = true
        $('#hoten').val('')
        $('#email').val('')
        $('#tendangnhap').val('')
        $('#matkhau').val('')
        hienthinut()
        phanquyen()
        tailaiquyen()
        $('#modal-themthanhvien').modal('show')
      }

      function capnhatthanhvien(id) {
        vhttp.post('/quanly/api/', {
          action: 'laythongtinthanhvien',
          id: id,
        }).then((phanhoi) => {
          global.id = id
          global.quyen = phanhoi.quyen
          $('[name=gioitinh][value=' + phanhoi.gioitinh + ']')[0].checked = true
          $('[name=phanquyen][value=' + phanhoi.phanquyen + ']')[0].checked = true
          $('#hoten').val(phanhoi.hoten)
          $('#email').val(phanhoi.email)
          hienthinut()
          phanquyen()
          tailaiquyen()
          $('#modal-themthanhvien').modal('show')
        }, (error) => { })
      }

      function xacnhanthemthanhvien() {
        if (!$('#hoten').val().length) vhttp.notify('Họ tên không được để trống')
        else if (!$('#email').val().length) vhttp.notify('Email không được để trống')
        else if (!global.id && !$('#tendangnhap').val().length) vhttp.notify('Tên đăng nhập không được để trống')
        else if (!global.id && !$('#matkhau').val().length) vhttp.notify('Mật khẩu không được để trống')
        else if (!global.id && $('#matkhau').val() != $('#xacnhanmatkhau').val()) vhttp.notify('Mật khẩu không trùng nhau')
        else {
          var gioitinh = $('[name=gioitinh]:checked')[0].value
          var phanquyen = $('[name=phanquyen]:checked')[0].value
          var quyen = []
          global.quyen.forEach(q => {
            quyen.push(q.id)
          })
          vhttp.post('/quanly/api/', {
            action: 'themthanhvien',
            id: global.id,
            hoten: $('#hoten').val(),
            email: $('#email').val(),
            tendangnhap: $('#tendangnhap').val(),
            matkhau: $('#matkhau').val(),
            gioitinh: gioitinh,
            phanquyen: phanquyen,
            quyen: quyen
          }).then((phanhoi) => {
            $('#modal-themthanhvien').modal('hide')
            $('#thanhvien').html(phanhoi.danhsachthanhvien)
          }, (error) => { })
        }
      }

      function kichhoatthanhvien(id) {
        global.id = id
        $('#modal-kichhoatthanhvien').modal('show')
      }

      function xacnhankichhoatthanhvien() {
        vhttp.post('/quanly/api/', {
          action: 'kichhoatthanhvien',
          id: global.id,
        }).then((phanhoi) => {
          $('#modal-kichhoatthanhvien').modal('hide')
          $('#thanhvien').html(phanhoi.danhsachthanhvien)
          $('#xetduyet').html(phanhoi.danhsachxetduyet)
        }, (error) => { })
      }

      function xoakichhoatthanhvien(id) {
        global.id = id
        $('#modal-xoakichhoat').modal('show')
      }

      function xacnhanxoakichhoatthanhvien() {
        vhttp.post('/quanly/api/', {
          action: 'xoakichhoatthanhvien',
          id: global.id,
        }).then((phanhoi) => {
          $('#modal-xoakichhoat').modal('hide')
          $('#thanhvien').html(phanhoi.danhsachthanhvien)
          $('#xetduyet').html(phanhoi.danhsachxetduyet)
        }, (error) => { })
      }

      function xoathanhvien(id) {
        global.id = id
        $('#modal-xoathanhvien').modal('show')
      }

      function xacnhanxoathanhvien() {
        vhttp.post('/quanly/api/', {
          action: 'xoathanhvien',
          id: global.id,
        }).then((phanhoi) => {
          $('#modal-xoathanhvien').modal('hide')
          $('#xetduyet').html(phanhoi.danhsachxetduyet)
        }, (error) => { })
      }
    </script>
    <!-- END: coquyen -->
    <!-- BEGIN: khongquyen -->
    Tài khoản không có quyền truy cập
    <!-- END: khongquyen -->
  </div>
</div>
<!-- END: main -->