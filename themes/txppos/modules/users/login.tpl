<!-- BEGIN: main -->
<div class="centered">
  <div class="login-box">
    <div
      class="page panel panel-default margin-top-lg box-shadow<!-- BEGIN: not_redirect --> bg-lavender<!-- END: not_redirect -->">
      <div class="panel-body">
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
</div>
<!-- END: main -->