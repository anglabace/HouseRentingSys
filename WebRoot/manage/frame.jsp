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

<!-- 权限校验 -->
<s:if test="#session.user == null">
	<% response.sendRedirect(basePath + "manage.notLogin.action"); %>
</s:if>
<s:elseif test="#session.user.admin == false">
	<% response.sendRedirect(basePath + "manage.notAdmin.action"); %>
</s:elseif>

<!-- 信息显示 -->
<s:elseif test="hasActionErrors() || hasActionMessages()">
	<div id="msgbox"><s:actionerror/><s:actionmessage/></div>
	<script type="text/javascript" src="js/msgbox.js"></script>
</s:elseif>

<!--导航栏-->
<header class="navbar navbar-expand-md navbar-dark bg-dark fixed-top">
	<div class="navbar-brand">
		<h3 class="mt-1 mb-1"><i class="fa fa-chalkboard-teacher"></i> 锋云后台</h3>
	</div>
	<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
		<span class="navbar-toggler-icon"></span>
	</button>
	<div class="collapse navbar-collapse" id="navbarSupportedContent">
		<ul class="navbar-nav mr-auto">
			<li class="nav-item">
				<a class="nav-link" id="navDashboard" href="manage.action">系统状态</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" id="navUser" href="usermanage.findAll.action">用户管理</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" id="navHouse" href="housemanage.findAll.action">房源管理</a>
			</li>
		</ul>
		<ul class="navbar-nav mr-4">
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				    <i class="fa fa-user-circle"></i>
				    管理员： ${user.realname == null ? user.username : user.realname}
				</a>
				<div class="dropdown-menu" aria-labelledby="navbarDropdown">
					<a class="dropdown-item" href="index.action">
					    <i class="fa fa-fw fa-home"></i> 返回网站首页
					</a>
					<a class="dropdown-item" href="user.logout.action">
					    <i class="fa fa-fw fa-sign-out-alt"></i> 退出登录
					</a>
				</div>
			</li>
		</ul>
	</div>
</header>

<!-- 底栏 -->
<jsp:include page="/footer.htm"></jsp:include>
<script type="text/javascript">
	$(window).ready(function(){
		$('footer>div').removeClass('container');
	});
</script>

