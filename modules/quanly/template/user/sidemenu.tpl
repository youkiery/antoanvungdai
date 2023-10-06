<!-- BEGIN: main -->
<div class="pw-side-bar nonprintable">
  <div class="pw-info-panel">
    <div class="pw-banner">
      <a href="/"> <img src="{banner}" alt="banner">   </a>
    </div>
    <div> {nhanvien} </div>
    <div> {chucvu}  </div>
    <!-- BEGIN: thanhvien -->
    <div> <a class="btn btn-info btn-block" href="/quanly/nguoidung" style="margin-bottom: 5px;"> Thông tin người dùng </a> </div>
    <!-- END: thanhvien -->
    <div> <a href="/users/logout" class="btn btn-danger btn-block"> Đăng xuất </a> </div>
  </div>
  <div class="pw-menu-group">
    <div class="pw-menu-header">
      Quản lý
    </div>
    <div class="pw-menu-content">
      <!-- BEGIN: nhanvien -->
      <a href="/quanly/" class="pw-menu-item {main}"> Thông tin chung </a>
      <a href="/quanly/tiemphong" class="pw-menu-item {tiemphong}"> Tiêm phòng</a>
      <a href="/dispatch" class="pw-menu-item {vanban}"> Quản lý văn bản </a>
      <!-- END: nhanvien -->
      <!-- BEGIN: thanhvien2 -->
      <a href="/quanly/vatnuoi" class="pw-menu-item {vatnuoi}"> Vật nuôi</a>
      <!-- END: thanhvien2 -->

      <!-- BEGIN: quanly -->
      <a href="/quanly/danhmuc" class="pw-menu-item {danhmuc}"> Danh mục </a>
      <a href="/quanly/thongke" class="pw-menu-item {thongke}"> Danh sách hộ nuôi </a>
      <a href="/quanly/xuphat" class="pw-menu-item {xuphat}"> Xử phạt </a>
      <a href="/quanly/xetduyet" class="pw-menu-item {xetduyet}"> Xét duyệt nội dung </a>
      <a href="/quanly/thanhvien" class="pw-menu-item {thanhvien}"> Quản lý tài khoản </a>
      <!-- END: quanly -->

    </div>
  </div>
</div>
<!-- END: main -->