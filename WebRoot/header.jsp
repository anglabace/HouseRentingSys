<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<base href="<%=basePath%>">

<!--
<link href="https://cdn.bootcss.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.bootcss.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
<script src="https://cdn.bootcss.com/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdn.bootcss.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
-->
<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/fontawesome-all.css" rel="stylesheet">
<script src="js/jquery-3.3.1.min.js"></script>
<script src="js/bootstrap.js"></script>

<link href="css/styles.css" rel="stylesheet">

<!-- 信息显示 -->
<s:if test="hasActionErrors() || hasActionMessages()">
	<div id="msgbox"><s:actionerror/><s:actionmessage/></div>
	<script type="text/javascript" src="js/msgbox.js"></script>
</s:if>

<!--导航栏-->
<header class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
	<div class="container">
		<div class="navbar-brand">
			<h3 class="mt-1 mb-1"><i class="fa fa-home"></i> 锋云租房</h3>
		</div>
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item">
					<a class="nav-link" href="index.jsp">首页</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="index.jsp">最新</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="index.jsp">热门</a>
				</li>
			</ul>
			<ul class="navbar-nav mr-4">
				<s:if test="#session.user == null">
					<li class="nav-item">
						<a class="nav-link" href="#modal-container-login" data-toggle="modal">登录</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="#modal-container-register" data-toggle="modal">注册</a>
					</li>
				</s:if>
				<s:else>
					<li class="nav-item dropdown">
						<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						    <i class="fa fa-user-circle"></i>
                            ${user.realname == null ? user.username : user.realname}
							${user.admin == true ? " (管理员)" : ""}
						</a>
						<div class="dropdown-menu" aria-labelledby="navbarDropdown">
							<s:if test="#session.user.admin == 1">
								<a class="dropdown-item" href="manage.action">
								    <i class="fa fa-fw fa-chalkboard-teacher"></i> 进入系统后台
								</a>
								<div class="dropdown-divider"></div>
							</s:if>
							<a class="dropdown-item" href="house_publish.jsp">
							    <i class="fa fa-fw fa-cloud-upload-alt"></i> 发布房源
							</a>
							<!-- 
							<div class="dropdown-divider"></div>
							<a class="dropdown-item" href="mypublish.action">
							    <i class="fa fa-fw fa-home"></i> 我的发布
							</a> -->
							<a class="dropdown-item" href="user.profile.action">
							    <i class="fa fa-fw fa-cog"></i> 个人资料
							</a>
							<div class="dropdown-divider"></div>
							<a class="dropdown-item" href="user.logout.action">
							    <i class="fa fa-fw fa-sign-out-alt"></i> 退出登录
							</a>
						</div>
					</li>
				</s:else>
			</ul>
			<!-- 
			<form class="form-inline my-2 my-lg-0" action="SearchNews" method="post">
				<div class="input-group">
					<input class="form-control" name="keyword" type="search" placeholder="输入关键字" aria-label="Search">
					<div class="input-group-append">
						<button class="btn btn-success" type="submit"><i class="fa fa-search"></i> 搜你想要</button>
					</div>
				</div>
			</form> -->
		</div>
	</div>
</header>

<!-- 登录模态窗口 -->
<div class="modal fade" id="modal-container-login" role="dialog" aria-hidden="true" aria-labelledby="loginModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="loginModalLabel">用户登录</h5> 
				<button class="close" type="button" data-dismiss="modal">
					<span aria-hidden="true">×</span>
				</button>
			</div>
			<s:form class="mb-0" role="form" id="loginForm" namespace="/" action="user.login" method="post" onsubmit="return validateLogin()">
				<div class="modal-body">
					<div class="form-group">
						<label for="loginUsername">用户名</label>
						<input class="form-control lastpassClearHidden" id="loginUsername" name="username" type="text" placeholder="请输入用户名" required/>
					</div>
					<div class="form-group">
						<label for="loginPassword">密码</label>
						<input class="form-control lastpassClearHidden" id="loginPassword" name="password" type="password" placeholder="请输入密码" required/>
					</div>
					<div class="checkbox">
						<label>
							<input type="checkbox" id="loginRememberUsername"/> 记住用户名
						</label>
					</div> 
				</div>
				<div class="modal-footer">
					<button class="btn btn-primary btn-block" id="btnLogin" type="submit">
						<i class="fa fa-spinner fa-spin mr-2"></i>登录
					</button> 
					<a class="btn btn-link" href="#modal-container-register" data-dismiss="modal" data-toggle="modal">还没有账号？点此注册</a>
				</div>
			</s:form>
		</div>
	</div>
</div>
			
