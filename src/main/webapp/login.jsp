<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/layouts/taglibs.jsp" %>
<!DOCTYPE html>
<html class="login-bg">
<head>
	<title>欢迎登陆 Admin 后台管理系统</title>
    
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
    <!-- bootstrap -->
    <link href="${cssPath}/bootstrap/bootstrap.css" rel="stylesheet" />
    <link href="${cssPath}/bootstrap/bootstrap-responsive.css" rel="stylesheet" />
    <link href="${cssPath}/bootstrap/bootstrap-overrides.css" type="text/css" rel="stylesheet" />

    <!-- global styles -->
    <link rel="stylesheet" type="text/css" href="${cssPath}/layout.css" />
    <link rel="stylesheet" type="text/css" href="${cssPath}/elements.css" />
    <link rel="stylesheet" type="text/css" href="${cssPath}/icons.css" />

    <!-- libraries -->
    <link rel="stylesheet" type="text/css" href="${cssPath}/lib/font-awesome.css" />
    
    <!-- this page specific styles -->
    <link rel="stylesheet" href="${cssPath}/compiled/signin.css" type="text/css" media="screen" />

    <!-- open sans font 
    <link href='http://fonts.useso.com/css?family=Open+Sans:300italic,400italic,700italic,800italic,400,300,600,700,800' rel='stylesheet' type='text/css' />
	-->
    <!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /></head>
<body>


    <!-- background switcher -->
    <div class="bg-switch visible-desktop">
        <div class="bgs">
            <a href="#" data-img="landscape.jpg" class="bg active">
                <img src="${imgPath}/bgs/landscape.jpg" />
            </a>
            <a href="#" data-img="blueish.jpg" class="bg">
                <img src="${imgPath}/bgs/blueish.jpg" />
            </a>            
            <a href="#" data-img="7.jpg" class="bg">
                <img src="${imgPath}/bgs/7.jpg" />
            </a>
            <a href="#" data-img="8.jpg" class="bg">
                <img src="${imgPath}/bgs/8.jpg" />
            </a>
            <a href="#" data-img="9.jpg" class="bg">
                <img src="${imgPath}/bgs/9.jpg" />
            </a>
            <a href="#" data-img="10.jpg" class="bg">
                <img src="${imgPath}/bgs/10.jpg" />
            </a>
            <a href="#" data-img="11.jpg" class="bg">
                <img src="${imgPath}/bgs/11.jpg" />
            </a>
        </div>
    </div>


    <div class="row-fluid login-wrapper">
        <a href="index.html">
            <img class="logo" src="${imgPath}/logo-white.png" />
        </a>

        <div class="span4 box">
            <div class="content-wrap">
                <h6>请登录</h6>
                <form>
                <input class="span12" type="text" name="username" id="username" placeholder="请输入用户名" required="required"/>
                <input class="span12" type="password" name="password" id="password" placeholder="请输入密码" required="required"/>
                </form>
                <!-- <a href="#" class="forgot">忘记密码了?</a> -->
                <div class="remember">
                    <input id="remember-me" type="checkbox" />
                    <label for="remember-me">记住密码</label>
                </div>
                <a class="btn-glow primary login" id="signBtn" href="javascript:signIn()">进入系统</a>
            </div>
        </div>

        <div class="span4 no-account">
            <p>还没有帐号？</p>
            <a href="signup.html">用户注册</a>
        </div>
    </div>

	<!-- scripts -->
    <script src="${jsPath}/jquery-latest.js"></script>
    <script src="${jsPath}/jquery.cookie.js"></script>
    <script src="${jsPath}/bootstrap.min.js"></script>
    <script src="${jsPath}/theme.js"></script>

    <!-- pre load bg imgs -->
    <script type="text/javascript">
        $(function () {
        	//cookie加载
        	$("#username").val($.cookie('username'));
        	var cookie_pwd = $.cookie('password');
        	if(cookie_pwd!='null'&&cookie_pwd!='undefined') {
        		$("#remember-me").attr("checked",true);
        		$("#password").val(cookie_pwd);
        	}else {
        		$("#password").val("");
        		$("#remember-me").attr("checked",false);
        	}
            // bg switcher
            var $btns = $(".bg-switch .bg");
            $btns.click(function (e) {
                e.preventDefault();
                $btns.removeClass("active");
                $(this).addClass("active");
                var bg = $(this).data("img");

                $("html").css("background-image", "url('${imgPath}/bgs/" + bg + "')");
            });

        });
        
        //登录验证
        function signIn() {
        	var username = $.trim($("#username").val());
        	var password = $.trim($("#password").val());
        	if(username==''){
        		$("#username").focus();
        		return;
        	}
        	$.cookie('username',username,{expires: 365})
        	if(password==''){
        		$("#password").focus();
        		return;
        	}
        	
        	if($("#remember-me").is(":checked")){
        		$.cookie('password',password,{expires: 365});
        	}else{
        		$.cookie('password',null,{expires: 365});
        	}
        	//限制按钮点击
        	$("#signBtn").removeAttr("href");
        	$("#signBtn").text("正在进入中...");
        	
        	
        	$.ajax({
        		type: 'POST',
        		url: '${base}/admin/login.do',
        		data: $("form").serialize(),
        		dataType: 'json',
        		success: function(res){
        			if(res.state=='success'){
        				//alert('欢迎进入');
        				location.href = '${base}/admin/index.do';
        			}else if(res.state=='failure'){
        				alert(res.msg);
        				$("#signBtn").attr("href","javascript:signIn()");
        	        	$("#signBtn").text("进入系统");
        			}else{
        				alert('系统异常:'+res.msg);
        				$("#signBtn").attr("href","javascript:signIn()");
        	        	$("#signBtn").text("进入系统");
        			}
        		}
        	})
        	
        }
    </script>

</body>
</html>