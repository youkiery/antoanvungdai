<!-- BEGIN: main -->
<div class="btn-toolbar" role="toolbar" style="margin-right: 10px; float:left;">
  <div class="btn-group">
    <!-- BEGIN: row -->
      <button type="button" class="btn {active}" {chucnang}> {trang} </button>
    <!-- END: row -->
  </div>
</div>

<div class="input-group" style="float:left; width: 130px;">
  <input type="number" value="{hientai}" class="form-control" placeholder="đến trang" id="dentrang" style="width: 100px">
  <div class="input-group-btn">
    <button class="btn btn-default" onclick="chuyendentrang()"> Đi! </button>
  </div>
</div>

<script>
  function chuyendentrang() {
    {func}
  }
</script>
<!-- END: main -->