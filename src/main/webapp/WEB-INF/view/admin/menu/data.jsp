<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/layouts/taglibs.jsp"%>
<html>
  <table class="table table-hover">
	<thead>
	  <tr style="background-color: #f7f7f7">
		<th class="span3">
	      <input type="checkbox" />选择
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
	   	<th class="span3">
	      <span class="line"></span>排序
	   	</th>
	  	<th class="span3">
	      <span class="line"></span>操作
	   	</th>
	  </tr>
	</thead>
  	<tbody>
	<!-- row -->
	  <c:forEach items="${menuList }" var="menu">
	  	<tr>
	      <td>
	        <input type="checkbox" />
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
	        <td class="description">
	            ${menu.orderNum }
	        </td>
	        <td>
	          <ul class="actions">
	          	<li><i class="table-edit"></i></li>
	           	<li><i class="table-settings" onclick="settingsFunc('${menu.id}','0','${menu.status}')"></i></li>
	          	<li class="last"><i class="table-delete" onclick="deleteFunc('${menu.id}','0')"></i></li>
	          </ul>
	        </td>
	   	  </tr>
	   	  <c:forEach items="${menu.menuList }" var="sonMenu">
	   	  	<tr style="background-color: #f7f7f7">
		        <td>
		          <input type="checkbox" />
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
		        <td class="description">
		            ${sonMenu.orderNum }
		        </td>
		        <td>
		          <ul class="actions">
		          	<li><i class="table-edit"></i></li>
		           	<li><i class="table-settings" onclick="settingsFunc('${sonMenu.id}','1','${sonMenu.status}')"></i></li>
		          	<li class="last"><i class="table-delete" onclick="deleteFunc('${sonMenu.id}','1')"></i></li>
		          </ul>
		        </td>
		   	  </tr>
	    </c:forEach>
	  </c:forEach>
    </tbody>
  </table>
  
  <script type="text/javascript">
  	function deleteFunc(id, parentID) {
  		var q = "确定要删除吗";
  		if(parentID == '0') {
  			q = "该菜单是主菜单，将会连同删除其所有子菜单，请慎重操作，确定要删除吗";
  		}
  		if(confirm(q)){
  			$.get("${base}/admin/menu/delete.do?ids="+id, function(msg){
  				if(msg.state!='success') {
  					alert(msg.msg);
  				}else{
  					loadData();
  				}
  			});
  		}
  	}
  	
  	function settingsFunc(id, parentID, status){
  		var q = '';
  		if(parentID=='0'&&status=='0') {
  			q = "禁用主菜单等同禁止其所有子菜单，";
  		};
  		if(status=='0') {
  			status = '1';
  			q += "确定要禁用吗";
  		}else {
  			status = '0';
  			q += "确定要启用吗";
  		}
  		
  		if(confirm(q)) {
  			$.ajax({
  				url: '${base}/admin/menu/update.do?id='+id+'&status='+status,
  				type: 'GET',
  				dataType: 'json',
  				success: function(msg) {
  					if(msg.state!='success') {
  						alert(msg.msg);
  					}else {
  						loadData();
  					}
  				}
  			})
  		}
  	}
  </script>
</html>