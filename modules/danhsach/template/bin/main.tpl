<!-- BEGIN: main -->
<div class="container">
  <div id="msgshow"></div>
  <div style="text-align: right;">
    {FILE "heading.tpl"}
  </div>

  <div class="text-center start-content">
    <img src="/themes/default/images/banner.png">
    <!-- <p> Nâng niu tình yêu động vật </p> -->
    <form action="/{module_file}/list">
      <div class="main-search">
        <label class="input-group">
          <input type="text" class="form-control" name="keyword" id="keyword" placeholder="Nhập tên hoặc mã số"
            autocomplete="off">
          <div class="input-group-btn">
            <button class="btn btn-info"> Tìm kiếm </button>
          </div>
        </label>
        <!-- <div style="font-size: 0.9em;">
            <a href="/contest"> Đăng ký phần thi Lễ hội thú cưng Đăk Lăk 2019 </a>
          </div> -->
        <!-- <a href="/{module_file}/signup"> Đăng ký </a> -->

        <!-- BEGIN: log -->
        <!-- <a href="/{module_file}/login"> Quản lý giống </a> -->
        <!-- END: log -->
        <!-- BEGIN: log_center -->
        <!-- <a href="/{module_file}/login"> Quản lý trại </a> -->
        <!-- END: log_center -->
      </div>
    </form>
  </div>
  <div id="content" style="margin-top: 20px;">
    {content}
  </div>
</div>
<script>
  var content = $("#content")
  var keyword = $("#keyword")
  var thisUrl = '/main'

  // function search() {
  //   request(thisUrl,
  //     {action: 'search', keyword: keyword.val()}).then(data => {
  //       content.data['html']
  //     })
  // }
</script>
<!-- END: main -->