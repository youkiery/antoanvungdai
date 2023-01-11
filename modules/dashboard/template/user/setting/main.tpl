<!-- BEGIN: main -->
<style>
  .cke_notifications_area {
    display: none;
  }

  .pw-toggle {
    padding-left: 3px;
  }

  .pw-toggle-body {
    padding-left: 15px;
    display: none;
  }

  .pw-toggle .pw-toggle-head::before {
    content: "+";
  }

  .pw-toggle-body .child {
    margin-left: 15px;
  }
</style>

<div id="printable"></div>
<div class="pw-content nonprintable">
  <div class="modal fade" id="modal-them-nhan-vien" role="dialog">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title"> Thêm nhân viên </h4>
        </div>
        <div class="modal-body">
          <div class="form-group row">
            <div class="col-xs-8"> Tài khoản (*) </div>
            <div class="col-xs-16"> <input type="text" class="form-control" id="taikhoan"> </div>
          </div>
          <div class="form-group row">
            <div class="col-xs-8"> Mật khẩu (*) </div>
            <div class="col-xs-16"> <input type="password" class="form-control" id="matkhau"> </div>
          </div>
          <div class="form-group row">
            <div class="col-xs-8"> Xác nhận mật khẩu (*) </div>
            <div class="col-xs-16"> <input type="password" class="form-control" id="xacnhanmatkhau"> </div>
          </div>
          <div class="form-group row">
            <div class="col-xs-8"> Họ và tên (*) </div>
            <div class="col-xs-16"> <input type="text" class="form-control" id="hoten"> </div>
          </div>
          <div class="form-group row">
            <div class="col-xs-8"> Email </div>
            <div class="col-xs-16"> <input type="text" class="form-control" id="email"> </div>
          </div>
          <div class="form-group row">
            <div class="col-xs-8"> Sinh nhật </div>
            <div class="col-xs-16"> <input type="text" class="date form-control" id="sinhnhat"> </div>
          </div>
          <div class="form-group">
            <button class="btn btn-success btn-block" onclick="xacnhanthemnhanvien()">
              Thêm nhân viên
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- BEGIN: nhanvien -->
  <div class="pw-card">
    <div class="pw-header">
      Phân quyền
    </div>
    <div style="float: right;">
      <!-- BEGIN: them -->
      <button class="btn btn-success" onclick="themnhanvien()">
        <span class="fa fa-plus"></span>
        Thêm nhân viên
      </button>
      <!-- END: them -->
      <!-- BEGIN: export -->
      <button class="btn btn-info">
        <span class="fa fa-file"></span>
        Export
      </button>
      <!-- END: export -->
    </div>

    <div class="form-group" style="clear: both;"></div>

    <div id="danhsach">
      {danhsach}
    </div>
  </div>
  <!-- END: nhanvien -->

  <!-- BEGIN: mauin -->
  <div class="pw-card">
    <div class="pw-header">
      Cấu hình hóa đơn
    </div>

    <!-- BEGIN: sua -->
    <div class="form-group">
      <button class="btn btn-info" onclick="inthu()">
        <span class="fa fa-print"></span> In thử
      </button>
      <button class="btn btn-info" onclick="luumau()">
        <span class="fa fa-floppy-o"></span> Lưu mẫu
      </button>
    </div>
    <div id="chantrang"></div>

    <div class="form-group"></div>
    <!-- END: sua -->

    <div class="pw-card">
      <div class="pw-header">
        Mẫu in
      </div>
      {mauin}
    </div>
  </div>
  <!-- END: mauin -->
</div>

