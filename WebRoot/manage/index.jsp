<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="frame.jsp"%>

<% request.setAttribute("navId", "navDashboard"); %>

<!DOCTYPE html>
<html>
<head>
	<title>锋云后台</title>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	
	<!--
	<link href="css/bootstrap.css" rel="stylesheet">
	<link href="css/fontawesome-all.css" rel="stylesheet">
	<script src="js/jquery-3.3.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
	-->
	
	<script type="text/javascript">
		$(window).ready(function(){
			var date = new Date();
			var year = date.getFullYear();
			var month = date.getMonth() + 1;
			var day = date.getDay();
			$('#currentDate').text(year + '年 ' + month + '月 ' + day + '日');
			var h = date.getHours();
			var m = date.getMinutes();
			var s = date.getSeconds();
			m = m < 10 ? '0' + m : m;
			s = s < 10 ? '0' + s : s;
			$('#currentTime').text(h + ':' + m + ':' + s);

			setInterval(function() {
				var date = new Date();
				var h = date.getHours();
				var m = date.getMinutes();
				var s = date.getSeconds();
				m = m < 10 ? '0' + m : m;
				s = s < 10 ? '0' + s : s;
				$('#currentTime').text(h + ':' + m + ':' + s);
			}, 1000);
		});
	</script>
	
	<!-- 导航栏Active -->
	<script type="text/javascript">
		$(window).ready(function(){
			$('#${navId}').addClass('active');
		});
	</script>
	
</head>

<body>
	<div class="container-fluid">
		<nav>
			<ol class="breadcrumb">
				<span>当前位置： </span>
				<li class="breadcrumb-item"><a href="index.jsp">锋云后台</a></li>
				<li class="breadcrumb-item active">系统状态</li>
			</ol>
		</nav>

		<div class="row">
			<!-- 时间 -->
			<div class="col-sm-6 col-md-4 col-lg-3 col-xl-4 mb-4">
				<div class="card bg-light text-center">
					<div class="card-header" id="currentDate"></div>
					<div class="card-body">
						<h1 class="card-title mb-0" id="currentTime">0:00:00</h1>
					</div>
				</div>
			</div>

			<!-- 统计信息 -->
			<div class="col-sm-6 col-md-4 col-lg-3 col-xl-2 mb-4">
				<div class="card bg-primary text-white text-center">
					<div class="card-body">
						<h1 class="card-title mb-0">${userCount}</h1>
					</div>
					<div class="card-footer">网站总用户数</div>
				</div>
			</div>

			<div class="col-sm-6 col-md-4 col-lg-3 col-xl-2 mb-4">
				<div class="card bg-success text-white text-center">
					<div class="card-body">
						<h1 class="card-title mb-0">${houseCount}</h1>
					</div>
					<div class="card-footer">房源总发布数</div>
				</div>
			</div>

			<div class="col-sm-6 col-md-4 col-lg-3 col-xl-2 mb-4">
				<div class="card bg-warning text-white text-center">
					<div class="card-body">
						<h1 class="card-title mb-0">${houseVisitCount}</h1>
					</div>
					<div class="card-footer">房源总浏览量</div>
				</div>
			</div>

			<div class="col-sm-6 col-md-4 col-lg-3 col-xl-2 mb-4">
				<div class="card bg-danger text-white text-center">
					<div class="card-body">
						<h1 class="card-title mb-0">TODO</h1>
					</div>
					<div class="card-footer">房源总收藏量</div>
				</div>
			</div>

		</div>
	</div>
</body>
</html>

