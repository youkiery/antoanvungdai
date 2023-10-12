<!-- BEGIN: main -->
<div class="row">
  <div class="col-xs-24 col-sm-6"> {sidemenu} </div>
  <div class="col-xs-24 col-sm-18 pw-content">
    <!-- BEGIN: coquyen -->
    <div class="form-group" id="danhsachxetduyet">
      {danhsachxetduyet}
    </div>

    <script>
      global = {
        trang: 1
      }

      function laytruongloc(trang = 1) {
        if (trang) global.trang = trang
        return global
      }

      function dentrang(trang) {
        vhttp.post('/quanly/api/', {
          action: 'chuyentrangxetduyet',
          truongloc: laytruongloc(trang)
        }).then((resp) => {
          global.trang = trang
          $('#danhsachxetduyet').html(resp.danhsachduyet)
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