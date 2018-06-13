<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="header.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <title>发布房源 - 锋云租房</title>
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
                    <li class="breadcrumb-item active">发布房源</li>
                </ol>
            </nav>
            
            <s:if test="#session.user == null">
            	<div class="page-header mt-5 text-center text-muted">
	                <h1 class="mb-4">请先登录</h1>
					<h5>
						<i class="fa fa-exclamation-circle"></i>
						需要
						<a href="#modal-container-login" data-toggle="modal">登录</a>
						后才可以发布房源哦
					</h5>
	            </div>
	        </s:if>
	        
	        <s:elseif test="#session.user.realname == null">
            	<div class="page-header mt-5 text-center text-muted">
	                <h1 class="mb-4">请完善个人信息</h1>
					<h5>
						<i class="fa fa-exclamation-circle"></i>
						需要
						<a href="user.profile.action">完善个人信息</a>
						后才可以发布房源哦
					</h5>
	            </div>
	        </s:elseif>
	        
	        <s:else>
	            <div class="page-header mb-4">
	                <h1>发布房源信息</h1>
	            </div>
	            
	            <div class="form-group row">
	              <label for="title" class="col-md-2 col-form-label">联系方式</label>
	              <div class="input-group col-lg-6">
	                <input type="text" class="form-control" value="${fn:substring(user.realname,0,1)}${user.gender==1?'先生':'女士'}：${user.phone}" readonly>
  					<div class="input-group-append">
	                  <a class="btn btn-outline-secondary" href="user.profile.action">修改联系方式</a>
	                </div>
	              </div>
	            </div>
	            
	            <s:form namespace="/" action="house.publish" method="post" enctype="multipart/form-data" onsubmit="return formValidate()">
	              <div class="form-group row">
	                <label for="title" class="col-md-2 col-form-label">标题</label>
	                <div class="col">
	                  <input type="text" class="form-control" id="title" name="title" placeholder="输入房源标题" required/>
	                </div>
	              </div>
	              <div class="form-group row">
	                <label for="s_province" class="col-md-2 col-form-label">城市</label>
	                <div class="col-sm">
	                  <select class="form-control" id="s_province" name="province"></select>
	                </div>
	                <div class="col-sm">
	                  <select class="form-control" id="s_city" name="city"></select>
	                </div>
	                <div class="col-sm">
	                  <select class="form-control" id="s_county" name="county"></select>
	                </div>
	              </div>
	              <div class="form-group row">
	                <label for="address" class="col-md-2 col-form-label">详细地址</label>
	                <div class="col">
	                  <input type="text" class="form-control" id="address" name="address" placeholder="输入房源详细地址" required/>
	                </div>
	              </div>
	              <!-- <input type="hidden" class="form-control" id="address" name="address"> -->
	              <div class="form-group row mt-4">
	                <label for="area" class="col-md-2 col-form-label">面积</label>
	                <div class="input-group col-md">
	                  <input type="number" class="form-control" id="area" name="area" min="1" placeholder="室内面积" required/>
	                  <div class="input-group-append">
	                    <span class="input-group-text">m²</span>
	                  </div>
	                </div>
	                <div class="col"></div><div class="col"></div>
	              </div>
	              <div class="form-group row">
	                <label for="roomCount" class="col-md-2 col-form-label">户型</label>
	                <div class="input-group col">
	                  <input type="number" class="form-control" id="roomCount" name="roomCount" min="0" placeholder="房间数" required/>
	                  <div class="input-group-append">
	                    <span class="input-group-text">室</span>
	                  </div>
	                </div>
	                <div class="input-group col">
	                  <input type="number" class="form-control" id="hallCount" name="hallCount" min="0" placeholder="客厅数" required/>
	                  <div class="input-group-append">
	                    <span class="input-group-text">厅</span>
	                  </div>
	                </div>
	                <div class="input-group col">
	                  <input type="number" class="form-control" id="bathroomCount" name="bathroomCount" min="0" placeholder="卫生间数" required/>
	                  <div class="input-group-append">
	                    <span class="input-group-text">卫</span>
	                  </div>
	                </div>
	              </div>
	              <div class="form-group row mt-4">
	                <label for="rentMethod" class="col-md-2 col-form-label">租赁方式</label>
	                <div class="col-sm">
	                  <select class="form-control" id="rentMethod" name="rentMethod">
	                      <option value="整租">整租</option>
	                      <option value="合租">合租</option>
	                  </select>
	                </div>
	              </div>
	              <div class="form-group row">
	                <label for="price" class="col-md-2 col-form-label">租金</label>
	                <div class="input-group col-md">
	                  <div class="input-group-prepend">
	                    <span class="input-group-text">￥</span>
	                  </div>
	                  <input type="number" class="form-control" id="price" name="price" min="1" placeholder="月租金额" required/>
	                  <div class="input-group-append">
	                    <span class="input-group-text">元 / 每月</span>
	                  </div>
	                </div>
	                <div class="col"></div>
	              </div>
	              <div class="form-group row">
	                <label for="deposit" class="col-md-2 col-form-label">付款方式</label>
	                <div class="input-group col">
	                  <div class="input-group-prepend">
	                    <span class="input-group-text">押</span>
	                  </div>
	                  <input type="number" class="form-control" id="deposit" name="deposit" min="0" placeholder="押金倍数" required/>
	                </div>
	                <div class="input-group col">
	                  <div class="input-group-prepend">
	                    <span class="input-group-text">付</span>
	                  </div>
	                  <input type="number" class="form-control" id="payment" name="payment" min="1" placeholder="预付月数" required/>
	                </div>
	              </div>
	              <div class="form-group row mt-4">
	                <label for="intro" class="col-md-2 col-form-label">房源介绍</label>
	                <div class="col">
	                  <textarea class="form-control" id="intro" name="intro" rows="5" placeholder="输入房源的详细描述" required></textarea>
	                </div>
	              </div>
	              <div class="form-group row">
	                <label class="col-md-2 col-form-label">房源图片</label>
                    <div class="input-group col-md-10 ml-auto">
                      <div class="custom-file">
                        <input type="file" class="custom-file-input" id="file" name="file" accept="image/*" multiple required>
                        <label class="custom-file-label" for="file">选择图片文件（可多选）</label>
                      </div>
                    </div>
	              </div>
	              <div class="form-group row justify-content-center">
	                  <button id="btnSubmit" class="col-11 col-md-8 col-lg-6 btn btn-primary" type="submit">
	                  	<i class="fa fa-cloud-upload-alt"></i> 发布
	                  </button>
	              </div>
	            </s:form>

			    <!-- 省市级联 -->
		        <script type="text/javascript" src="js/city.js"></script>
		        <script type="text/javascript">
		        /*    $(window).ready(function(){
		                var addressInputs = [$('#s_province'), $('#s_city'), $('#s_county'), $('#road')];
		                for(var i in addressInputs){
		                    addressInputs[i].change(function(){
		                        var address = '';
		                        for(var i in addressInputs){
		                            address += addressInputs[i].val();
		                        }
		                        $('#address').val(address);
		                    });
		                }
		            });*/
		        </script>
		        
		        <!-- 表单验证 -->
		        <script type="text/javascript">
					function formValidate(){
						if($('#s_province').val() == '' || $('#s_city').val() == '' || $('#s_county').val() == ''){
							alert('请选择城市');
							return false;
						}
						
						$('#btnSubmit').html('<i class="fa fa-spinner fa-spin"></i> 正在提交');
						return true;
					}
				</script>
		        
	        </s:else>
	        
        </div>
    
        <jsp:include page="footer.htm"></jsp:include>
    </body>
</html>
