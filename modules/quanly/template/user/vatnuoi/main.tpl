<!-- BEGIN: main -->
<div class="row">
  <div class="col-xs-24 col-sm-6"> {sidemenu} </div>
  <div class="col-xs-24 col-sm-18 pw-content">
    <!-- BEGIN: coquyen -->
    <div class="form-group">
      <button class="capnhatthongtin()">
        Cập nhật
      </button>
      <div> Địa chỉ: {diachi} </div>
      <div> Phường: {phuong} </div>
      <div> Điện thoại: {dienthoai} </div>
    </div>

    <div class="form-group">
      {danhsachvatnuoi}
    </div>

    <script>
      let thongtin = {
        diachi: '{diachi}',
        idphuong: '{idphuong}',
        phuong: '{phuong}',
        dienthoai: '{dienthoai}',
      }

      function capnhatthongtin() {
      }
    </script>
    <!-- END: coquyen -->
    <!-- BEGIN: khongquyen -->
    Tài khoản không có quyền truy cập
    <!-- END: khongquyen -->
  </div>
</div>
<!-- END: main -->