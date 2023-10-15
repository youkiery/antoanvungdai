<!-- BEGIN: main  -->
<div id="modal-them-phuong" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <b class="modal-title"> Thêm phường </b>
      </div>
      <div class="modal-body">
        <div class="row form-group">
          <div class="col-xs-6"> Tên phường </div>
          <div class="col-xs-18"> 
            <input type="text" class="form-control" id="ten-phuong">  
          </div>
        </div>
        
        <button class="btn btn-success" onclick="xacnhanthemphuong()">
          Thêm phường
        </button>
      </div>
    </div>
  </div>
</div>

<div class="form-group">
  <button class="btn btn-success" onclick="modalthemphuong()">
    <span class="fa fa-plus"></span> Thêm phường
  </button>
</div>

<div id="noidung">
  {noidung}
</div>

<script>
  $(document).ready(() => {
    vhttp.alert()
  })

  function modalthemphuong() {
    $('#ten-phuong').val('')
    $('#modal-them-phuong').modal('show')
  }

  function xacnhanthemphuong() {
    var tenphuong = $('#ten-phuong').val()
    if (!tenphuong.length) {
      vhttp.notify('Không được để trống tên phường')
      return 0
    }
    vhttp.post('/admin/index.php?language=vi&nv=danhsach&op=api', {
      action: 'themphuong',
      tenphuong: $('#ten-phuong').val()
    }).then((phanhoi) => {
      $('#noidung').html(phanhoi.danhsach)
      $('#modal-them-phuong').modal('hide')
    }, (error) => { })
  }
</script>
<!-- END: main  -->