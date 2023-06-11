<!-- BEGIN: main -->
<div class="row centered margin-top-lg margin-bottom-lg">
  <div class="login-box">
    <div class="panel-body">
      <div class="pw-banner">
        <a href="/"> <img src="{banner}" alt="banner"> </a>
      </div>

      <!-- BEGIN: redirect2 -->
      <div class="text-center margin-bottom-lg">
        <a title="{SITE_NAME}" href="{THEME_SITE_HREF}"><img class="logo" src="{LOGO_SRC}" alt="{SITE_NAME}"></a>
      </div>
      <!-- END: redirect2 -->
      <h2 class="text-center margin-bottom-lg">{LANG.login}</h2>
      {FILE "login_form.tpl"}
      <div class="text-center margin-top-lg" id="other_form">
        <a href="/" class="margin-right-lg">
          <em class="fa fa-caret-right margin-right-sm"></em>Trang chủ
        </a>
        <a href="/users/register" class="margin-right-lg">
          <em class="fa fa-caret-right margin-right-sm"></em>Đăng ký
        </a>
      </div>
    </div>
  </div>
</div>
<!-- END: main -->