<script src="/assets/editors/ckeditor/ckeditor.js"></script>
<script>
  window.confirm = function () { };
  var global = {
    homnay: '{homnay}',
    filter: {
      page: 1,
      hoadon: '',
      hanghoa: '',
      khachhang: '',
      thoigiandau: '',
      thoigiancuoi: '',
      nguoiban: '',
      nguoiratoa: '',
      ghichu: '',
    }
  }

  $(document).ready(() => {
    $('.date').datepicker({
      dateFormat: 'dd/mm/yy'
    })

    CKEDITOR.replace('chantrang', {
      width: '100%', height: '200px', contentsCss: '/assets/editors/ckeditor/nv.css?t=3', filebrowserUploadUrl: '/admin/index.php?nv=upload&op=upload&editor=ckeditor&path=uploads/news/2022_12', filebrowserImageUploadUrl: '/admin/index.php?nv=upload&op=upload&editor=ckeditor&path=uploads/news/2022_12&type=image', filebrowserFlashUploadUrl: '/admin/index.php?nv=upload&op=upload&editor=ckeditor&path=uploads/news/2022_12&type=flash', filebrowserBrowseUrl: '/admin/index.php?nv=upload&popup=1&path=uploads/news&currentpath=uploads/news/2022_12',
      filebrowserImageBrowseUrl: '/admin/index.php?nv=upload&popup=1&type=image&path=uploads/news&currentpath=uploads/news/2022_12',
      filebrowserFlashBrowseUrl: '/admin/index.php?nv=upload&popup=1&type=flash&path=uploads/news&currentpath=uploads/news/2022_12'
    })

    $('#cauhinhoadon').show()
  })

  function chitiet(id) {
    var load = $('#' + id)
    if (load.attr('load') == '0') {
      vhttp.post('/dashboard/api/', {
        action: 'chitietnhanvien',
        id: id
      }).then((resp) => {
        load.attr('load', '1')
        $('#td-' + id).html(resp.html)
        caidattoggle() 
      }, (e) => { })
    }
    if (load.css('display') == 'none') {
      $('.chitiet:visible').hide().delay(200)
      load.fadeToggle()
    }
    else load.fadeToggle()
  }

  function caidattoggle() {
    $('.pw-toggle .pw-toggle-head').click(e => {
      element = e.currentTarget.parentElement.children[1]
      if (element.style.display == 'block' && e.target.tagName !== 'INPUT') element.style.display = 'none'
      else element.style.display = 'block'
    })
  }

  function thaydoi(id, name, level) {
    var val = $('[name='+ name +'][ref='+id+']').prop('checked')
    $('[ref='+ id +'][l'+ level +'='+ name +']').prop('checked', val)
  }

  function luuphanquyen(id) {
    dulieu = {}
    $('[ref='+id+']').each((index, item) => {
      dulieu[item.getAttribute('name')] = Number(item.checked)
    })
    vhttp.post('/dashboard/api/', {
      action: 'luuphanquyen',
      id: id,
      dulieu: dulieu
    }).then((resp) => {
      // $('#modal-cau-hinh').modal('show')
    }, (e) => { })
  }

  function cauhinhhoadon() {
    vhttp.post('/dashboard/api/', {
      action: 'taimauhoadon',
    }).then((resp) => {
      CKEDITOR.instances.chantrang.setData(resp.html)
      $('#modal-cau-hinh').modal('show')
    }, (e) => { })
  }

  function inthu() {
    var noidung = CKEDITOR.instances.chantrang.getData()
    $("#printable").html(noidung)
    window.print()
  }

  function luumau() {
    vhttp.post('/dashboard/api/', {
      action: 'luumauhoadon',
      mauin: CKEDITOR.instances.chantrang.getData()
    }).then((resp) => {
      // do notthing but notify by vhttp
    }, (e) => { })
  }

  function themnhanvien() {
    $('#taikhoan').val('')
    $('#matkhau').val('')
    $('#xacnhanmatkhau').val('')
    $('#hoten').val('')
    $('#email').val('')
    $('#sinhnhat').val(global.homnay)
    $('#modal-them-nhan-vien').modal('show')
  }

  function xacnhanthemnhanvien() {
    dulieu = {
      taikhoan: $('#taikhoan').val(),
      matkhau: $('#matkhau').val(),
      xacnhanmatkhau: $('#xacnhanmatkhau').val(),
      hoten: $('#hoten').val(),
      email: $('#email').val(),
      sinhnhat: $('#sinhnhat').val()
    }
    if (!dulieu.taikhoan.length) vhttp.notify('Hãy nhập tên tài khoản')
    else if (!dulieu.matkhau.length) vhttp.notify('Hãy nhập mật khẩu')
    else if (dulieu.matkhau != dulieu.xacnhanmatkhau) vhttp.notify('Mật khẩu xác nhận không trùng nhau')
    else if (!dulieu.hoten.length) vhttp.notify('Hãy nhập họ tên nhân viên')
    else vhttp.post('/dashboard/api/', {
      action: 'themnhanvien',
      dulieu: dulieu
    }).then((resp) => {
      $('#danhsach').html(resp.danhsach)
      $('#modal-them-nhan-vien').modal('hide')
    }, (e) => { })
  }
</script>
<!-- END: main -->