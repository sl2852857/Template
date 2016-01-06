<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/layouts/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<title>Detail Admin - Home</title>
    
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
    <!-- bootstrap -->
    <link href="${cssPath}/bootstrap/bootstrap.css" rel="stylesheet" />
    <link href="${cssPath}/bootstrap/bootstrap-responsive.css" rel="stylesheet" />
    <link href="${cssPath}/bootstrap/bootstrap-overrides.css" type="text/css" rel="stylesheet" />

    <!-- libraries -->
    <link href="${cssPath}/lib/jquery-ui-1.10.2.custom.css" rel="stylesheet" type="text/css" />
    <link href="${cssPath}/lib/font-awesome.css" type="text/css" rel="stylesheet" />

    <!-- global styles -->
    <link rel="stylesheet" type="text/css" href="${cssPath}/layout.css" />
    <link rel="stylesheet" type="text/css" href="${cssPath}/elements.css" />
    <link rel="stylesheet" type="text/css" href="${cssPath}/icons.css" />

	<!-- Pagination 分页 -->
	<link rel="stylesheet" type="text/css" href="${cssPath }/pagination.css">
    <!-- this page specific styles -->
    <link rel="stylesheet" href="${cssPath}/compiled/index.css" type="text/css" media="screen" />    

    <!-- open sans font 
    <link href='http://fonts.useso.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800' rel='stylesheet' type='text/css' />
	-->
    <!-- lato font 
    <link href='http://fonts.useso.com/css?family=Lato:300,400,700,900,300italic,400italic,700italic,900italic' rel='stylesheet' type='text/css' />
	-->
    <!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	
	<style type="text/css">
		#content {
			padding: 5px;
		}
	</style>
