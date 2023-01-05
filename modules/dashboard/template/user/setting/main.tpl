<!-- BEGIN: main -->
<style>
  .cke_notifications_area {
    display: none;
  }
</style>

<div id="printable"></div>
<div class="pw-content nonprintable">
  <div class="modal fade" id="modal-cau-hinh" role="dialog">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title"> Cấu hình hóa đơn </h4>
        </div>
        <div class="modal-body">
          <div class="form-group">
            <button class="btn btn-info" onclick="inthu()">
              <span class="fa fa-print"></span> In thử
            </button>
            <button class="btn btn-info" onclick="luumau()">
              <span class="fa fa-floppy-o"></span> Lưu mẫu
            </button>
          </div>
          <div id="chantrang"></div>
        </div>
      </div>
    </div>
  </div>

  <div class="pw-header">
    Cài đặt
  </div>

  <div class="pw-card">
    <button class="btn btn-info" id="cauhinhoadon" onclick="cauhinhhoadon()" style="display: none;">
      Cấu hình hóa đơn
    </button>
    <div style="float: right;">
      <button class="btn btn-success" onclick="themnhanvien()">
        <span class="fa fa-plus"></span>
        Thêm nhân viên
      </button>
    </div>

    <div class="form-group" style="clear: both;"></div>

    <table class="table table-bordered">
      <tr>
        <th colspan="5" class="text-center"> Danh sách nhân viên </th>
      </tr>
      <tr>
        <th> STT </th>
        <th> Nhân viên </th>
        <th> Tài khoản </th>
        <th> Chức vụ </th>
        <th> </th>
      </tr>
    </table>
  </div>
</div>

<script src="/assets/editors/ckeditor/ckeditor.js"></script>
<script>
  window.confirm = function () { };
  var global = {
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

  }
</script>
<!-- END: main -->