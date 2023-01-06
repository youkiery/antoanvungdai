<!-- BEGIN: main -->
<div class="modal fade" id="modal-xoahoadon" role="dialog">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title"> Xóa hóa đơn </h4>
      </div>
      <div class="modal-body">
        <div class="text-center">
          Hóa đơn sau khi xóa sẽ biến mất
        </div>

        <button class="btn btn-danger btn-block" onclick="xacnhanxoahoadon()">
          Xác nhận
        </button>

      </div>
    </div>
  </div>
</div>

<div id="printable"></div>
<div class="pw-content nonprintable">
  <div class="pw-header">
    Thống kê
  </div>

  <div class="pw-card">
    <div class="pw-card-header">
      <!-- <button class="btn btn-success" onclick="themkhach()"> <span class="fa fa-plus"></span> </button> -->
    </div>
    <div class="row">
      <div class="col-xs-12">
        <input autocomplete="off" type="text" class="date form-control" id="batdau" value="{homnay}">
      </div>
      <div class="col-xs-12">
        <div class="input-group">
          <input autocomplete="off" type="text" class="date form-control" id="ketthuc" value="{homnay}">
          <div class="input-group-btn">
            <button class="btn btn-success" onclick="thongke()"> <span class="fa fa-line-chart"></span> </button>
          </div>
        </div>
      </div>
    </div>

    <div class="form-group">
      <button class="btn btn-info btn-xs" onclick="chonngay(1)"> Hôm nay </button>
      <button class="btn btn-info btn-xs" onclick="chonngay(2)"> Hôm qua </button>
      <button class="btn btn-info btn-xs" onclick="chonngay(3)"> Tuần này </button>
      <button class="btn btn-info btn-xs" onclick="chonngay(4)"> Tuần trước </button>
      <button class="btn btn-info btn-xs" onclick="chonngay(5)"> Tháng này </button>
      <button class="btn btn-info btn-xs" onclick="chonngay(6)"> Tháng trước </button>
      <button class="btn btn-info btn-xs" onclick="chonngay(7)"> Năm nay </button>
      <button class="btn btn-info btn-xs" onclick="chonngay(8)"> Năm ngoái </button>
    </div>

    <div class="pw-card-content" id="content">
      {danhsach}
    </div>
  </div>
</div>

<script>
  $(document).ready(() => {
    $('.date').datepicker({
      dateFormat: 'dd/mm/yy'
    })
  })

  function thongke() {
    vhttp.post('/dashboard/api/', {
      action: 'xemthongke',
      batdau: $('#batdau').val(),
      ketthuc: $('#ketthuc').val()
    }).then((resp) => {
      $('#content').html(resp.html)
    }, (e) => { })
  }

  
  function chonngay(loai) {
    var batdau = $('#batdau')
    var ketthuc = $('#ketthuc')
    var homnay = new Date()
    var cuoithang = new Date(homnay.getFullYear(), homnay.getMonth() + 1, 0);
    
    switch (loai) {
      case 1:
        // hôm nay 
        batdau.val(timetodate(homnay.getTime()))
        ketthuc.val(timetodate(homnay.getTime()))
      break;
      case 2:
        // hôm qua 
        batdau.val(timetodate(homnay.getTime() - 60 * 60 * 24 * 1000))
        ketthuc.val(timetodate(homnay.getTime() - 60 * 60 * 24 * 1000))
      break;
      case 3:
        // tuần này 
        date = homnay.getDay()
        if (date == 0) date = 7
        batdau.val(timetodate(homnay.getTime() - (date - 1) * 60 * 60 * 24 * 1000))
        ketthuc.val(timetodate(homnay.getTime() + (7 - date) * 60 * 60 * 24 * 1000))
      break;
      case 4:
        // tuần trước 
        date = homnay.getDay()
        if (date == 0) date = 7
        batdau.val(timetodate(homnay.getTime() + (1 - date - 7) * 60 * 60 * 24 * 1000))
        ketthuc.val(timetodate(homnay.getTime() - date * 60 * 60 * 24 * 1000))
      break;
      case 5:
        // tháng này
        var cuoithang = new Date(homnay.getFullYear(), homnay.getMonth() + 1, 0);
        batdau.val('01/' + dienso(cuoithang.getMonth() + 1) +'/'+ cuoithang.getFullYear())
        ketthuc.val(cuoithang.getDate() + '/' + dienso(cuoithang.getMonth() + 1) +'/'+ cuoithang.getFullYear()) 
      break;
      case 6:
        // tháng trước
        var cuoithang = new Date(homnay.getFullYear(), homnay.getMonth(), 0);
        batdau.val('01/' + dienso(cuoithang.getMonth() + 1) +'/'+ cuoithang.getFullYear())
        ketthuc.val(cuoithang.getDate() + '/' + dienso(cuoithang.getMonth() + 1) +'/'+ cuoithang.getFullYear()) 
      break;
      case 7:
        // năm này
        var cuoinam = new Date(homnay.getFullYear() + 1, 0, 0);
        batdau.val('01/01/'+ cuoinam.getFullYear())
        ketthuc.val(cuoinam.getDate() +'/'+ (cuoinam.getMonth() + 1) +'/'+ cuoinam.getFullYear())
      break;
      case 8:
        // năm trước
        var cuoinam = new Date(homnay.getFullYear(), 0, 0);
        batdau.val('01/01/'+ cuoinam.getFullYear())
        ketthuc.val(cuoinam.getDate() +'/'+ (cuoinam.getMonth() + 1) +'/'+ cuoinam.getFullYear())
      break;
    }    
  }  
</script>
<!-- END: main -->