</head>
<body>

    <!-- navbar -->
    <div class="navbar navbar-inverse" id="navbar">
    	<div class="navbar-inner">
		  <button type="button" class="btn btn-navbar visible-phone" id="menu-toggler">
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
		  </button>
		  <a class="brand" href="${base }/admin/index.do"><img src="${imgPath }/logo.png" /></a>
		  <ul class="nav pull-right">                
			<li class="dropdown">
		  	  <a href="#" class="dropdown-toggle hidden-phone" data-toggle="dropdown">
		      	${role.name }&nbsp;${loginAdmin.username}
		  		<b class="caret"></b>
		      </a>
		      <ul class="dropdown-menu">
		      	<li><a href="javascript:myInfo('${loginAdmin.id }', '${loginAdmin.roleID }')">个人信息</a></li>
		      	<li><a href="javascript:myPwd('${loginAdmin.id }')">账号设置</a></li>
		      </ul>
		   	</li>
		  	<li class="settings hidden-phone">
		  	  <a href="javascript:logout()" role="button">
		      	<i class="icon-share-alt"></i>
		      </a>
			</li>
		  </ul>            
		</div>
    </div>
    <!-- end navbar -->

    <!-- sidebar -->
    <div id="sidebar-nav">
	  <ul id="dashboard-menu">
  		<li class="active">
		  <div class="pointer">
 	  		<div class="arrow"></div>
  	  		<div class="arrow_border"></div>
  		  </div>
   		  <a href="${base }/admin/index.do">
      	  	<i class="icon-home"></i>
      	    <span>Home</span>
    	  </a>
  		</li>
  		<c:forEach items="${role.menuList }" var="menu">
  		<li>
    	  <a class="dropdown-toggle" href="#">
      		<i class="icon-group"></i>
      		<span>${menu.name }</span>
      		<i class="icon-chevron-down"></i>
    	  </a>
    	  <ul class="submenu">
    	  <c:forEach items="${menu.menuList }" var="sonMenu">
      		<li><a href="javascript:loadUrl('${sonMenu.url}')">${sonMenu.name }</a></li>
      	  </c:forEach>
    	  </ul>
  		</li>
  		</c:forEach>       
      </ul>
    </div>
    <!-- end sidebar -->

	<!-- main container -->
    <div class="content" id="content">
		<h4>您好，${role.name}${loginAdmin.username} ，您最近登录IP为：<font color="red">${loginAdmin.lastLoginIP }</font>，最近登录时间为：<font color="red">${loginAdmin.lastLoginTime }</font></h4>
    </div>

	<!-- scripts -->
    <script src="${jsPath}/jquery-latest.js"></script>
    <script src="${jsPath}/bootstrap.min.js"></script>
    <script src="${jsPath}/jquery-ui-1.10.2.custom.min.js"></script>
    <script src="${jsPath}/theme.js"></script>
    <script src="${jsPath}/jquery.cookie.js"></script>
    <script src="${jsPath}/jquerysession.js"></script>
    
    <!-- Pagination 分页 -->
    <script src="${jsPath }/jquery.pagination.js"></script>
    
	<script type="text/javascript">
		function loadUrl(url) {
			$.get(
				'${base}/'+url,function(html){
					$("#content").html(html);
				}
			)
		}
		
		function logout() {
			if(confirm('确认退出？')){
				$.ajax({
					url: '${base}/admin/logout.do',
					type: 'GET',
					dataType: 'json',
					success: function(res) {
						if(res.state == 'success') {
							alert('退出成功');
						}else{
							alert('异常退出，错误信息：'+res.msg);
						}
						location.href = '${base}/login.jsp';
					}
				})
			}
		}
		
		//我的信息
		function myInfo(admin_id, role_id) {
			if(role_id==''){
				$("#info_role").text("系统管理员");
			}else {
				$.ajax({
					type: 'GET',
					url: '${base}/admin/role/details.do',
					data: 'id='+role_id,
					dataType: 'json',
					success: function(msg) {
						if(msg.state != 'success') {
							alert(msg.msg);
						}else {
							$("#info_role").text(msg.role.name);
						}
					}
				})
			}
			$.ajax({
				type: 'GET',
				url: '${base}/admin/details.do',
				data: 'id='+admin_id,
				dataType: 'json',
				success: function(msg) {
					if(msg.state != 'success') {
						alert(msg.msg);
					}else {
						$("#info_email").val(msg.admin.email);
						$("#info_tel").val(msg.admin.tel);
					}
				}
			})
			$("#myInfo").modal("toggle");
		}
		
		function check_myInfoEmail() {
			var email = $.trim($("#info_email").val());
	  		if(email != '') {
	  			//若有内容，验证格式，若没有，则可通过
	  			var reg = /^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/;
	  			if(!reg.test(email)) {
	  				//格式不正确
		  			return false;
	  			}else {
		  			return true;
	  			}
	  		}else {
	  			return true;
	  		}
		}	
	
	  	function check_myInfoTel() {
		  	var tel = $.trim($("#info_tel").val());
		  	if(tel != '') {
		  		//若有内容，验证格式，若没有，则可通过
		  		var reg = /^(13[0-9]|14[0-9]|15[0-9]|18[0-9])\d{8}$/i;
		  		if(!reg.test(tel)) {
		  			//格式不正确
			  		return false;
		  		}else {
			  		return true;
		  		}
		  	}else {
		  		return true;
		  	}
		 }
	  	
	  	//保存信息
	  	function saveMyInfo() {
	  		if(!check_myInfoEmail()) {
	  			alert("邮箱格式不正确");
	  			$("#info_email").focus();
	  			return;
	  		}
	  		if(!check_myInfoTel()) {
	  			alert("手机号码格式不正确");
	  			$("#info_tel").focus();
	  			return;
	  		}
	  		$.ajax({
	  			type: 'POST',
	  			url: '${base}/admin/update.do',
	  			data: $("#info_form").serialize(),
	  			dataType: 'json',
	  			success: function(msg) {
	  				if(msg.state != 'success') {
	  					alert(msg.msg);
	  				}else {
	  					alert("保存成功");
	  					$("#myInfo").modal("toggle");
	  				}
	  			}
	  		})
	  	}
	  	
	  	//修改密码
	  	function myPwd(){
	  		$("#myPwd").modal("toggle");
	  	}
	  	
		//提交修改密码
		function saveMyPwd() {
			var oldPwd = $.trim($("#myPwd_old").val());
			var newPwd = $.trim($("#myPwd_new").val());
			var reNewPwd = $.trim($("#myPwd_re_new").val());
			

			if(oldPwd =='') {
				$("#myPwd_old").focus();
				return;
			}
			
			if(newPwd.length<3 || newPwd.length>10) {
				alert("请输入3至10位长度的新密码");
				$("#myPwd_new").focus();
				return;
			}
			if(reNewPwd != newPwd) {
				alert("密码确认不一致");
				$("#myPwd_re_new").focus();
				return;
			}
			
			$.ajax({
				type: 'POST',
				url: '${base}/admin/updatePwd.do',
				data: $("#myPwd_form").serialize(),
				dataType: 'json',
				success: function(msg) {
					if(msg.state != 'success') {
						alert(msg.msg);
					}else {
						alert("修改成功");
						$("#myPwd_form")[0].reset();
						$("#myPwd").modal("toggle");
					}
				}
			})
		}
	</script>
	
	<!-- 模态框（Modal） -->
  <div class="modal fade" id="myInfo" tabindex="-1" role="dialog" 
  	aria-labelledby="myModalLabel" aria-hidden="true" style="display: none">	
	<div class="modal-dialog">
      <div class="modal-content">
		<div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                  &times;
            </button>
            <h4 class="modal-title" id="myModalLabel">
               	我的个人信息
            </h4>
        </div>
        <div class="modal-body">
    	  <form id="info_form">
    	    <input type="hidden" name="id" value="${loginAdmin.id }">
   	        <table style="text-align: center">
           	 <tr><td width="50%">用户名</td><td><label id="info_username">${loginAdmin.username }</label></td></tr>
           	 <tr><td>邮箱</td><td><input type="text" name="name" id="info_email"/></td></tr>
           	 <tr><td>手机号码</td><td><input type="text" name="tel" id="info_tel"/></td></tr>
           	 <tr><td>用户角色</td><td><label id="info_role"></label></td></tr>
            </table>
          </form>
        </div>
         <div class="modal-footer">
            <button id="update_close" type="button" class="btn btn-default" 
               data-dismiss="modal">关闭
            </button>
            <button type="button" class="btn btn-primary" onclick="saveMyInfo()">
               	保存
            </button>
         </div>
      </div><!-- /.modal-content -->
	</div><!-- /.modal -->
  </div>
  
  <!-- 模态框（Modal） -->
  <div class="modal fade" id="myPwd" tabindex="-1" role="dialog" 
  	aria-labelledby="myModalLabel" aria-hidden="true" style="display: none">	
	<div class="modal-dialog">
      <div class="modal-content">
		<div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                  &times;
            </button>
            <h4 class="modal-title" id="myModalLabel">
               	账号设置 -> <small>修改密码</small>
            </h4>
        </div>
        <div class="modal-body">
    	  <form id="myPwd_form">
    	    <input type="hidden" name="id" value="${loginAdmin.id }">
   	        <table style="text-align: center">
           	 <tr><td width="50%">旧密码</td><td><input type="password" name="oldPwd" id="myPwd_old" placeholder="请输入旧密码"/></td></tr>
           	 <tr><td>新密码</td><td><input type="password" name="newPwd" id="myPwd_new" placeholder="请输入3至10位长度新密码"/></td></tr>
           	 <tr><td>新密码确认</td><td><input type="password"id="myPwd_re_new" placeholder="请再次输入新密码"/></td></tr>
            </table>
          </form>
        </div>
         <div class="modal-footer">
            <button id="update_close" type="button" class="btn btn-default" 
               data-dismiss="modal">关闭
            </button>
            <button type="button" class="btn btn-primary" onclick="saveMyPwd()">
               	保存
            </button>
         </div>
      </div><!-- /.modal-content -->
	</div><!-- /.modal -->
  </div>
</body>
</html>