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

    <!-- this page specific styles -->
    <link rel="stylesheet" href="${cssPath}/compiled/index.css" type="text/css" media="screen" />    

    <!-- open sans font -->
    <link href='http://fonts.useso.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800' rel='stylesheet' type='text/css' />

    <!-- lato font -->
    <link href='http://fonts.useso.com/css?family=Lato:300,400,700,900,300italic,400italic,700italic,900italic' rel='stylesheet' type='text/css' />

    <!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
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
		  <a class="brand" href="index.html"><img src="${imgPath }/logo.png" /></a>
		  <ul class="nav pull-right">                
			<li class="dropdown">
		  	  <a href="#" class="dropdown-toggle hidden-phone" data-toggle="dropdown">
		                        欢迎你&nbsp;${role.name }&nbsp;${loginAdmin.username}
		  		<b class="caret"></b>
		      </a>
		      <ul class="dropdown-menu">
		      	<li><a href="#">个人信息</a></li>
		      	<li><a href="${base }/admin/toUserInfo.do?${loginAdmin.id}">账号设置</a></li>
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
    	  <c:forEach items="${menu.menuList }" var="sonMenu"></c:forEach>
      		<li><a href="javascript:load(${sonMenu.url})">${sonMenu.name }</a></li>
    	  </ul>
  		</li>
  		</c:forEach>       
      </ul>
    </div>
    <!-- end sidebar -->

	<!-- main container -->
    <div class="content" id="content">
		欢迎你
    </div>

	<!-- scripts -->
    <script src="${jsPath}/jquery-latest.js"></script>
    <script src="${jsPath}/bootstrap.min.js"></script>
    <script src="${jsPath}/jquery-ui-1.10.2.custom.min.js"></script>
    <script src="${jsPath}/theme.js"></script>
	<script type="text/javascript">
		function load(url) {
			$("#content").load('${base}/'+url);
		}
	</script>
</body>
</html>