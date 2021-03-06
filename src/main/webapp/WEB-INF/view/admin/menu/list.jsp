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
		<h4>系统菜单管理<small>>> 菜单列表</small></h4>
	  </div>
	</div>
	<div class="row-fluid filter-block">
	  <div class="left">
		<input type="text" class="search" id="searchValue" onkeypress="EnterPress(event)"/>
		<a class="btn-flat new-product" data-toggle="modal" data-target="#addMenu">+ 添加菜单</a>
	  </div>
	</div>
	<div class="row-fluid" id="dataContent">
	  
	</div>
  </div>
  
  <!-- 模态框（Modal） -->
  <div class="modal fade" id="addMenu" tabindex="-1" role="dialog" 
  	aria-labelledby="myModalLabel" aria-hidden="true" style="display: none">	
	<div class="modal-dialog">
      <div class="modal-content">
         <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                  &times;
            </button>
            <h4 class="modal-title" id="myModalLabel">
               	新增系统菜单
            </h4>
         </div>
         <div class="modal-body">
         <form id="add_form">
           <table style="text-align: center">
           	<tr><td width="50%">父级菜单</td><td>
           		<div class="ui-select">
           			<select id="add_parentID" name="parentID">
           				<option selected="selected" value="0">顶级菜单</option>
           				<c:forEach items="${menuList }" var="menu">
           				<option value="${menu.id }">${menu.name }</option>
           				</c:forEach>
           			</select>
           		</div>
           	</td></tr>
           	<tr><td>菜单名称</td><td><input type="text" name="name" id="add_name"/></td></tr>
           	<tr><td>url链接</td><td><input type="text" name="url" id="add_url"/></td></tr>
           	<tr><td>排序号</td><td><input type="text" name="orderNum" id="add_orderNum"/></td></tr>
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
               	提交
            </button>
         </div>
      </div><!-- /.modal-content -->
	</div><!-- /.modal -->
  </div>	
  
  <!-- 模态框（Modal） -->
  <div class="modal fade" id="updateMenu" tabindex="-1" role="dialog" 
  	aria-labelledby="myModalLabel" aria-hidden="true" style="display: none">	
	<div class="modal-dialog">
      <div class="modal-content">
         <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                  &times;
            </button>
            <h4 class="modal-title" id="myModalLabel">
               	编辑系统菜单
            </h4>
         </div>
         <div class="modal-body">
         <form id="update_form">
           <input type="hidden" name="id" id="update_id">
           <table style="text-align: center">
           	<%-- <tr><td width="50%">父级菜单</td><td>
           		<div class="ui-select">
           			<select id="update_parentID" name="parentID">
           				<option value="0">顶级菜单</option>
           				<c:forEach items="${menuList }" var="menu">
           				<option value="${menu.id }">${menu.name }</option>
           				</c:forEach>
           			</select>
           		</div>
           	</td></tr> --%>
           	<tr><td width="50%">菜单类型</td><td><input type="text" id="update_type" disabled="disabled"/></td></tr>
           	<tr><td>菜单名称</td><td><input type="text" name="name" id="update_name"/></td></tr>
           	<tr><td>url链接</td><td><input type="text" name="url" id="update_url"/></td></tr>
           	<tr><td>排序号</td><td><input type="text" name="orderNum" id="update_orderNum"/></td></tr>
           	<!-- <tr><td>状态</td><td>
           		<div class="slider-frame primary">
           			<input type="hidden" id="update_status" name="status" value="0"/>
					<span id="add_select_status" class="slider-button on" data-off-text="禁用" data-on-text="启用">启用</span>
				</div>
           	</td></tr> -->
           </table>
         </form>
         </div>
         <div class="modal-footer">
            <button id="update_close" type="button" class="btn btn-default" 
               data-dismiss="modal">关闭
            </button>
            <button type="button" class="btn btn-primary" onclick="upd()">
               	提交
            </button>
         </div>
      </div><!-- /.modal-content -->
	</div><!-- /.modal -->
  </div>
  <script type="text/javascript">
  	$(function(){
  		loadData();
  	})
  	
  	//搜索文本框触发事件
  	function EnterPress(e){ //传入 event
		var e = e || window.event;
		if(e.keyCode == 13){
			loadData();
		}
	} 
  	
  	function loadData(){
  		var searchValue = $("#searchValue").val();
  		$.get("${base}/admin/menu/data.do?searchValue="+encodeURI(encodeURI(searchValue)), function(html) {
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
  		var parentID = $("#add_parentID").val()
  		var name = $.trim($("#add_name").val());
  		var url = $.trim($("#add_url").val());
  		var orderNum = $.trim($("#add_orderNum").val());
  		//验证
  		if(name=='') {
  			$("#add_name").focus();
  			return;
  		}
  		if(parentID!='0'&&url=='') {
  			$("#add_url").focus();
  			return;
  		}
  		if(orderNum=='') {
  			$("#add_orderNum").focus();
  			return;
  		}
		$.ajax({
			type:'POST',
			url: '${base}/admin/menu/add.do',
			data: $("#add_form").serialize(),
			dataType: 'json',
			success: function(msg) {
				if(msg.state=='success') {
					alert("添加成功");
					$("#addMenu").modal("toggle");
					//重置模态框表单
					$("#add_form")[0].reset();
					loadUrl("admin/menu/list.do");
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