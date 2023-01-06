/**
 * NukeViet Content Management System
 * @version 4.x
 * @author VINADES.,JSC <contact@vinades.vn>
 * @copyright (C) 2009-2021 VINADES.,JSC. All rights reserved
 * @license GNU/GPL version 2 or any later version
 * @see https://github.com/nukeviet The NukeViet CMS GitHub project
 */

/* Các tùy chỉnh JS của giao diện nên để vào đây */

function timetodate(time) {
  let datetime = new Date(Number(time))
  let date = datetime.getDate().toString()
  date = (Number(date) < 10 ? '0' + date : date)
  let month = (datetime.getMonth() + 1).toString()
  month = (Number(month) < 10 ? '0' + month : month)
  let year = datetime.getFullYear()
  return date + '/' + month + '/' + year
}

function dienso(so) {
  if (so < 10) so = '0' + so
  return so
}
