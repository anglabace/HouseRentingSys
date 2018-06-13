<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="header.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <title>个人资料 - 锋云租房</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        
        <!-- 表单验证 -->
        <script type="text/javascript">
        	
        </script>
    </head>
    
    <body>
        <div class="container">
            <nav>
                <ol class="breadcrumb">
                    <span>当前位置： </span>
                    <li class="breadcrumb-item">
                        <a href="index.jsp">锋云租房</a>
                    </li>
                    <li class="breadcrumb-item">个人中心</li>
                    <li class="breadcrumb-item active">个人资料</li>
                </ol>
            </nav>
            
            <s:if test="#session.user == null">
            	<div class="page-header mt-5 text-center text-muted">
	                <h1 class="mb-4">请先登录</h1>
					<h5>
						<i class="fa fa-exclamation-circle"></i>
						需要
						<a href="#modal-container-login" data-toggle="modal">登录</a>
						后才可以查看个人资料哦
					</h5>
	            </div>
	        </s:if>
	        
	        <s:else>
	            <div class="page-header mb-4">
	                <h1>个人资料</h1>
	            </div>
	            
	            <s:form namespace="/" action="user.update" method="post" enctype="multipart/form-data" onsubmit="return formValidate()">
	              <input type="hidden" class="form-control" name="id" value="${user.id}">
	              <div class="form-group row">
	                <label class="col-md-2 col-form-label">用户名</label>
	                <div class="col">
	                  <input type="text" class="form-control-plaintext" value="${user.username}" readonly/>
	                </div>
	              </div>
	              <div class="form-group row">
	                <label class="col-md-2 col-form-label">注册时间</label>
	                <div class="col">
	                  <input type="text" class="form-control-plaintext" value="<fmt:formatDate value="${user.registerTime}" pattern="yyyy年M月d日 H:mm"/>" readonly/>
	                </div>
	              </div>
	              <div class="form-group row">
	                <label for="realname" class="col-md-2 col-form-label">真实姓名</label>
	                <div class="col-md-8 col-lg-6">
	                  <input type="text" class="form-control" id="realname" name="realname" value="${user.realname}" placeholder="输入真实姓名" required/>
				      <small class="form-text text-muted">将显示在你发布的房源页面作为联系方式</small>
	                </div>
	              </div>
	              <div class="form-group row">
	                <label class="col-md-2 col-form-label">性别</label>
	                <div class="col h5">
						<div class="form-check form-check-inline" id="divMale">
						  <input class="form-check-input" type="radio" name="gender" id="genderMale" value="1" ${user.gender==1?'checked':''} required/>
						  <label class="form-check-label" for="genderMale">先生</label>
						</div>
						<div class="form-check form-check-inline" id="divFemale">
						  <input class="form-check-input" type="radio" name="gender" id="genderFemale" value="0" ${user.gender==0?'checked':''} required/>
						  <label class="form-check-label" for="genderFemale">女士</label>
						</div>
					</div>
	              </div>
	              <div class="form-group row">
	                <label for="phone" class="col-md-2 col-form-label">手机号</label>
	                <div class="col-md-8 col-lg-6">
	                  <input type="text" class="form-control" id="phone" name="phone" value="${user.phone}" placeholder="输入手机号" required/>
				      <small class="form-text text-muted">将显示在你发布的房源页面作为联系方式</small>
	                </div>
	              </div>
	              <div class="form-group row">
	                <label for="email" class="col-md-2 col-form-label">邮箱</label>
	                <div class="col-md-8 col-lg-6">
	                  <input type="email" class="form-control" id="email" name="email" value="${user.email}" placeholder="输入电子邮箱" required/>
	                </div>
	              </div>
	              <!-- TODO
	              <div class="form-group row">
	                <label class="col-md-2 col-form-label">头像</label>
	                <div class="col-md-8 col-lg-6">
                      <div class="custom-file">
                        <input type="file" class="custom-file-input" id="picture" name="picture" accept="image/*" required/>
                        <label class="custom-file-label" for="picture">选择图片文件</label>
                      </div>
                    </div>
	              </div>
	              -->
                  <button class="col-md-4 offset-md-2 mt-3 btn btn-primary" type="submit">
                  	<i class="fa fa-save"></i> 修改资料
                  </button>
	            </s:form>
		            
		        <!-- 性别外观 -->
		        <script type="text/javascript">
		        	function genderStyle(){
		        		if($('#genderMale').is(':checked')) {
		        			$('#divMale').addClass('badge');
		        			$('#divMale').addClass('badge-pill');
		        			$('#divMale').addClass('badge-primary');
		        			$('#divFemale').removeClass('badge');
		        			$('#divFemale').removeClass('badge-pill');
		        			$('#divFemale').removeClass('badge-danger');
		        		} else {
		        			$('#divMale').removeClass('badge');
		        			$('#divMale').removeClass('badge-pill');
		        			$('#divMale').removeClass('badge-primary');
		        			$('#divFemale').addClass('badge');
		        			$('#divFemale').addClass('badge-pill');
		        			$('#divFemale').addClass('badge-danger');
		        		}
		        	}
					$(window).ready(function(){
						genderStyle();
						$(':radio').click(genderStyle);
					});
				</script>
				
		        <!-- 表单验证 -->
		        <script type="text/javascript">
					function formValidate(){
						
						// TODO 表单验证
						
						$('#btnSubmit').html('<i class="fa fa-spinner fa-spin"></i> 正在提交');
						return true;
					}
				</script>
		        
	        </s:else>
	        
        </div>
    
        <jsp:include page="footer.htm"></jsp:include>
    </body>
</html>
