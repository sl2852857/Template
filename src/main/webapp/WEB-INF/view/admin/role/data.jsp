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
	      <span class="line"></span>权限配置
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
	        	<a href="javascript:settingsFunc('${role.id}')">权限配置</a>
	        </td>
	        <td>
	          <ul class="actions">
	          	<li><i class="table-edit" onclick="updateFunc('${role.id}', '${role.name}')" title="编辑"></i></li>
	           	<li><i class="table-settings" onclick="updateStatus('${role.id}', '${role.status }')" title="启用/禁用"></i></li>
	          	<li class="last"><i class="table-delete" onclick="deleteFunc('${role.id}', '${role.status }')" title="删除"></i></li>
	          </ul>
	        </td>
	   	  </tr>
	  </c:forEach>
    </tbody>
  </table>
  
  
  <!-- 模态框（Modal） -->
  <div class="modal fade" id="updateRole" tabindex="-1" role="dialog" 
  	aria-labelledby="myModalLabel" aria-hidden="true" style="display: none">	
	<div class="modal-dialog">
      <div class="modal-content">
         <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                  &times;
            </button>
            <h4 class="modal-title" id="myModalLabel">
               	修改角色信息
            </h4>
         </div>
         <div class="modal-body">
         <form id="update_form">
           <input type="hidden" id="update_id">
           <table style="text-align: center">
           	<tr><td width="50%">角色名称</td><td><input type="text" name="name" id="update_name"/></td></tr>
           </table>
         </form>
         </div>
         <div class="modal-footer">
            <button id="update_close" type="button" class="btn btn-default" 
               data-dismiss="modal">关闭
            </button>
            <button type="button" class="btn btn-primary" id="update_save">
               	保存
            </button>
         </div>
      </div><!-- /.modal-content -->
	</div><!-- /.modal -->
  </div>
  
  <script type="text/javascript">
  	$(function(){
  		$("#update_save").click(function() {
  			var update_id = $("#update_id").val();
  			var update_name = $.trim($("#update_name").val());
  			if(update_name == '') {
  				$("#update_name").focus();
  				return;
  			}
  			$.ajax({
  	  			type: 'GET',
  	  			url: '${base}/admin/role/update.do',
  	  			data: 'id='+update_id+'&name='+encodeURI(encodeURI(update_name)),
  	  			dataType: 'json',
  	  			success: function(msg) {
  	  				if(msg.state != 'success') {
  	  					alert(msg.msg);
  	  				}else {
  	  					$("#updateRole").modal("toggle");
  	  					loadData('');
  	  				}
  	  			}
  	  		})
  		})
  	})
  	
  	//修改角色信息
  	function updateFunc(id, name) {
  		$("#update_id").val(id);
  		$("#update_name").val(name);
  		$("#updateRole").modal("toggle");
  	}
  	
  	//删除角色
  	function deleteFunc(id, status) {
  		if(status == '0') {
  			alert("请先禁用后再删除角色");
  			return;
  		}
  		var q = "确定要删除吗";
  		if(confirm(q)){
  			$.get("${base}/admin/role/delete.do?id="+id, function(msg){
  				if(msg.state!='success') {
  					alert(msg.msg);
  				}else{
  					loadUrl("admin/role/list.do");
  				}
  			});
  		}
  	}
  	
  	//编辑权限
  	function settingsFunc(id){
  		loadUrl('admin/role/editRoot.do?roleID='+id+"&method=edit");
  	}
  	
  	function updateStatus(id, status) {
  		var q = "";
  		if(status == '0') {
  			q = "确认要禁用吗";
  			status = 1;
  		}else {
  			q = "确认要启用吗";
  			status = 0;
  		}
  		if(confirm(q)) {
  			$.ajax({
  				type: 'GET',
  				url: '${base}/admin/role/update.do',
  				data: 'id='+id+'&status='+status,
  				dataType: 'json',
  				success: function(msg) {
  					if(msg.state != 'success') {
  						alert(msg.msg);
  					}else {
  						loadData('');
  					}
  				}
  			})
  		}
  	}
  </script>
</html>