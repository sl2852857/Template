<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/layouts/taglibs.jsp"%>
<!DOCTYPE html>
<html>
  <div class="table-products section">
	<div class="row-fluid head">
	  <div class="span12">
		<h4>系统角色管理<small>>> 权限分配 </small></h4>
	  </div>
	</div>
	<div class="row-fluid filter-block">
	  <div class="left">
		<a class="btn-flat new-product" href='javascript:addRoot()'>+ 保存权限</a>
		&nbsp;&nbsp;
		<a class="btn-flat new-product" href="javascript:loadUrl('admin/role/list.do')">&lt; 返回</a>
	  </div>
	</div>
	<div class="row-fluid">
	<form id="root_form">
	<input type="hidden" name="id" value="${roleID }">
	<table class="table table-hover">
	<thead>
	  <tr style="background-color: #f7f7f7">
		<th class="span2">
	      <input type="checkbox" id="allSelect"/>选择
	   	</th>
	   	<th class="span3">
	      <span class="line"></span>ID
	  	</th>
	 	<th class="span3">
	      <span class="line"></span>名称
	   	</th>
	   	<th class="span3">
	      <span class="line"></span>url链接
	    </th>
	    <th class="span3">
	      <span class="line"></span>状态
	   	</th>
	  </tr>
	</thead>
  	<tbody>
	<!-- 新增角色配置权限 -->
	  <c:forEach items="${allMenuList }" var="menu">
	  	<tr>
	      <td>
	      	<!-- 设置标识，如果有id相同则选中，标识改成1 -->
	      	<c:set var="flag" value="0"></c:set>
	      	<c:forEach items="${menuIdList }" var="menuId">
	      	  <c:if test="${menuId == menu.id }">
	            <input type="checkbox" name="menuIds" id="${menu.id }_menu" class="menu" value="${menu.id }" checked="checked"/>
	      		<c:set var="flag" value="1"></c:set>
	      	  </c:if>
	      	</c:forEach>
	      	<c:if test="${flag == 0 }">
	            <input type="checkbox" name="menuIds" id="${menu.id }_menu" class="menu" value="${menu.id }"/>
	      	</c:if>
	      </td>
	      <td class="description">
	      	${menu.id }
	      </td>
	        <td class="description">
	            ${menu.name }
	        </td>
	        <td class="description">
	            ${menu.url }
	        </td>
	        <td>
	        <c:if test="${menu.status==0 }">
	          <span class="label label-success">启用</span>
	        </c:if>
	        <c:if test="${menu.status==1 }">
	          <span class="label label-error">禁用</span>
	        </c:if>
	        </td>
	   	  </tr>
	   	  <c:forEach items="${menu.menuList }" var="sonMenu">
	   	  	<tr style="background-color: #f7f7f7">
		        <td>
		          <!-- 设置标识，如果有id相同则选中，标识改成1 -->
	      		  <c:set var="flag2" value="0"></c:set>
	      		  <c:forEach items="${menuIdList }" var="menuId">
	      	  		<c:if test="${menuId == sonMenu.id }">
	            	  <input type="checkbox" name="menuIds" class="${menu.id }_sonMenu" data-parent-id="${menu.id }" value="${sonMenu.id }" checked="checked"/>
	      			  <c:set var="flag2" value="1"></c:set>
	      	  	  	</c:if>
	      		  </c:forEach>
	      		  <c:if test="${flag2 == 0 }">
	            	<input type="checkbox" name="menuIds" class="${menu.id }_sonMenu sonMenu" data-parent-id="${menu.id }" value="${sonMenu.id }"/>
	      	  	  </c:if>
		        </td>
		        <td class="description">
		            ${sonMenu.id }
		        </td>
		        <td class="description">
		            &nbsp;&nbsp;┗━━&nbsp;&nbsp;${sonMenu.name }
		        </td>
		        <td class="description">
		            ${sonMenu.url }
		        </td>
		        <td>
		        <c:if test="${sonMenu.status==0 }">
		          <span class="label label-success">启用</span>
		        </c:if>
		        <c:if test="${sonMenu.status==1 }">
		          <span class="label label-error">禁用</span>
		        </c:if>
		        </td>
		   	  </tr>
	    </c:forEach>
	  </c:forEach>
    </tbody>
  </table>
  </form>
  </div>
  </div>
  
  <script type="text/javascript">
  	$(function(){
  		$("#allSelect").change(function(){
  			var is_checked = $("#allSelect").prop('checked');
  			$("input[type='checkbox']").prop("checked", is_checked);
  		})
  		
  		$(".menu").change('click', function(){
  			var is_checked = $(this).prop('checked');
  			var menuId = $(this).val();
  			
  			$("."+menuId+"_sonMenu").prop('checked', is_checked);
  		})
  		
  		$(".sonMenu").change('click', function(){
  			var parentId = $(this).data("parentId");
  			var is_checked = $(this).prop('checked');
  			if(is_checked) {
	  			$("#"+parentId+"_menu").prop('checked', is_checked);
  			}else {
  				if($("."+parentId+"_sonMenu:checked").length==0) {
		  			$("#"+parentId+"_menu").prop('checked', is_checked);
  				}
  			}
  		})
  	})
  	
  	//保存权限
  	function addRoot() {
  		$.ajax({
  			type: 'POST',
  			url: '${base}/admin/role/update.do',
  			data: $("#root_form").serialize(),
  			dataType: 'json',
  			success: function(msg) {
  				if(msg.state!='success') {
  					alert(msg.msg);
  				}else {
  					alert("保存成功");
  					loadUrl("admin/role/list.do");
  				}
  			}
  		})
  	}
  </script>
</html>