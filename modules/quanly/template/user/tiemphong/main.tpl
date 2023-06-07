<!-- BEGIN: main -->
<div id="modal-xoaphuong" class="modal fade" role="dialog">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title"> Xóa phường </h4>
      </div>
      <div class="modal-body text-center">
        Xác nhận xóa phường này
        <button class="btn btn-danger btn-block" onclick="xacnhanxoaphuong()">
          Xóa
        </button>
      </div>
    </div>
  </div>
</div>

<div id="modal-themtiemphong" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title"> Thêm tiêm phòng </h4>
      </div>
      <div class="modal-body">
        <div class="form-group"> <b>Chủ hộ</b> </div>
        <div class="form-group goiy">
          <input type="text" class="form-control" id="chuho" placeholder="Tìm kiếm chủ hộ theo tên, địa chỉ, số điện thoại">
          <div class="danhsachgoiy" id="goiychuho"></div>
        </div>

        <div class="form-group row">
          <div class="col-xs-6"> Tên chủ hộ </div>
          <div class="col-xs-18">
            <input type="text" class="form-control" id="tenchu" placeholder="Tên chủ hộ">
          </div>
        </div>

        <div class="form-group row">
          <div class="col-xs-6"> Điện thoại </div>
          <div class="col-xs-18">
            <input type="text" class="form-control" id="dienthoai" placeholder="Điện thoại">
          </div>
        </div>

        <div class="form-group row">
          <div class="col-xs-6"> Địa chỉ </div>
          <div class="col-xs-18">
            <input type="text" class="form-control" id="diachi" placeholder="Địa chỉ">
          </div>
        </div>

        <div class="form-group row">
          <div class="col-xs-6"> Phường </div>
          <div class="col-xs-18">
            <select class="form-control" id="phuong">
              <!-- BEGIN: phuong -->
              <option value="{idphuong}">
                {tenphuong}
              </option>
              <!-- END: phuong -->
            </select>
          </div>
        </div>

        <div class="form-group"> <b>Thú cưng</b> </div>
        <div class="form-group goiy">
          <input type="text" class="form-control" id="thucung" placeholder="Tìm kiếm thú cưng theo tên, microchip">
          <div class="danhsachgoiy" id="goiythucung"></div>
        </div>

        <div class="form-group row">
          <div class="col-xs-6"> Tên thú cưng </div>
          <div class="col-xs-18">
            <input type="text" class="form-control" id="tenthucung" placeholder="Tên thú cưng">
          </div>
        </div>

        <div class="form-group row">
          <div class="col-xs-6"> Microchip </div>
          <div class="col-xs-18">
            <input type="text" class="form-control" id="micro" placeholder="Microchip">
          </div>
        </div>

        <div class="form-group row">
          <div class="col-xs-6"> Giống loài </div>
          <div class="col-xs-18 goiy">
            <input type="text" class="form-control" id="giongloai" placeholder="Tìm kiếm giống loài">
            <div class="danhsachgoiy" id="goiygiongloai"></div>
          </div>
        </div>

        <div class="form-group row">
          <div class="col-xs-6"> </div>
          <div class="col-xs-9">
            <input type="text" class="form-control" id="loai" placeholder="Loài">
          </div>
          <div class="col-xs-9">
            <input type="text" class="form-control" id="giong" placeholder="Giống">
          </div>
        </div>

        <div class="form-group"> Thời gian tiêm phòng </div>
        <div class="form-group">
          <input type="text" class="form-control date" id="thoigiantiem">
        </div>

        <button class="btn btn-success btn-block them" onclick="xacnhanthemphuong()">
          Thêm
        </button>
        <button class="btn btn-info btn-block capnhat" onclick="xacnhanthemphuong()">
          Cập nhật
        </button>
      </div>
    </div>
  </div>
</div>

<div class="margin-left-sm">
  <a href="/quanly" class="margin-right-lg">
    <em class="fa fa-caret-right margin-right-sm"></em> Trở về quản lý
  </a>
</div>

<div class="form-group">
  <button class="btn btn-success" onclick="themtiemphong()">
    <span class="fa fa-plus-circle"></span> Thêm tiêm phòng
  </button>
</div>

<div id="tiemphong" class="tab-pane fade in active">
  {danhsachtiemphong}
</div>

