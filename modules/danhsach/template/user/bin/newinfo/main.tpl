<!-- BEGIN: main -->
<div class="container">
  <form onsubmit="return checker(event)">
    <h2> Chủ nuôi </h2>
    <div class="row">
      <div class="col-sm-6">
        <div class="form-group">
          <label> Tôi tên là\Owner's name: </label>
          <input type="text" class="form-control newinfo" id="name">
        </div>
      </div>
      <div class="col-sm-6">
        <div class="form-group">
          <label> Ngày sinh\Birthday: </label>
          <input type="text" class="form-control newinfo" id="birthday">
        </div>
      </div>
    </div>
    <div class="form-group">
      <label> Địa chỉ cư trú\Address: </label>
      <input type="text" class="form-control newinfo" id="address">
    </div>
    <div class="form-group">
      <label> Số điện thoại liên hệ\Mobile phone: </label>
      <input type="text" class="form-control newinfo" id="phone">
    </div>
    <h2> Thú cưng </h2>
    <div class="row">
      <div class="col-sm-6">
        <div class="form-group">
          <label> Tên thú cưng\Pet's name: </label>
          <input type="text" class="form-control newinfo" id="petname">
        </div>
      </div>
      <div class="col-sm-6">
        <div class="form-group">
          <label> Ngày sinh\Birthday: </label>
          <input type="text" class="form-control newinfo" id="petbirthday">
        </div>
      </div>
    </div>
    <div class="row">
      <div class="col-sm-6">
        <div class="form-group">
          <label> Giống\Breed: </label>
          <input type="text" class="form-control newinfo" id="petbreed">
        </div>
      </div>
      <div class="col-sm-6">
        <div class="form-group">
          <label> Giới tính\Sex: </label>
          <input type="text" class="form-control newinfo" id="petsex">
        </div>
      </div>
    </div>
    <div class="row">
      <div class="col-sm-6">
        <div class="form-group">
          <label> Màu lông\Colour: </label>
          <input type="text" class="form-control newinfo" id="petcolor">
        </div>
      </div>
      <div class="col-sm-6">
        <div class="form-group">
          <label> Số microchip\Microchip no: </label>
          <input type="text" class="form-control newinfo" id="petmicro">
        </div>
      </div>
    </div>
    <div class="form-group">
      <label> Người nhân giống\Breeder: </label>
      <input type="text" class="form-control newinfo" id="petbreeder">
    </div>
    <p> Tôi cam đoan thông tin mình cung cấp là chính xác. Nếu có bất kỳ sai sót nào tôi xin tự chịu trách nhiệm. </p>
    <p> I pledge that the information I have provided is correct. If there is any wrong I take responsibility for myself. </p>
    <p> Trong trường hợp có tranh chấp, cơ quan đại diện được phép xét nghiệm DNA, hoặc dựa vào bằng chứng và tài liệu chứng minh hoặc kết quả xét nghiệm DNA để chủ chứng minh được chó/mèo đó là thuộc sở hữu của mình, thì quyền sở hữu sẽ được chuyển cho người đó. </p>
    <p> In the event of a dispute, the agency is allowed to test DNA, or based on evidence and supporting documents or the results of the DNA test to prove that the dog / cat is in his possession. Ownership will be passed on to that person. </p>
    <button class="btn btn-info btn-lg btn-block">
      Gửi thông tin xác nhận
    </button>
  </form>

  <div id="register-list">
    {list}
  </div>
</div>
<style>
  .red {
    border-color: red;
    box-shadow: inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(233, 102, 135, 0.6);
  }
</style>
<script src="/modules/core/vhttp.js"></script>
<script>
  
  var notify = {
    name: "Tên chủ nuôi",
    birthday: "Ngày sinh",
    phone: "Số điện thoại",
    address: "Địa chỉ",
    petname: "Tên thú cưng",
    petbirthday: "Ngày sinh thú cưng",
    petbreed: "Giống thú cưng",
    petsex: "Giới tính thú cưng",
    petcolor: "Màu lông thú cưng",
    petmicro: "Số microchip",
    petbreeder: "Người nhân giống"
  }

  function checker(e) {
    e.preventDefault()
    data = {}
    check = true
    $('.newinfo').each((index, item) => {
      id = item.getAttribute('id')
      value = item.value
      if (!value.length) {
        // alert
        // alert(notify[id] + ' không được để trống')
        var clas = item.getAttribute('class')
        item.setAttribute('class', clas + ' red')
        item.focus()
        setTimeout(() => {
          item.setAttribute('class', 'form-control newinfo newinfo')
        }, 2000);
        check = false
        return false
      }
      data[id] = value
    }) 
    if (check) {
      vhttp.checkelse('', {
        action: 'insert',
        data: data
      }).then(response => {
        $('#register-list').html(response.html)
        $('.newinfo').val('')
      })
    }
    return false
  }

  function print(id) {
    vhttp.checkelse('', {
      action: 'print',
      id: id
    }).then(response => {
      window.open('/assets/newinfo-temp.docx?t=' + response.time, '_blank')
    })
  }
</script>
<!-- END: main -->
