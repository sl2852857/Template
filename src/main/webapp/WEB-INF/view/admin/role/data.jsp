<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/layouts/taglibs.jsp"%>
<html>
  <table class="table table-hover">
	<thead>
	  <tr style="background-color: #f7f7f7">
		<!-- <th class="span3">
	      <input type="checkbox" />选择
	   	</th> -->
	   	<th class="span3">
	      <span class="line"></span>ID
	  	</th>
	 	<th class="span3">
	      <span class="line"></span>角色名称
	   	</th>
	 	<th class="span3">
	      <span class="line"></span>创建时间
	   	</th>
	 	<th class="span3">
	      <span class="line"></span>最后更新时间
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
	  <c:forEach items="${page.result }" var="role">
	  	<tr>
	      <!-- <td>
	        <input type="checkbox" />
	      </td> -->
	      <td class="description">
	      	${role.id }
	      </td>
	        <td class="description">
	            ${role.name }
	        </td>
	        <td class="description">
	            ${role.createTime }
	        </td>
	        <td class="description">
	            ${role.lastUpdateTime }
	        </td>
	        <td>
	        <c:if test="${role.status==0 }">
	          <span class="label label-success">启用</span>
	        </c:if>
	        <c:if test="${role.status==1 }">
	          <span class="label label-error">禁用</span>
	        </c:if>
	        </td>
	        <td>
	          <ul class="actions">
	          	<li><i class="table-edit" onclick="updateFunc()" title="编辑"></i></li>
	           	<li><i class="table-settings" onclick="settingsFunc('${role.id}')" title="权限管理"></i></li>
	          	<li class="last"><i class="table-delete" onclick="deleteFunc()" title="删除"></i></li>
	          </ul>
	        </td>
	   	  </tr>
	  </c:forEach>
    </tbody>
  </table>
  
  
  <script type="text/javascript">
  	function deleteFunc(id) {
  		var q = "确定要删除吗";
  		if(confirm(q)){
  			$.get("${base}/admin/menu/delete.do?ids="+id, function(msg){
  				if(msg.state!='success') {
  					alert(msg.msg);
  				}else{
  					loadUrl("admin/menu/list.do");
  				}
  			});
  		}
  	}
  	
  	function settingsFunc(id){
  		loadUrl('admin/role/editRoot.do?roleID='+id+"&method=edit");
  	}
  </script>
</html>