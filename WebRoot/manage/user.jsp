<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="frame.jsp"%>

<% request.setAttribute("navId", "navUser"); %>

<!DOCTYPE html>
<html>
<head>
	<title>用户管理 - 锋云后台</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

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
				<li class="breadcrumb-item"><a href="manage.action">锋云后台</a></li>
				<li class="breadcrumb-item active">用户管理</li>
				<span class="ml-auto">
					当前显示第
					${(currentPage - 1) * pageSize + 1}<c:if test="${fn:length(list) > 1}">~${fn:length(list) + (currentPage-1) * pageSize}</c:if>
					条记录，每页显示 ${pageSize} 条
				</span>
			</ol>
		</nav>

		<div class="page-header mb-4">
			<h3><i class="fa fa-user ml-2 mr-2"></i>用户管理</h3>
		</div>

		<div class="table-responsive">
			<table class="table table-hover line-limit-length">
				<tr>
					<th scope="col">ID</th>
					<th scope="col">用户名</th>
					<th scope="col">性别</th>
					<th scope="col">真实姓名</th>
					<th scope="col">手机号</th>
					<th scope="col">邮箱</th>
					<th scope="col">房源数</th>
					<th scope="col">身份</th>
					<th scope="col">注册时间</th>
					<th scope="col">操作</th>
				</tr>
				<s:iterator value="list" var="u">
					<tr>
						<th scope="row">${u.id}</th>
						<td>${u.username}</td>
						<td>
							<s:if test="gender == 1">
								<span class="badge badge-pill badge-primary">男</span>
							</s:if>
							<s:else>
								<span class="badge badge-pill badge-danger">女</span>
							</s:else>
						</td>
						<td>${u.realname}</td>
						<td>${u.phone}</td>
						<td>${u.email}</td>
						<td><s:property value="houseSet.size()"/></td>
						<td>
							<s:if test="admin == true">
								<span class="badge badge-pill badge-warning">管理员</span>
							</s:if>
							<s:else>
								<span class="badge badge-pill badge-light">用户</span>
							</s:else>
						</td>
						<td><fmt:formatDate value="${u.registerTime}" pattern="yyyy-M-d H:mm:ss"/></td>
						<td class="p-2">
							<div class="btn-group btn-group-sm" role="group">
								<c:if test="${u.id != user.id}">
									<s:if test="enabled != false">
										<button class="btn btn-danger" onclick="if(confirm('确认要封禁用户 ${u.username} 吗？')){location.href='usermanage.ban.action?id=${u.id}'}">封禁</button>
									</s:if>
									<s:else>
										<button class="btn btn-success" onclick="if(confirm('确认要为用户 ${u.username} 解封吗？')){location.href='usermanage.unban.action?id=${u.id}'}">解封</button>
									</s:else>
									<s:if test="admin == false">
										<button class="btn btn-warning" onclick="if(confirm('确认要设置 ${u.username} 为管理员吗？')){location.href='usermanage.grantAdmin.action?id=${u.id}'}">设为管理员</button>
									</s:if>
									<s:else>
										<button class="btn btn-secondary" onclick="if(confirm('确认要取消 ${u.username} 的管理员权限吗？')){location.href='usermanage.cancelAdmin.action?id=${u.id}'}">取消管理员</button>
									</s:else>
								</c:if>
							</div>
						</td>
					</tr>
				</s:iterator>
			</table>
		</div>
		
		<nav>
		  <ul class="pagination justify-content-center mt-4">
			<!-- 上翻页 -->
			<s:if test="currentPage == 1">
			    <li class="page-item disabled">
			      <span class="page-link">首页</span>
			    </li>
			    <li class="page-item disabled">
			      <span class="page-link">上一页</span>
			    </li>
			</s:if>
			<s:else>
			    <li class="page-item">
					<a class="page-link" href="usermanage.findAll.action?currentPage=1">首页</a>
			    </li>
			    <li class="page-item">
					<a class="page-link" href="usermanage.findAll.action?currentPage=${currentPage-1}">上一页</a>
			    </li>
			</s:else>
			
			<!-- 页码 -->
			<c:forEach var="p" begin="1" end="${totalPage}">
				<c:choose>
					<c:when test="${p == currentPage}">
					    <li class="page-item active">
					      <span class="page-link">
					        ${p} <span class="sr-only">(current)</span>
					      </span>
					    </li>
					</c:when>
					<c:otherwise>
					    <li class="page-item">
					    	<a class="page-link" href="usermanage.findAll.action?currentPage=${p}">
					    		${p}
					    	</a>
					    </li>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			
		    <!-- 下翻页 -->
			<s:if test="currentPage == totalPage">
			    <li class="page-item disabled">
			      <span class="page-link">下一页</span>
			    </li>
			    <li class="page-item disabled">
			      <span class="page-link">尾页</span>
			    </li>
			</s:if>
			<s:else>
			    <li class="page-item">
					<a class="page-link" href="usermanage.findAll.action?currentPage=${currentPage+1}">下一页</a>
			    </li>
			    <li class="page-item">
					<a class="page-link" href="usermanage.findAll.action?currentPage=${totalPage}">尾页</a>
			    </li>
			</s:else>
		  </ul>
		</nav>
		
	</div>	
</body>
</html>