<!-- 注册模态窗口 -->
<div class="modal fade" id="modal-container-register" role="dialog" aria-hidden="true" aria-labelledby="registerModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="registerModalLabel">新用户注册</h5> 
				<button class="close" type="button" data-dismiss="modal">
					<span aria-hidden="true">×</span>
				</button>
			</div>
			<s:form class="mb-0" role="form" id="registerForm" namespace="/" action="user.reg" method="post" onsubmit="return validateReg()">
				<div class="modal-body">
					<div class="form-group">
						<label for="regUsername">用户名</label>
						<input class="form-control lastpassClearHidden" id="regUsername" name="username" type="text" placeholder="4~16位字母或数字，不能以数字开头" required/>
					</div>
					<div class="form-group">
						<div class="text-danger" id="usernameCheck"></div>
					</div>
					<div class="form-group">
						<label for="regPassword">密码</label>
						<input class="form-control lastpassClearHidden" id="regPassword" name="password" type="password" placeholder="4~16位字母或数字" required/>
					</div>
					<div class="form-group">
						<label for="regPassword2">重复密码</label>
						<input class="form-control lastpassClearHidden" id="regPassword2" type="password" placeholder="再次输入密码" required/>
					</div>
					<div class="form-group text-danger" id="regError">
						<i class="fa fa-exclamation-circle mr-2"></i><span id="regErrorMsg"></span>
					</div>
				</div>
				<div class="modal-footer">
					<button class="btn btn-primary btn-block" id="btnRegister" type="submit">
						<i class="fa fa-spinner fa-spin mr-2"></i>注册
					</button> 
					<a class="btn btn-link" href="#modal-container-login" data-dismiss="modal" data-toggle="modal">已有账号？点此登录</a>
				</div>
			</s:form>
		</div>
	</div>
</div>

<!-- 登陆注册表单验证 -->
<script type="text/javascript">
	var usernameVerified = false;
	
	// 用户名验证
	function checkUsernameExist(){
		usernameVerified = false;
		
		var username = $('#regUsername').val();
		
		if(username == ''){
			$('#usernameCheck').removeClass();
			$('#usernameCheck').addClass('text-danger');
			$('#usernameCheck').html('<i class="fa fa-exclamation-circle mr-2"></i>请输入用户名');
			$('#usernameCheck').show(200);
		} else {
			$('#usernameCheck').removeClass();
			$('#usernameCheck').addClass('text-secondary');
			$('#usernameCheck').html('<i class="fa fa-spinner fa-spin mr-2"></i>正在检查用户名');
			$('#usernameCheck').show(200);
			
			$.get('user.checkUserExist.action?username='+username, function(data,status){
				$('#usernameCheck').removeClass();
				if(status == 'success' && data == 'usable'){
					$('#usernameCheck').addClass('text-success');
					$('#usernameCheck').html('<i class="fa fa-check-circle mr-2"></i>用户名可用');
					usernameVerified = true;
				} else if (status == 'success'){
					$('#usernameCheck').addClass('text-danger');
					$('#usernameCheck').html('<i class="fa fa-exclamation-circle mr-2"></i>用户名已存在');
				} else {
					$('#usernameCheck').addClass('text-warning');
					$('#usernameCheck').html('<i class="fa fa-exclamation-circle mr-2"></i>检查失败，请重试');
				}
				$('#usernameCheck').show(200);
			});
		}
	}
	
	// 登录验证
	function validateLogin(){
		if($('#loginRememberUsername').prop('checked')){
			localStorage.setItem('username', $('#loginUsername').val());
		} else if(localStorage.getItem('username') != null){
			localStorage.removeItem('username');
		}
	
		$("#btnLogin i").show(200);
		
		return true;
	}
	
	// 注册验证
	function validateReg(){
		$('#regError').hide(200);

		var isValid = true;
		var errorMsg;
		
		if($('#regPassword').val() != $('#regPassword2').val()){
			isValid = false;
			errorMsg = '两次输入的密码不一致';
		}
		
		if(isValid && usernameVerified){
			$('#btnRegister i').show(200);
			return true;
		} else if (isValid) {
			$('#usernameCheck').fadeOut(100, function(){
				$('#usernameCheck').fadeIn(150, function(){
					$('#usernameCheck').fadeOut(100, function(){
						$('#usernameCheck').fadeIn(150);
					});
				});
			});
			return false;
		} else {
			$('#regErrorMsg').text(errorMsg);
			$('#regError').show(200);
			return false;
		}
	}

	$(document).ready(function() {
		// 获取保存的用户名
		var savedUsername = localStorage.getItem('username');
		if(savedUsername != null){
			$('#loginUsername').val(savedUsername);
			$('#loginRememberUsername').prop('checked', true);
		}

		// 隐藏登录注册动画
		$('button#btnLogin i').hide();
		$('button#btnRegister i').hide();
		
		// 隐藏提示信息
		$('#usernameCheck').hide();
		$('#regError').hide();
		
		// 事件注册
		$('#regUsername').on('blur', checkUsernameExist);
	});
</script>


