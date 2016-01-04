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
		<a class="btn-flat new-product" href='javascript:addFunc()'>+ 保存权限</a>
		&nbsp;&nbsp;
		<a class="btn-flat new-product" href="javascript:loadUrl('admin/role/list.do')">&lt; 返回</a>
	  </div>
	</div>
	<div class="row-fluid">
	<form>
	<input type="hidden" name="roleID" value="${roleID }">
	<table class="table table-hover">
	<thead>
	  <tr style="background-color: #f7f7f7">
		<th class="span3">
	      <input type="checkbox" onclick="allSelect(this)"/>选择
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
	<c:if test="${method == 'add' }">
	<!-- 新增角色配置权限 -->
	  <c:forEach items="${allMenuList }" var="menu">
	  	<tr>
	      <td>
	        <input type="checkbox" name="ids" id="${menu.id }_menu" value="${menu.id }"/>
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
		          <input class="${menu.id }_sonMenu" type="checkbox" name="ids"/>
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
  	</c:if>
  	
  	<c:if test="${method == 'edit' }">
	<!-- 修改角色配置权限 -->
	  <c:forEach items="${allMenuList }" var="menu">
	  	<c:forEach items="${menuList }" var="old_menu">
	  	<tr>
	      <td>
	      	<c:if test="${old_menu.id==menu.id }">
	        <input type="checkbox" name="ids" id="${menu.id }_menu" value="${menu.id }" checked="checked"/>
	      	</c:if>
	      	<c:if test="${old_menu.id!=menu.id }">
	        <input type="checkbox" name="ids" id="${menu.id }_menu" value="${menu.id }"/>
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
		          <input class="${menu.id }_sonMenu" type="checkbox" name="ids"/>
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
	  </c:forEach>
  	</c:if>
    </tbody>
  </table>
  </form>
  </div>
  </div>
  
  <script type="text/javascript">
  		function allSelect(event) {
  			alert($(event).checked());
  		}
  </script>
</html>