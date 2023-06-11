<!-- BEGIN: main -->
<div class="pw-side-bar nonprintable">
  <div class="pw-info-panel">
    <div class="pw-avatar"> </div>
    {nhanvien} <br>
    Nhân viên 
    <!-- BEGIN: thanhvien -->
    <div> <a href="/quanly/nguoidung"> Thông tin người dùng </a> </div>
    <!-- END: thanhvien -->
    <div> <a href="/dashboard/logout" class="btn btn-danger btn-block"> Đăng xuất </a> </div>
  </div>
  <div class="pw-menu-group">
    <div class="pw-menu-header">
      Quản lý
    </div>
    <div class="pw-menu-content">
      <a href="/quanly/" class="pw-menu-item {main}"> Thông tin chung </a>

      <!-- BEGIN: nhanvien -->
      <a href="/quanly/tiemphong" class="pw-menu-item"> Tiêm phòng</a>
      <a href="/dispatch" class="pw-menu-item active"> Quản lý văn bản </a>
      <!-- END: nhanvien -->


      <!-- BEGIN: quanly -->
      <a href="/quanly/danhmuc" class="pw-menu-item"> Danh mục </a>

      <a href="/quanly/thongke" class="pw-menu-item"> Thống kê </a>

      <a href="/quanly/thanhvien" class="pw-menu-item"> Quản lý nhân viên </a>
      <!-- END: quanly -->

    </div>
  </div>
</div>
<!-- END: main -->