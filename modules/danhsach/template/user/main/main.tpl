<!-- BEGIN: main -->
<div class="container">
  <div class="banner"> <img class="img-responsive" src="{banner}"> </div>
  <div class="main-search">
    <label style="clear: both" class="input-group">
      <input type="text" class="form-control" id="tukhoa" placeholder="Nhập tên hoặc mã số" autocomplete="off">
      <div class="input-group-btn">
        <button class="btn btn-info" onclick="dentrang(1)"> Tìm kiếm </button>
      </div>
    </label>
    <div class="text-center">
      <!-- BEGIN: khach -->
      <a href="/users/login/"> Đăng nhập </a> | 
      <a href="/users/register/"> Đăng ký </a>
      <!-- END: khach -->
      <!-- BEGIN: nhanvien -->
      <a href="/quanly/"> Quản lý </a>
      <!-- END: khach -->
    </div>
  </div>
  <div style="clear: both;"></div>
  <div id="content" style="margin-top: 20px;">
    {content}
  </div>
</div>
<script>
  var global = {
    trang: 1
  }

  function dentrang(trang) {
    vhttp.post('/danhsach/api/', {
      action: 'timkiem',
      trang: trang,
      tukhoa: $('#tukhoa').val()
    }).then((resp) => {
      $('#content').html(resp.danhsach)
      global.trang = trang
    }, () => {

    })
  }
</script>
<!-- END: main -->