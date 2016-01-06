<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/layouts/taglibs.jsp"%>
<!DOCTYPE html>
<html>
  <script type="text/javascript">
  </script>
  <div class="table-products section">
	<div class="row-fluid head">
	  <div class="span12">
		<h4>系统角色管理<small>>> 角色列表</small></h4>
	  </div>
	</div>
	<div class="row-fluid filter-block">
	  <div class="left">
		<input type="text" class="search" id="searchValue" onkeypress="EnterPress(event)" value="${searchValue }"/>
		<a class="btn-flat new-product" data-toggle="modal" data-target="#addRole">+ 添加角色</a>
	  </div>
	</div>
	<!-- 数据加载区域 -->
	<div class="row-fluid" id="dataContent"></div>
	<!-- 分页 -->
	<div class="pagination"></div>
  </div>
  
  <!-- 模态框（Modal） -->
  <div class="modal fade" id="addRole" tabindex="-1" role="dialog" 
  	aria-labelledby="myModalLabel" aria-hidden="true" style="display: none">	
	<div class="modal-dialog">
      <div class="modal-content">
         <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                  &times;
            </button>
            <h4 class="modal-title" id="myModalLabel">
               	新增系统角色
            </h4>
         </div>
         <div class="modal-body">
         <form id="add_form">
           <table style="text-align: center">
           	<tr><td width="50%">角色名称</td><td><input type="text" name="name" id="add_name"/></td></tr>
           	<tr><td>状态</td><td>
           		<div class="slider-frame primary">
           			<input type="hidden" id="add_status" name="status" value="0"/>
					<span id="add_select_status" class="slider-button on" data-off-text="禁用" data-on-text="启用">启用</span>
				</div>
           	</td></tr>
           </table>
         </form>
         </div>
         <div class="modal-footer">
            <button id="add_close" type="button" class="btn btn-default" 
               data-dismiss="modal">关闭
            </button>
            <button type="button" class="btn btn-primary" onclick="add()">
               	保存并配置权限
            </button>
         </div>
      </div><!-- /.modal-content -->
	</div><!-- /.modal -->
  </div>
  <script type="text/javascript">
  	//记录翻页页码
  	var pageIndex = '0';
  	$(function(){
  		$(".pagination").pagination('${page.dataCount}', {
            callback: pageSelectCallback,//pageSelectCallback() 为翻页调用次函数。
            prev_text: "上一页",
            next_text: "下一页 ",
            items_per_page: '${page.pageSize}', //每页的数据个数
            num_display_entries: 3, //两侧首尾分页条目数
            current_page: 0,   //当前页码
            num_edge_entries: 2 //连续分页主体部分分页条目数
        });
  	})
  	
  	function pageSelectCallback(page_id, jq) {
		loadData(page_id);
	}	
  	
  	//搜索文本框触发事件
  	function EnterPress(e) { //传入 event
  		var searchValue = $.trim($("#searchValue").val());
		var e = e || window.event;
		if(e.keyCode == 13){
			loadUrl('admin/role/list.do?searchValue='+encodeURI(encodeURI(searchValue)));
		}
	} 
  	
  	//加载数据  page_id页码，第一页为0
  	function loadData(page_id) {
  		if(page_id != ''){
	  		pageIndex = page_id;
  		}else {
  			page_id = pageIndex;
  		}
  		var searchValue = $("#searchValue").val();
  		$.get("${base}/admin/role/data.do?searchValue="+encodeURI(encodeURI(searchValue))+"&pageIndex="+(page_id+1), function(html) {
  			$("#dataContent").html(html);
  		})
  	}
  	$("#add_select_status").click(function() {
  		$(this).toggleClass("on");
  		if($(this).html()=='禁用') {
  			$("#add_status").val(0);
  			$(this).html("启用");
  		}else {
  			$("#add_status").val(1);
  			$(this).html("禁用");
  		}
  	})
  	
  	//添加菜单
  	function add() {
  		var name = $.trim($("#add_name").val());
  		//验证
  		if(name=='') {
  			$("#add_name").focus();
  			return;
  		}
		$.ajax({
			type:'POST',
			url: '${base}/admin/role/add.do',
			data: $("#add_form").serialize(),
			dataType: 'json',
			success: function(msg) {
				if(msg.state=='success') {
					$("#addRole").modal("toggle");
					//重置模态框表单
					$("#add_form")[0].reset();
					//跳转权限编辑页面
					loadUrl('admin/role/editRoot.do?method=add&roleID='+msg.roleID);
				}else{
					alert(msg.msg);
				}
			}
		}) 		
  	}
  	
  	function updateFunc(id, parentName, name, url, orderNum) {
  		$("#update_id").val(id);
  		$("#update_name").val(name);
  		$("#update_url").val(url);
  		$("#update_orderNum").val(orderNum);
  		if(parentName==''){
  			$("#update_type").val("顶级菜单");
  		}else {
  			$("#update_type").val("["+parentName+"]下子菜单");
  		}
  		$("#updateMenu").modal('toggle');
  	}
  	
  	function upd(){
  		var name = $.trim($("#update_name").val());
  		var type = $.trim($("#update_type").val());
  		var url = $.trim($("#update_url").val());
  		var orderNum = $.trim($("#update_orderNum").val());
  		//验证
  		if(name=='') {
  			$("#update_name").focus();
  			return;
  		}
  		if(type!=''&&url=='') {
  			$("#update_url").focus();
  			return;
  		}
  		if(orderNum=='') {
  			$("#update_orderNum").focus();
  			return;
  		}
  		
  		$.ajax({
  			type: 'POST',
  			url: '${base}/admin/menu/update.do',
  			data: $("#update_form").serialize(),
  			dataType: 'json',
  			success: function(msg) {
  				if(msg.state != 'success') {
  					alert(msg.msg);
  				}else {
  					alert("修改成功");
  					loadData();
  					$("#updateMenu").modal("toggle");
  				}
  			}
  		})
  	}
  </script>
</html>