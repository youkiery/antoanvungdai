var vnumber = {
  install: (id) => {
    var prv = ''
    var input = $(id)
    input.keyup(() => {
      value = input.val().replace(/\,/g, "")
      if (isFinite(value)) {
        // là số        
        prv = vnumber.format(value)
      }
      input.val(prv)
    })    
  },
  format: (number) => {
    number = Number(number.toString().replace(/\,/g, ''))
    if (number < 0) number = 0
    number = number.toString()
    return number.split('').reverse().reduce((prev, next, index) => {
        return ((index % 3) ? next : (next + ',')) + prev
    })
  },
  clear: (number) => {
    return Number(number.toString().replace(/\,/g, ''))
  }
}