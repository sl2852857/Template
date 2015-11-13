<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/layouts/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<body>
  <script type="text/javascript">
  </script>
  <div class="table-products section">
	<div class="row-fluid head">
	  <div class="span12">
		<h4>用户管理 <small>>> 用户列表</small></h4>
	  </div>
	</div>
	<div class="row-fluid filter-block">
	  <div class="left">
		<input type="text" class="search" />
		<a class="btn-flat new-product">+ 添加 用户</a>
	  </div>
	</div>
	<div class="row-fluid">
	  <table class="table table-hover">
		<thead>
	  	  <tr>
			<th class="span3">
	      	  <input type="checkbox" />选择
	        </th>
	        <th class="span3">
	          <span class="line"></span>ID
	        </th>
	        <th class="span3">
	       	  <span class="line"></span>用户名
	       	</th>
	        <th class="span3">
	       	  <span class="line"></span>最后登录时间
	       	</th>
	        <th class="span3">
	       	  <span class="line"></span>最后登录IP
	       	</th>
	        <th class="span3">
	       	  <span class="line"></span>状态
	       	</th>
	        <th class="span3">
	       	  <span class="line"></span>操作
	       	</th>
	      </tr>
	  	</thead>
	   	<tbody>
	   	<!-- row -->
	   	<c:forEach items="${page.result }" var="admin">
	   	  <tr>
	        <td>
	          <input type="checkbox" />
	        </td>
	        <td class="description">
	            ${admin.id }
	        </td>
	        <td class="description">
	            ${admin.username }
	        </td>
	        <td class="description">
	            ${admin.lastLoginTime }
	        </td>
	        <td class="description">
	            ${admin.lastLoginIP }
	        </td>
	        <td>
	        <c:if test="${admin.status==0 }">
	          <span class="label label-success">启用</span>
	        </c:if>
	        <c:if test="${admin.status==1 }">
	          <span class="label label-error">停用</span>
	        </c:if>
	        </td>
	        <td>
	          <ul class="actions">
	          	<li><i class="table-edit"></i></li>
	           	<li><i class="table-settings"></i></li>
	          	<li class="last"><i class="table-delete"></i></li>
	          </ul>
	        </td>
	   	  </tr>
	   	</c:forEach>
	  	</tbody>
	  </table>
	</div>
	<div class="pagination">
	  <ul>
	  	<li class="disabled"><a class="disabled" href="#">&laquo;</a></li>
	  	<li><a class="active" href="#">1</a></li>
	  	<li class="disabled"><a class="disabled" href="#">2</a></li>
	 	<li class="disabled"><a href="#">3</a></li>
		<li><a href="#">4</a></li>
	  	<li><a href="#">&raquo;</a></li>
	  </ul>
	</div>
  </div>
</body>
</html>