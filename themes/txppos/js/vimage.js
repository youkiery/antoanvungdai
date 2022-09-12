var vimage = {
  data: {},
  max: 960,
  imageid: 0,
  index: 0,
  init: false,
  path: '',
  clear: (imageid) => {
    vimage.data[imageid] = ['']
    vimage.reload(imageid)
  },
  install: (imageid) => {
    if (!vimage.init) {
      var html = `
      <div id="alert-vimage" class="alert alert-warning pw-alert" role="alert"> Đang tải ảnh lên </div>
      <div class="modal fade" id="modal-vimage" role="dialog">
        <div class="modal-dialog modal-sm">
          <div class="modal-content">
            <div class="modal-header">
              <button type="button" class="close" data-dismiss="modal">&times;</button> <br> <br>
              <div class="text-center">
                Xác nhận xóa hình ảnh
              <button class="btn btn-danger btn-block" onclick="vimage.remove()"> Xóa </button>
              </div>
            </div>
          </div>
        </div>
      </div>`
      $('body').append(html)
      vimage.init = true
    }
    vimage.data[imageid] = ['']
    vimage.reload(imageid)
  },
  reload: (imageid) => {
    var html = ''
    if (vimage.data[imageid].length == 0) vimage.data[imageid]
    vimage.data[imageid].forEach((image, index) => {
      html += `
      <div class="pw-image-box">
        <div class="pw-image-click fa fa-times-circle-o `+ (image.length ? '' : 'pw-none') +`" onclick="vimage.confirm('` + imageid + `', ` + index + `)"> </div>
        <img id="`+ imageid + `-` + index + `-image" src="` + (image.length ? image : '/assets/images/upload.png') + `" class="pw-image" onclick="vimage.upload('` + imageid + `', ` + index + `)">
        <input class="pw-none" id="`+ imageid + `-` + index + `" type="file" onchange="vimage.change('` + imageid + `', ` + index + `)">
      </div>`
    });
    $('#' + imageid).html(html)
  },
  upload: (imageid, index) => {
    $('#' + imageid + '-' + index).click()
  },
  change: (imageid, index) => {
    var img = $('#' + imageid + '-' + index)[0].files[0]
    vimage.getBase64(img).then(base64 => {
      vimage.data[imageid][index] = base64
      vimage.data[imageid].push('')
      vimage.reload(imageid)
    })
  },
  confirm: (imageid, index) => {
    vimage.imageid = imageid
    vimage.index = index
    $('#modal-vimage').modal('show')
  },
  remove: () => {
    vimage.data[vimage.imageid] = vimage.data[vimage.imageid].filter((item, i) => {
      return vimage.index !== i
    })
    if (vimage.data[vimage.imageid].length == 0) vimage.data[vimage.imageid] = ['']
    vimage.reload(vimage.imageid)
    $('#modal-vimage').modal('hide')
  },
  getBase64: (file) => {
    return new Promise((resolve, reject) => {
      const reader = new FileReader();
      reader.readAsDataURL(file);
      reader.onload = () => {
        image = reader.result
        let imageLoader = new Image();
        imageLoader.src = image
        imageLoader.onload = () => {
          let canvas = document.createElement('canvas')
          let context = canvas.getContext('2d')
          let rate = 1
          if (imageLoader.width > vimage.max || imageLoader.height > vimage.max) {
            if (imageLoader.width > imageLoader.height) rate = imageLoader.width / vimage.max
            else rate = imageLoader.height / vimage.max
          }
          let newWidth = imageLoader.width / rate
          let newHeight = imageLoader.height / rate
          canvas.width = newWidth
          canvas.height = newHeight
          context.drawImage(imageLoader, 0, 0, canvas.width, canvas.height)
          resolve(canvas.toDataURL('image/jpeg'))
        }
      };
      reader.onerror = error => reject(error);
    });
  },
  uploadimage: async (imageid) => {
    return new Promise(resolve => {
      var count = vimage.data[imageid].length
      $('#alert-vimage').fadeIn(500)
      vimage.data[imageid].forEach((image, index) => {
        if (image.length < 500) {
          count--
          if (!count) {
            $('#alert-vimage').fadeOut(500)
            resolve(0)
          } 
        }
        else {
          var file = image.slice(image.indexOf(',') + 1);
          var name = index + '-' + Math.floor((new Date()).getTime() / 1000) + '.jpg'
          var upload = firebase.storage().ref(vimage.path + '/' + name).putString(file, 'base64', { contentType: 'image/jpeg' })
          upload.on(firebase.storage.TaskEvent.STATE_CHANGED, (snapshot) => {
            // state change
          }, function (error) {
            // error
            count--
            if (!count) {
              $('#alert-vimage').fadeOut(500)
              resolve(0)
            } 
          }, function () {
            // done
            upload.snapshot.ref.getDownloadURL().then((downloadURL) => {
              vimage.data[imageid][index] = downloadURL
              count--
              if (!count) {
                $('#alert-vimage').fadeOut(500)
                resolve(0)
              } 
            });
          });
        }
      });
    })
  }
}
