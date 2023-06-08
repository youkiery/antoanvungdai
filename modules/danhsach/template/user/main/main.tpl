<!-- BEGIN: main -->
<style>
  .input-border {
    border-radius: 10px;
    position: relative;
    background: white;
    padding: 3px;
    border: 1px solid gray;
  }
  .input-button {
    background-color: white;
    position: absolute;
    right: 5px;
    border: none;
  }
  .input-real {
    background-color: white;
    width: 100%;
    border: none;
  }
</style>

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
    <div class="input-border">
      <button class="input-button" onclick="dentrang(1)"><span class="fa fa-search"></span></button>
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