<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/layouts/taglibs.jsp"%>
<html>
  <table class="table table-hover">
	<thead>
	  <tr style="background-color: #f7f7f7">
		<th class="span2">
	      <input type="checkbox" />选择
	   	</th>
	   	<th class="span2">
	      <span class="line"></span>ID
	  	</th>
	 	<th class="span3">
	      <span class="line"></span>用户名称
	   	</th>
	 	<th class="span3">
	      <span class="line"></span>创建时间
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
	      <span class="line"></span>角色详情
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
	        ${admin.createTime }
	      </td>
	      <td class="description">
	        ${admin.lastLoginTime }
	      </td>
	      <td class="description">
	        ${admin.lastLoginIP }
	      </td>
	      <td>
	      <c:if test="${admin.status==0 }">
	        <span class="label label-success">账号正常</span>
	      </c:if>
	      <c:if test="${admin.status==1 }">
	        <span class="label label-error">账号封停</span>
	      </c:if>
	      </td>
	      <td>
	        <a href="javascript:roleDetails('${admin.roleID }')">角色详情</a>
	      </td>
	      <td>
	        <ul class="actions">
	          <li><i class="table-edit" onclick="loadUrl('admin/toAddOrEdit.do?method=edit&id=${admin.id}')" title="编辑"></i></li>
	          <li><i class="table-settings" onclick="updateStatus('${admin.id}', '${admin.status }')" title="启用/禁用"></i></li>
	          <li class="last"><i class="table-delete" onclick="deleteFunc('${admin.id}', '${admin.status }')" title="删除"></i></li>
	        </ul>
	      </td>
	   	</tr>
	  </c:forEach>
    </tbody>
  </table>
  
  
   <!-- 模态框（Modal） -->
  <div class="modal fade" id="details" tabindex="-1" role="dialog" 
  	aria-labelledby="myModalLabel" aria-hidden="true" style="display: none">	
	<div class="modal-dialog">
      <div class="modal-content">
         <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                  &times;
            </button>
            <h4 class="modal-title" id="myModalLabel">
               	用户详情
            </h4>
         </div>
         <div class="modal-body">
           <div>
	           <table style="text-align: center;width: 100%">
	           	<tr><td width="50%"><label>角色名称</label></td><td><label id="lbl_username"></label></td></tr>
	           	<tr><td width="50%"><label>角色状态</label></td><td id="lbl_status"></td></tr>
	           	<tr><td><label>角色拥有菜单</label></td><td>
	           		<table style="text-align: center;width: 100%">
	           			<tr id="details_menus">
	           				<th style="text-align:left">菜单名称</th>
	           				<th>状态</th>
	           			</tr>
	           		</table>
	           	</td></tr>
	           </table>
           </div>
         </div>
         <div class="modal-footer">
            <button id="add_close" type="button" class="btn btn-default" 
               data-dismiss="modal">关闭
            </button>
            <!-- <button type="button" class="btn btn-primary" onclick="add()">
               	保存并配置权限
            </button> -->
         </div>
      </div><!-- /.modal-content -->
	</div><!-- /.modal -->
  </div>
  <script type="text/javascript">
  	$(function(){
  	})
  	
  	//删除角色
  	function deleteFunc(id, status) {
  		if(status == '0') {
  			alert("请先封停后再删除用户");
  			return;
  		}
  		var q = "确定要删除吗";
  		if(confirm(q)){
  			$.get("${base}/admin/delete.do?id="+id, function(msg){
  				if(msg.state!='success') {
  					alert(msg.msg);
  				}else{
  					loadUrl("admin/list.do");
  				}
  			});
  		}
  	}
  	
  	function settingsFunc(id){
  		loadUrl('admin/role/editRoot.do?roleID='+id+"&method=edit");
  	}
  	
  	function updateStatus(id, status) {
  		var q = "";
  		if(status == '0') {
  			q = "确认要封停账号吗";
  			status = 1;
  		}else {
  			q = "确认要恢复账号吗";
  			status = 0;
  		}
  		if(confirm(q)) {
  			$.ajax({
  				type: 'GET',
  				url: '${base}/admin/update.do',
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
  	
  	//查看详情
  	function roleDetails(id) {
  		$.ajax({
			type: 'GET',
			url: '${base}/admin/role/details.do',
			data: 'id='+id,
			dataType: 'json',
			success: function(msg) {
				if(msg.state != 'success') {
					alert(msg.msg);
				}else{
					$("#lbl_username").text(msg.role.name);
					if(msg.role.status==0) {
						//角色正常
						$("#lbl_status").html("<span class=\"label label-success\">角色启用</span>")
					}else {
						$("#lbl_status").html("<span class=\"label label-error\">角色禁用</span>")
					}
					$(".details").remove();
					var text = '';
					for(var i=0;i<msg.role.menuList.length;i++) {
						text += '<tr class=\"details\"><td style=\"text-align:left\">'+msg.role.menuList[i].name+'</td>';
						if(msg.role.menuList[i].status==0) {
							text += '<td><span class=\"label label-success\">菜单启用</span></td>';
						}else {
							text += '<td><span class=\"label label-error\">菜单禁用</span></td>';
						}
						text += '</tr>';
						//循环子菜单
						for(var j=0;j<msg.role.menuList[i].menuList.length;j++) {
							text += '<tr class=\"details\"><td style=\"text-align:left\">&nbsp;&nbsp;└─'+msg.role.menuList[i].menuList[j].name+'</td>';
							if(msg.role.menuList[i].menuList[j].status==0) {
								text += '<td><span class=\"label label-success\">菜单启用</span></td>';
							}else {
								text += '<td><span class=\"label label-error\">菜单禁用</span></td>';
							}
							text += '</tr>';
						}
					}
					$("#details_menus").after(text);
			  		$("#details").modal("toggle");
				}
			}
  		})
  	}
  </script>
</html>