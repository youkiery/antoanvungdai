<!-- BEGIN: main -->
<!-- BEGIN: l1a -->
<div class="child"> <input type="checkbox" name="{l1}" ref="{id}" {l1checked}> {header1} </div>
<!-- END: l1a -->
<!-- BEGIN: l1 -->
<div class="pw-toggle">
  <div class="pw-toggle-head"> <input type="checkbox" name="{l1}" ref="{id}" {l1checked} onchange="thaydoi({id}, {l1}, 1)"> {header1} </div>
  <div class="pw-toggle-body">
    <!-- BEGIN: l2a -->
    <div class="child"> <input type="checkbox" l1="{l1}" name="{l2}" ref="{id}" {l2checked}> {header2} </div>
    <!-- END: l2a -->
    <!-- BEGIN: l2 -->
    <div class="pw-toggle">
      <div class="pw-toggle-head"> <input type="checkbox" l1="{l1}" name="{l2}" ref="{id}" {l2checked} onchange="thaydoi({id}, {l2}, 2)"> {header2} </div>
      <div class="pw-toggle-body">
        <!-- BEGIN: l3 -->
        <div class="child"> <input type="checkbox" l1="{l1}" l2="{l2}" name="{l3}" ref="{id}" {l3checked}> {header3} </div>
        <!-- END: l3 -->
      </div>
    </div>
    <!-- END: l2 -->
  </div>
</div>
<!-- END: l1 -->

<div style="float: right;">
  <button class="btn btn-info btn-sm" onclick="luuphanquyen({id})"> <span class="fa fa-floppy-o"></span> Lưu phân quyền </button>
  <button class="btn btn-info btn-sm"> <span class="fa fa-pencil"></span> Sửa </button>
  <button class="btn btn-danger btn-sm"> <span class="fa fa-close"></span> Xóa </button>
</div>
<!-- END: main -->