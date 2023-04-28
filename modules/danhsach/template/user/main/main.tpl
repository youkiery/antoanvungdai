<!-- BEGIN: main -->
<div class="container">
  <div class="banner"> <img class="img-responsive" src="{banner}"> </div>
  <div class="main-search">
    <a href="/danhsach/dangnhap" style="float: right;"> Đăng nhập </a>
    <label style="clear: both" class="input-group">
      <input type="text" class="form-control" id="tukhoa" placeholder="Nhập tên hoặc mã số" autocomplete="off">
      <div class="input-group-btn">
        <button class="btn btn-info" onclick="dentrang(1)"> Tìm kiếm </button>
      </div>
    </label>
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