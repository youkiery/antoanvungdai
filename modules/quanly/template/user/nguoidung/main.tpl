<!-- BEGIN: main -->
<div class="row">
  <div class="col-xs-24 col-sm-6"> {sidemenu} </div>
  <div class="col-xs-24 col-sm-18 pw-content">
    <!-- BEGIN: coquyen -->
    <div id="modal-matkhau" class="modal fade" role="dialog">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title"> Đổi mật khẩu </h4>
          </div>
          <div class="modal-body">
            <div class="form-group input-group">
              <div class="input-group-addon">
                <span class="fa fa-lock"></span>
              </div>
              <input type="password" class="form-control" id="matkhaucu" placeholder="Mật khẩu cũ">
            </div>

            <div class="form-group input-group">
              <div class="input-group-addon">
                <span class="fa fa-lock"></span>
              </div>
              <input type="password" class="form-control" id="matkhaumoi" placeholder="Mật khẩu mới">
            </div>

            <div class="form-group input-group">
              <div class="input-group-addon">
                <span class="fa fa-lock"></span>
              </div>
              <input type="password" class="form-control" id="xacnhanmatkhaumoi" placeholder="Xác nhận mật khẩu mới">
            </div>

            <button class="btn btn-info btn-block" onclick="xacnhandoimatkhau()">
              Đổi mật khẩu
            </button>
          </div>
        </div>
      </div>
    </div>

    <button class="btn btn-info" onclick="doimatkhau()">
      <span class="fa fa-lock"></span>
      Đổi mật khẩu
    </button>

    <script>
      function doimatkhau() {
        $("#matkhaucu").val("")
        $("#matkhaumoi").val("")
        $("#xacnhanmatkhaumoi").val("")
        $("#modal-matkhau").modal("show")
      }

      function xacnhandoimatkhau() {
        var dulieu = {
          matkhaucu: $("#matkhaucu").val(),
          matkhaumoi: $("#matkhaumoi").val(),
          xacnhanmatkhaumoi: $("#xacnhanmatkhaumoi").val(),
        }
        if (!dulieu.matkhaucu.length) vhttp.notify('Không được để trống mật khẩu')
        else if (!dulieu.matkhaumoi.length) vhttp.notify('Không được để trống mật khẩu mới')
        else if (!dulieu.xacnhanmatkhaumoi.length) vhttp.notify('Không được để trống xác nhận mật khẩu')
        else if (dulieu.xacnhanmatkhaumoi !== dulieu.matkhaumoi) vhttp.notify('Mật khẩu xác nhận không trùng nhau')
        else {
          vloading.freeze()

          vhttp.post('/quanly/api/', {
            action: 'doimatkhau',
            dulieu: dulieu
          }).then((phanhoi) => {
            vloading.defreeze()
            $('#modal-matkhau').modal('hide')
          }, () => {
            vloading.defreeze()
          })
        }
      }
    </script>
    <!-- END: coquyen -->
    <!-- BEGIN: khongquyen -->
    Tài khoản không có quyền truy cập
    <!-- END: khongquyen -->
  </div>
</div>
<!-- END: main -->