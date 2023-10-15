<!-- BEGIN: main -->
<div class="row">
  <div class="col-xs-24 col-sm-6"> {sidemenu} </div>
  <div class="col-xs-24 col-sm-18 pw-content">
    <!-- BEGIN: coquyen -->
    <div id="modal-xacnhan" class="modal fade" role="dialog">
      <div class="modal-dialog modal-sm">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title"> Xác nhận thông tin </h4>
          </div>
          <div class="modal-body text-center">
            <button class="btn btn-info btn-block" onclick="xacnhan()">
              Xác nhận xét duyệt
            </button>
          </div>
        </div>
      </div>
    </div>

    <div id="modal-huy" class="modal fade" role="dialog">
      <div class="modal-dialog modal-sm">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title"> Huỷ thông tin </h4>
          </div>
          <div class="modal-body text-center">
            <button class="btn btn-info btn-block" onclick="huy()">
              Huỷ xét duyệt
            </button>
          </div>
        </div>
      </div>
    </div>

    <div class="form-group" id="danhsachxetduyet">
      {danhsachxetduyet}
    </div>

    <script>
      global = {
        id: 0,
        trang: 1
      }

      function laytruongloc(trang = 0) {
        if (trang < 0) global.trang = 1
        else if (trang) global.trang = trang
        return global
      }

      function xacnhanxetduyet(id) {
        global.id = id
        $("#modal-xacnhan").modal("show")
      }
      function huyxetduyet(id) {
        global.id = id
        $("#modal-huy").modal("show")
      }

      function xacnhan() {
        vhttp.post('/quanly/api/', {
          action: 'xacnhanxetduyet',
          id: global.id,
          truongloc: laytruongloc()
        }).then((phanhoi) => {
          $('#danhsachxetduyet').html(phanhoi.danhsachduyet)
          $("#modal-xacnhan").modal("hide")
        }, (error) => { })
      }

      function huy() {
        vhttp.post('/quanly/api/', {
          action: 'huyxetduyet',
          id: global.id,
          truongloc: laytruongloc()
        }).then((phanhoi) => {
          $('#danhsachxetduyet').html(phanhoi.danhsachduyet)
          $("#modal-xacnhan").modal("hide")
        }, (error) => { })
      }

      function dentrang(trang) {
        vhttp.post('/quanly/api/', {
          action: 'chuyentrangxetduyet',
          truongloc: laytruongloc(trang)
        }).then((phanhoi) => {
          global.trang = trang
          $('#danhsachxetduyet').html(phanhoi.danhsachduyet)
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