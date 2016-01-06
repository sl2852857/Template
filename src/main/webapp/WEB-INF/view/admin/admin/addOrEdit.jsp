<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/layouts/taglibs.jsp"%>
<!DOCTYPE html>
<html>
  <div class="table-products section">
	<div class="row-fluid head">
	  <div class="span12">
		<h4>系统用户管理<small>>> 添加用户 </small></h4>
	  </div>
	</div>
	<div class="row-fluid filter-block">
	  <div class="left">
		<a class="btn-flat new-product" href='javascript:addAdmin()'>+ 保存信息</a>
		&nbsp;&nbsp;
		<a class="btn-flat new-product" href="javascript:loadUrl('admin/list.do')">&lt; 返回</a>
	  </div>
	</div>
	<div class="row-fluid">
	<form id="admin_form">
	<input type="hidden" name="id" value="${admin.id }">
	<div class="span8 column">
      <c:if test="${method eq 'add' }">
      <div class="field-box">
        <label>用户名:</label>
        <input class="span8 inline-input" id="username" name="username" type="text" value="" placeholder="请输入用户"/>
        <div class="alert alert-danger" id="username_alert" style="display: none;">请输入用户名</div>
      </div>
      <div class="field-box">
        <label>密码:</label>
        <input class="span8 inline-input" id="password" name="password" placeholder="请输入3至10位长度的密码" type="password" />
        <div class="alert alert-danger" id="pwd_alert" style="display: none;">请输入3至10位长度的密码</div>
      </div>                        
      <div class="field-box">
        <label>密码确认:</label>
        <input class="span8 inline-input" id="repassword" placeholder="请再次输入密码" type="password" />
        <div class="alert alert-danger" id="repwd_alert" style="display: none;">请保持密码一致</div>
      </div>                            
      </c:if>
      <c:if test="${method eq 'edit' }">
      <div class="field-box">
        <label>用户名:</label>
        <input class="span8 inline-input" id="username" name="username" type="text" value="${admin.username }" readonly/>
        <div class="alert alert-danger" id="username_alert" style="display: none;">请输入用户名</div>
      </div>
      </c:if>
      <div class="field-box">
        <label>邮箱:</label>
        <input class="span8 inline-input" id="email" name="email" type="text" placeholder="请输入邮箱" value="${admin.email }"/>
        <div class="alert alert-danger" id="email_alert" style="display: none;">请输入格式正确的邮箱</div>
      </div>
      <div class="field-box">
        <label>手机号码:</label>
        <input class="span8 inline-input" id="tel" name="tel" type="text" placeholder="请输入手机号码" value="${admin.tel }"/>
        <div class="alert alert-danger" id="tel_alert" style="display: none;">请输入格式正确的手机号码</div>
      </div>
      <div class="field-box">
        <label>系统角色选择:</label>
        <div class="ui-select">
          <c:if test="${method eq 'add' }">
		  <select id="roleID" name="roleID">
		  	<option selected="selected" value="0">请选择角色</option>
		  	<c:forEach items="${page.result }" var="role">
			  <option value="${role.id }">${role.name }</option>
		  	</c:forEach>
		  </select>
          </c:if>
          <c:if test="${method eq 'edit' }">
		  <select id="roleID" name="roleID">
		  	<c:forEach items="${page.result }" var="role">
		  	  <c:if test="${role.id == admin.roleID}">
			    <option value="${role.id }" selected="selected">${role.name }</option>
			    <c:set var="flag" value="${role.id }"></c:set>
		  	  </c:if>
		  	</c:forEach>
		  	<c:forEach items="${page.result }" var="role">
		  	  <c:if test="${flag != role.id }">
			    <option value="${role.id }">${role.name }</option>
		  	  </c:if>
		  	</c:forEach>
		  </select>
          </c:if>
		</div>
      </div>
      <div class="field-box">
        <label>账号状态:</label>
        <div class="slider-frame primary">
          <c:if test="${method eq 'add' }">
            <input type="hidden" id="status" name="status" value="0"/>
		    <span id="select_status" class="slider-button on" data-off-text="禁用" data-on-text="启用">启用</span>
          </c:if>
          <c:if test="${method eq 'edit' }">
            <input type="hidden" id="status" name="status" value="${admin.status }"/>
            <c:if test="${admin.status == 0 }">
		      <span id="select_status" class="slider-button on" data-off-text="禁用" data-on-text="启用">启用</span>
            </c:if>
            <c:if test="${admin.status == 1 }">
		      <span id="select_status" class="slider-button" data-off-text="禁用" data-on-text="启用">禁用</span>
            </c:if>
          </c:if>
		</div>
      </div>
    </div>
  </form>
  </div>
  </div>
  
  <script type="text/javascript">
  	var username_flag = false;
  	var pwd_flag = false;
  	var repwd_flag = false;
  	var email_flag = true;//默认邮箱可以不填
  	var tel_flag = true;//默认联系方式可以不填
  	$(function(){
  		$("#select_status").click(function() {
	  		$(this).toggleClass("on");
	  		if($(this).html()=='禁用') {
	  			$("#status").val(0);
	  			$(this).html("启用");
	  		}else {
	  			$("#status").val(1);
	  			$(this).html("禁用");
	  		}
	  	})
	  	
	  	$("#username").focusout(function(){
	  		var username = $.trim($("#username").val());
	  		if(username == '') {
	  			$("#username_alert").show();
	  			username_flag = false;
	  		}else {
	  			$("#username_alert").hide();
	  			username_flag = true;
	  		}
	  	})
	  	$("#password").focusout(function(){
	  		var pwd_length = parseInt($.trim($("#password").val()).length);
	  		if(pwd_length<3||pwd_length>10) {
	  			$("#pwd_alert").show();
	  			pwd_flag = false;
	  		}else {
	  			$("#pwd_alert").hide();
	  			pwd_flag = true;
	  		}
	  	})
	  	$("#repassword").focusout(function(){
	  		var pwd = $.trim($("#password").val());
	  		var repwd = $.trim($("#repassword").val());
	  		if(pwd!=repwd) {
	  			$("#repwd_alert").show();
	  			repwd_flag = false;
	  		}else {
	  			$("#repwd_alert").hide();
	  			repwd_flag = true;
	  		}
	  	})
	  	$("#email").focusout(function(){
	  		check_email()
	  	})
	  	
	  	$("#tel").focusout(function(){
  			check_tel();
  		})
  	})
  	
  	function check_email() {
			var email = $.trim($("#email").val());
  		if(email != '') {
  			//若有内容，验证格式，若没有，则可通过
  			var reg = /^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/;
  			if(!reg.test(email)) {
  				//格式不正确
	  			$("#email_alert").show();
	  			return false;
  			}else {
	  			$("#email_alert").hide();
	  			return true;
  			}
  		}else {
  			$("#email_alert").hide();
  			return true;
  		}
	}
  	
	
  	function check_tel() {
	  	var tel = $.trim($("#tel").val());
	  	if(tel != '') {
	  		//若有内容，验证格式，若没有，则可通过
	  		var reg = /^(13[0-9]|14[0-9]|15[0-9]|18[0-9])\d{8}$/i;
	  		if(!reg.test(tel)) {
	  			//格式不正确
		  		$("#tel_alert").show();
		  		return false;
	  		}else {
		  		$("#tel_alert").hide();
		  		return true;
	  		}
	  	}else {
	  		$("#tel_alert").hide();
	  		return true;
	  	}
	 }
  	
  	
  	
  	//保存用户
  	function addAdmin() {
  		var method = '${method}';
  		if(method=='add') {
  			if(!username_flag) {
	  			$("#username").focus();
	  			return;
  			}
  		
	  		if(!pwd_flag) {
	  			$("#password").focus();
	  			return;
	  		}
	  		
	  		if(!repwd_flag) {
	  			$("#repassword").focus();
	  			return;
	  		}
  		}
  		
	  	if(!check_email()) {
	  		$("#email").focus();
	  		return;
	  	}
	  	if(!check_tel()) {
	  		$("#tel").focus();
	  		return;
	  	}
  		
  		var roleID = $("#roleID").val();
  		if(roleID == 0) {
  			$("#roleID").focus();
  			return;
  		}
  		
  		if(method == 'add') {
  			url = '${base}/admin/add.do';
  		}else if (method == 'edit') {
  			url = '${base}/admin/update.do';
  		}else {
  			alert('method = '+method);
  		}
  		$.ajax({
  			type: 'POST',
  			url: url,
  			data: $("#admin_form").serialize(),
  			dataType: 'json',
  			success: function(msg) {
  				if(msg.state!='success') {
  					alert(msg.msg);
  				}else {
  					alert("保存成功");
  					loadUrl("admin/list.do");
  				}
  			}
  		})
  	}
  </script>
</html>