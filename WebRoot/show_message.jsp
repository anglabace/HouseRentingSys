<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="header.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <title>提示信息 - 锋云租房</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
    </head>
    
    <body>
        <div class="container">
            <nav>
                <ol class="breadcrumb">
                    <span>当前位置： </span>
                    <li class="breadcrumb-item">
                        <a href="index.jsp">锋云租房</a>
                    </li>
                    <li class="breadcrumb-item active">提示信息</li>
                </ol>
            </nav>
            
           	<div class="page-header mt-5 text-center text-muted">
                <h1 class="mb-4">跳转中</h1>
				<h5>
					<i class="fa fa-hourglass-start fa-spin mr-2"></i>
					<span id="timerProgress">
						<span id="timer"></span>
						秒后自动
						<a href="index.jsp">跳转到首页</a>
					</span>
				</h5>
            </div>
        </div>
        
        <!-- 自动跳转 -->
        <script type="text/javascript">
			var timeSec = 3;
			$('#timer').html(timeSec);
			
			var redirectTimer = setInterval(function() {
				timeSec--;
				if (timeSec > 0) {
					$('#timer').html(timeSec);
				} else {
					$('#timerProgress').html('自动跳转中...');
					location.href = "index.jsp";
					clearInterval(redirectTimer);
				}
			}, 1000);
		</script>
    
        <jsp:include page="footer.htm"></jsp:include>
    </body>
</html>
