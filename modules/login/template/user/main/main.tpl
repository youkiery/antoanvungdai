<!-- BEGIN: main -->
<div class="col-xs-2 col-sm-6 col-md-8"> </div>
<div class="col-xs-20 col-sm-12 col-md-8 panel-group">
  <div style="text-align: center;">
    <img src="/assets/images/logo-lg.png" style="max-width: 250px; margin: auto;"></img>
    <ion-text color="secondary">
      <h3> Hệ thống quản lý </h3>
    </ion-text>
  </div>
  <form onsubmit="return login(event)">
    <div class="form-group">
      <div class="input-group">
        <span class="input-group-addon"> <span class="fa fa-user fa-lg"></span> </span>
        <input autocomplete="off" class="form-control" id="username" placeholder="Tài khoản"></ion-input>
      </div>
    </div>
    <div class="form-group">
      <div class="input-group">
        <span class="input-group-addon"> <span class="fa fa-lock fa-lg"></span> </span>
        <input autocomplete="off" class="form-control" type="password" id="password" placeholder="Tài khoản"></ion-input>
      </div>
    </div>
    <div class="text-center">
      <button class="btn btn-info"> Đăng nhập </button>
    </div>
  </form>
</div>

<script>
  function login(e) {
    e.preventDefault()
    vhttp.post('/login/api/', {
      action: 'signin',
      username: $('#username').val(),
      password: $('#password').val(),
    }).then(resp => {
      window.location.reload()
    }, () => {

    })
    return false
  }
</script>
<!-- END: main -->