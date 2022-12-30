<!-- BEGIN: main -->
<!-- <div class="modal fade" id="modal-khach-hang" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title"> Tìm kiếm hàng hóa </h4>
      </div>
      <div class="modal-body">


      </div>
    </div>
  </div>
</div> -->

<div class="pw-content">
  <!-- <form>
    <div class="input-group">
      <input autocomplete="off" type="text" class="form-control" placeholder="Tìm Kiếm" name="keyword" value="">
      <div class="input-group-btn">
        <button class="btn btn-default" type="submit">
          <span class="fa fa-search"></span>
        </button>
      </div>
    </div>
  </form> -->

  <div class="pw-header">
    Tổng quan
  </div>

  <div class="pw-card">
    <h4> Thống kê hôm nay </h4>
    <div class="row">
      <div class="col-xs-12">
        Hóa đơn: {sophieuhoadon} <br>
        Tổng doanh thu: {doanhthu}đ <br>
        So với hôm qua: {tilehomqua}% <br>
        So với tháng trước: {tilethangtruoc}% <br>
      </div>
      <div class="col-xs-12">
        Trả hàng: {sophieutrahang} <br>
        Tổng trả hàng: {tongtrahang}đ
      </div>
    </div>
  </div>

  <div class="row">
    <div class="col-lg-18">
      <div class="pw-card">
        <h4> Thống kê doanh thu tháng này: {tongdoanhthu}đ </h4>
        <canvas id="thongkedoanhthu" style="width:100%"></canvas>
      </div>
      <div class="pw-card">
        <h4> TOP 10 HÀNG HÓA BÁN CHẠY THÁNG TRƯỚC </h4>
        <canvas id="thongkehangthang" style="width:100%"></canvas>
      </div>
    </div>
    <div class="col-lg-6">
      <div class="pw-card">
        <h4> Thông báo </h4>
        <!-- BEGIN: khachno -->
        <ul class="list-group">
          <li class="list-group-item">
            <h4> Khách hàng nợ trên 10.000.000đ gần đây </h4>
          </li>
          <!-- BEGIN: khach -->
          <li class="list-group-item">
            <p> {tenkhach} - {dienthoai} </p>
            <p> {sotien}đ cách đây {songay} ngày </p>
          </li>
          <!-- END: khach -->
        </ul>
        <!-- END: khachno -->

        <!-- BEGIN: hoatdong -->
        <ul class="list-group">
          <li class="list-group-item">
            <h4> Hoạt động gần đây </h4>
          </li>
          <!-- BEGIN: hoadon -->
          <li class="list-group-item">
            {nhanvien} bán đơn hàng trị giá {thanhtien}đ lúc {thoigian}
          </li>
          <!-- END: hoadon -->
        </ul>
        <!-- END: hoatdong -->
      </div>
    </div>
  </div>
</div>
<script>
  var global = {
    thongke: {thongke},
    thongkehangthang: {thongkehangthang},
  }

  $(document).ready(() => {
    new Chart("thongkedoanhthu", {
      type: "bar",
      data: {
        labels: global.thongke.nhan,
        datasets: [{
          backgroundColor: global.thongke.mau,
          data: global.thongke.dulieu
        }]
      },
      options: {
        legend: { display: false },
        scales: {
          yAxes: [{
            ticks: {
              beginAtZero: true
            }
          }],
        }
      }
    });
    new Chart("thongkehangthang", {
      type: "horizontalBar",
      data: {
        labels: global.thongkehangthang.nhan,
        datasets: [{
          backgroundColor: global.thongkehangthang.mau,
          data: global.thongkehangthang.dulieu
        }]
      },
      options: {
        legend: { display: false },
        scales: {
          yAxes: [{
            ticks: {
              beginAtZero: true
            }
          }],
        }
      }
    });
  })
</script>
<!-- END: main -->