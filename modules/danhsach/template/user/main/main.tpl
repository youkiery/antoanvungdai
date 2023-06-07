<!-- BEGIN: main -->
<style>
  .inner-addon {
    position: relative;
  }

  .inner-addon .fa {
    position: absolute;
    padding: 10px;
    pointer-events: none;
  }

  .left-addon .fa {
    left: 0px;
  }

  .right-addon .fa {
    right: 0px;
  }

  .left-addon input {
    padding-left: 30px;
  }

  .right-addon input {
    padding-right: 30px;
  }
</style>

<div class="container">
  <div style="text-align: right;">
    <!-- BEGIN: khach -->
    <a href="/users/login/"> Đăng nhập </a> |
    <a href="/users/register/"> Đăng ký </a>
    <!-- END: khach -->
    <!-- BEGIN: nhanvien -->
    <a href="/quanly/"> Quản lý </a> |
    <a href="/users/logout"> Đăng xuất </a>
    <!-- END: khach -->
  </div>
  <div class="banner"> <img class="img-responsive" src="{banner}"> </div>
  <div class="main-search">
    <form onsubmit="return timkiem(event)">
      <div class="inner-addon right-addon">
        <span class="fa fa-search"></span>
        <input type="text" class="form-control" id="tukhoa" style="border-radius: 20px;"
          placeholder="Nhập tên hoặc số microchip" autocomplete="off">
      </div>
    </form>
  </div>
  <div style="clear: both;"></div>
  <div class="text-center"> Tra cứu danh sách thú cưng </div>
  <div id="content" style="margin-top: 20px;">
    {content}
  </div>
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
    })
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
    })
  }
</script>
<!-- END: main -->