<script>
  var global = {
    id: 0,
    idchu: 0,
    idthucung: 0
  }

  $(document).ready(() => {
    vhttp.alert()
    $('.date').datepicker({
      dateFormat: 'dd/mm/yy'
    })

    vremind.install('#chuho', '#goiychuho', (key) => {
      return new Promise(resolve => {
        vhttp.post('/quanly/api/', {
          action: 'timkiemchuho',
          tukhoa: key,
        }).then((phanhoi) => {
          resolve(phanhoi.danhsach)
        })
      })
    }, 300, 300)

    vremind.install('#thucung', '#goiythucung', (key) => {
      return new Promise(resolve => {
        vhttp.post('/quanly/api/', {
          action: 'timkiemthucung',
          idchu: global.idchu,
          tukhoa: key,
        }).then((phanhoi) => {
          resolve(phanhoi.danhsach)
        })
      })
    }, 300, 300)

    vremind.install('#giongloai', '#goiygiongloai', (key) => {
      return new Promise(resolve => {
        vhttp.post('/quanly/api/', {
          action: 'timkiemgiongloai',
          tukhoa: key,
        }).then((phanhoi) => {
          resolve(phanhoi.danhsach)
        })
      })
    }, 300, 300)
  })

  function hienthinut() {
    if (global.id) {
      $('.them').hide()
      $('.capnhat').show()
    }
    else {
      $('.capnhat').hide()
      $('.them').show()
    }
  }

  function chonchuho(idchu, ten, diachi, dienthoai, idphuong) {
    global.idchu = idchu
    $('#tenchu').val(ten)
    $('#diachi').val(diachi)
    $('#dienthoai').val(dienthoai)
    $('#phuong option[value='+ idphuong +']')[0].selected = true
  }

  function chonthucung(idthucung, ten, micro, giong, loai) {
    global.idthucung = idthucung
    $('#tenthucung').val(ten)
    $('#micro').val(micro)
    $('#giong').val(giong)
    $('#loai').val(loai)
  }

  function chongiongloai(giong, loai) {
    $('#giong').val(giong)
    $('#loai').val(loai)
  }

  // function xoaphuong(id) {
  //   global.id = id
  //   $('#modal-xoaphuong').modal('show')
  // }

  // function themphuong() {
  //   global.id = 0
  //   hienthinut()
  //   $('#tenphuong').val('')
  //   $('#modal-themphuong').modal('show')
  // }

  // function capnhatphuong(id, tenphuong) {
  //   global.id = id
  //   hienthinut()
  //   $('#tenphuong').val(tenphuong)
  //   $('#modal-themphuong').modal('show')
  // }

  // function xacnhanxoaphuong() {
  //   vhttp.post('/quanly/api/', {
  //     action: 'xoaphuong',
  //     id: global.id,
  //   }).then((phanhoi) => {
  //     $('#phuong').html(phanhoi.danhsachphuong)
  //     $('#modal-xoaphuong').modal('hide')
  //   })
  // }

  // function xacnhanthemphuong() {
  //   if (!$('#tenphuong').val().length) vhttp.notify('Không được để trống tên phường')
  //   else {
  //     vhttp.post('/quanly/api/', {
  //       action: 'themphuong',
  //       id: global.id,
  //       tenphuong: $('#tenphuong').val()
  //     }).then((phanhoi) => {
  //       $('#phuong').html(phanhoi.danhsachphuong)
  //       $('.nav-tabs a[href="#phuong"]').tab('show');
  //       $('#modal-themphuong').modal('hide')
  //     })
  //   }
  // }

  function xoagiong(id) {
    global.id = id
    $('#modal-xoagiong').modal('show')
  }

  function xacnhanxoagiong() {
    vhttp.post('/quanly/api/', {
      action: 'xoagiong',
      id: global.id,
    }).then((phanhoi) => {
      $('#giong').html(phanhoi.danhsachgiong)
      $('#modal-xoagiong').modal('hide')
    })
  }

  function themtiemphong() {
    global.id = 0
    hienthinut()
    $('#modal-themtiemphong').modal('show')
  }

  function capnhattiemphong(id) {
    global.id = id
    hienthinut()
    $('#modal-themgiong').modal('show')
  }

  function xacnhanthemtiemphong() {
    if (!$('#tenloai').val().length) vhttp.notify('Không được để trống tên loài')
    else if (!$('#tengiong').val().length) vhttp.notify('Không được để trống tên giống')
    else {
      vhttp.post('/quanly/api/', {
        action: 'themgiong',
        id: global.id,
        tengiong: $('#tengiong').val(),
        tenloai: $('#tenloai').val(),
      }).then((phanhoi) => {
        $('#giong').html(phanhoi.danhsachgiong)
        $('.nav-tabs a[href="#giong"]').tab('show');
        $('#modal-themgiong').modal('hide')
      })
    }
  }
</script>
<!-- END: main -->