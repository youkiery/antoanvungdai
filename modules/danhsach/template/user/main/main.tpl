<!-- BEGIN: main -->
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

<div style="text-align: right; margin: 10px;">
  <!-- BEGIN: khach -->
  <a class="btn btn-info" href="/users/login/"> Đăng nhập </a>
  <a class="btn btn-success" href="/users/register/"> Đăng ký </a>
  <!-- END: khach -->
  <!-- BEGIN: nhanvien -->
  <a class="btn btn-info" href="/quanly/"> Quản lý </a>
  <a class="btn btn-warning" href="/users/logout"> Đăng xuất </a>
  <!-- END: khach -->
</div>
<div class="banner"> <img class="img-responsive" src="{banner}"> </div>
<div class="main-search">
  <form onsubmit="return timkiem(event)">
    <div class="input-border">
      <button class="input-button"><span class="fa fa-search"></span></button>
      <input type="text" class="input-real" id="tukhoa" placeholder="Nhập tên hoặc số microchip" autocomplete="off">
    </div>
  </form>
</div>
<div style="clear: both;"></div>
<div class="text-center"> Tra cứu danh sách thú cưng </div>
<div class="row" id="content" style="margin-top: 20px;">
  {content}
</div>
<script>
  var global = {
    trang: 1
  }

  function timkiem(event) {
    event.preventDefault()
    vhttp.post('/danhsach/api/', {
      action: 'timkiem',
      trang: 1,
      tukhoa: $('#tukhoa').val()
    }).then((resp) => {
      $('#content').html(resp.danhsach)
      global.trang = 1
      keolen()
    }, (error) => { })
    return false;
  }

  function dentrang(trang) {
    vhttp.post('/danhsach/api/', {
      action: 'timkiem',
      trang: trang,
      tukhoa: $('#tukhoa').val()
    }).then((resp) => {
      $('#content').html(resp.danhsach)
      global.trang = trang
      keolen()
    }, (error) => { })
  }

  function chitiet(id) {
    vhttp.post('/danhsach/api/', {
      action: 'laychitiet',
      id: id,
    }).then((resp) => {
      $('#chitiet').html(resp.chitiet)
      $('#modal-chitiet').modal('show')
    }, (error) => { })
  }

  function keolen() {
    $("html, body").animate({ scrollTop: $("#content").offset().top }, "slow");
    return false;
  }
</script>
<!-- END: main -->