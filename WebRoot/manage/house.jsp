<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="frame.jsp"%>

<% request.setAttribute("navId", "navHouse"); %>

<!DOCTYPE html>
<html>
<head>
	<title>房源管理 - 锋云后台</title>
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
				<li class="breadcrumb-item active">房源管理</li>
				<span class="ml-auto">
					当前显示第
					${(currentPage - 1) * pageSize + 1}<c:if test="${fn:length(list) > 1}">~${fn:length(list) + (currentPage-1) * pageSize}</c:if>
					条记录，每页显示 ${pageSize} 条
				</span>
			</ol>
		</nav>

		<div class="page-header mb-4">
			<h3><i class="fa fa-home ml-2 mr-2"></i>房源管理</h3>
		</div>

		<div class="table-responsive">
			<table class="table table-hover line-limit-length">
				<tr>
					<th scope="col">ID</th>
					<th scope="col">标题</th>
					<th scope="col">省份</th>
					<th scope="col">城市</th>
					<th scope="col">区县</th>
					<th scope="col">地址</th>
					<th scope="col">月租金</th>
					<th scope="col">户型</th>
					<th scope="col">面积</th>
					<th scope="col">租赁方式</th>
					<th scope="col">付款方式</th>
					<th scope="col">介绍</th>
					<th scope="col">图片数</th>
					<th scope="col">发布时间</th>
					<th scope="col">操作</th>
				</tr>
				<s:iterator value="list" var="h">
					<tr>
						<th scope="row">${h.id}</th>
						<td style="max-width:10rem">${h.title}</td>
						<td>${h.province}</td>
						<td>${h.city}</td>
						<td>${h.county}</td>
						<td style="max-width:10rem">${h.address}</td>
						<td>${h.price}</td>
						<td>${h.roomCount}室${h.hallCount}厅${h.bathroomCount}卫</td>
						<td>${h.area}m²</td>
						<td>${h.rentMethod}</td>
						<td>押${h.deposit}付${h.deposit}</td>
						<td style="max-width:10rem">${h.intro}</td>
						<td><s:property value="pictures.size()"/></td>
						<td><fmt:formatDate value="${h.publishTime}" pattern="yyyy-M-d H:mm:ss"/></td>
						<td class="p-2">
							<div class="btn-group btn-group-sm" role="group">
								<a class="btn btn-primary" href="house.show.action?id=${h.id}" target="_blank">查看</a>
								<s:if test="status == 1">
									<button class="btn btn-danger" onclick="if(confirm('确认要下架 ${h.title} 吗？')){location.href='housemanage.withdraw.action?id=${h.id}'}">下架</button>
								</s:if>
								<s:else>
									<button class="btn btn-success" onclick="if(confirm('确认要恢复 ${h.title} 吗？')){location.href='housemanage.withdrawRecovery.action?id=${h.id}'}">恢复</button>
								</s:else>
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
					<a class="page-link" href="housemanage.findAll.action?currentPage=1">首页</a>
			    </li>
			    <li class="page-item">
					<a class="page-link" href="housemanage.findAll.action?currentPage=${currentPage-1}">上一页</a>
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
					    	<a class="page-link" href="housemanage.findAll.action?currentPage=${p}">
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
					<a class="page-link" href="housemanage.findAll.action?currentPage=${currentPage+1}">下一页</a>
			    </li>
			    <li class="page-item">
					<a class="page-link" href="housemanage.findAll.action?currentPage=${totalPage}">尾页</a>
			    </li>
			</s:else>
		  </ul>
		</nav>
		
	</div>	
</body>
</html>
