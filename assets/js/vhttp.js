var vhttp = {
  // check: dùng để rút gọn jquery post | trả về dữ liệu trả về
  init: false,
  alert: function () {
    if (!vhttp.init) {
      var html = `
      <div id="alert-vhttp" class="alert alert-info pw-alert" role="alert"> </div>`
      $('body').append(html)
      vhttp.init = true
    }
  },
  post: function (url, param) {
    return new Promise((resolve, reject) => {
      if (!vhttp.init) vhttp.alert()
      $.post(url, param, (response, status) => {
        try {
          response = JSON.parse(response)
          if (response['messenger']) {
            vhttp.notify(response['messenger'])
          }
          if (status == 'success' && response['status']) {
            resolve(response)
          }
          reject(response)
        }
        catch (exception) {
          // giá trị không thuộc dạng json, báo lỗi hệ thống
          vhttp.notify('Có lỗi xảy ra >.<')
          reject({})
        }
      })
    })
  },
  notify: (text) => {
    if (!vhttp.init) vhttp.alert()
    $('#alert-vhttp').text(text).show().delay(2000).fadeOut(500)
  }
}
