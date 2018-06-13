<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="header.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <title>房源详情 - 锋云租房</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="format-detection" content="telephone=yes"/>
        <!--
        <link href="css/bootstrap.css" rel="stylesheet">
        <link href="css/fontawesome-all.css" rel="stylesheet">
        <script src="js/jquery-3.3.1.min.js"></script>
        <script src="js/bootstrap.js"></script>  -->
        
        <!-- 百度地图 -->
        <style type="text/css">
            .iw_poi_title {color:#CC5522;font-size:14px;font-weight:bold;overflow:hidden;padding-right:13px;white-space:nowrap}
            .iw_poi_content {font:12px arial,sans-serif;overflow:visible;padding-top:4px;white-space:-moz-pre-wrap;word-wrap:break-word}
            #BMapContainer {width:100%;height:400px}
        </style>
    </head>
    
    <body>
        <div class="container">
            <nav>
                <ol class="breadcrumb">
                    <span>当前位置： </span>
                    <li class="breadcrumb-item">
                        <a href="index.jsp">锋云租房</a>
                    </li>
                    <li class="breadcrumb-item active">房源详情</li>
                </ol>
            </nav>
            
            <section>
                <div class="page-header mb-4">
                    <h1>
                    	${house.title}
                    	<c:if test="${house.publisher.id == user.id}">
                    		 <small><span class="badge badge-pill badge-info">我发布的</span></small>
                    	</c:if>
                    	<c:if test="${house.status == 0}">
                    		 <small><span class="badge badge-pill badge-danger">已下架</span></small>
                    	</c:if>
                    </h1>
                </div>
                <div class="row">
                    <div class="col-lg-6 col-md-4">
                        <img class="img-fluid rounded" alt="房源主图" src="upload/${house.pictures[0]}" style="width: 100%;max-height: 320px;" onerror="this.src='img/img_error.png'"/>
                    </div>
                    <div class="col-lg-6 col-md-8">
                        <h1 class="text-primary">
                            ￥${house.price}<small>元/每月</small>
                        </h1>
                        <div class="row mt-4">
                            <span class="col-3 text-right text-muted">地址</span>
                            <span class="col-9">${house.province}${house.city}${house.county} ${house.address}</span>
                            <span class="col-3 text-right text-muted">面积</span>
                            <span class="col-9">${house.area}m²</span>
                            <span class="col-3 text-right text-muted">户型</span>
                            <span class="col-9">${house.roomCount}室 ${house.hallCount}厅 ${house.bathroomCount}卫</span>
                            <span class="col-3 text-right text-muted">租赁方式</span>
                            <span class="col-9">${house.rentMethod}</span>
                            <span class="col-3 text-right text-muted">付款方式</span>
                            <span class="col-9">押${house.deposit} 付${house.payment}</span>
                            <span class="col-3 text-right text-muted">发布时间</span>
                            <span class="col-9">
                            	<fmt:formatDate value="${house.publishTime}" pattern="yyyy年M月d日 H:mm"/>
                            </span>
                        </div>
                        <div class="row mt-4">
                            <a id="btnDial" class="col-md-auto btn btn-lg btn-success ml-auto mt-2 mr-md-2" href="#">
                                获取房东联系方式
                            </a>
                            <!-- 
                            <button type="button" class="col-md-3 btn btn-lg btn-outline-danger mt-2 mr-auto" id="btnFavorite">
                                <i class="fa fa-heart"></i> 收藏
                            </button> -->
                        </div>
                        <p class="mt-2 text-muted text-right small">
                            <i class="fa fa-eye"></i> ${house.visitCount}次浏览
                            <!-- <i class="ml-2 fa fa-heart"></i> [TODO]人收藏 -->
                            <a class="ml-4" href="javascript:void(0)" onclick="confirm('请确认该房源含有非法信息，\n恶意举报将被处罚，是否进行举报？');alert('TODO');">
                            	<i class="fa fa-exclamation-circle"></i>
                            	我要举报
                            </a>
                        </p>
                    </div>
                </div>
            </section>
            
            <section class="mt-4">
                <h3><a name="house-intro">房源介绍</a></h3>
                <% request.setAttribute("vEnter", "\n");%>
                <p>${fn:replace(house.intro,vEnter,"<br>")}</p>
         	</section>
            
            <section class="mt-4">
                <h3><a name="house-location">房源位置</a></h3>
                <div class="rounded" id="BMapContainer"></div>
            </section>
            
            <section class="mt-4">
                <h3><a name="house-picture">房源实拍</a></h3>
                <c:forEach items="${house.pictures}" var="imgsrc">
	                <img class="img-fluid rounded mb-3" alt="房源实拍图" src="upload/${imgsrc}" onerror="this.src='img/img_error.png'"/>
                </c:forEach>
            </section>
        </div>
        
        <!-- 百度地图 -->
        <script type="text/javascript" src="http://api.map.baidu.com/api?key=&v=1.1&services=true"></script>
        <script type="text/javascript">
           function initMap(){
                createMap();
                setMapEvent();
                addMapControl();

                // 定位
                var local = new BMap.LocalSearch(map, {      
                    renderOptions:{map: map,autoViewport: true},
                    pageCapacity: 1
                });      
                local.search("${house.province}${house.city}${house.county}${house.address}");
            }
            
            function createMap(){
                var map = new BMap.Map('BMapContainer');//在百度地图容器中创建一个地图
                var point = new BMap.Point(116.395645,39.929986);//定义一个中心点坐标
                map.centerAndZoom(point,15);//设定地图的中心点和坐标并将地图显示在地图容器中
                window.map = map;//将map变量存储在全局
            }
            
            function setMapEvent(){
                map.enableDragging();//启用地图拖拽事件，默认启用(可不写)
                map.disableScrollWheelZoom();//禁用地图滚轮放大缩小，默认禁用(可不写)
                map.disableDoubleClickZoom();//禁用鼠标双击放大
                map.enableKeyboard();//启用键盘上下左右键移动地图
            }
            
            function addMapControl(){
                //向地图中添加缩放控件
                var ctrl_nav = new BMap.NavigationControl({anchor:BMAP_ANCHOR_TOP_RIGHT,type:BMAP_NAVIGATION_CONTROL_LARGE});
                map.addControl(ctrl_nav);
                //向地图中添加比例尺控件
                var ctrl_sca = new BMap.ScaleControl({anchor:BMAP_ANCHOR_BOTTOM_RIGHT});
                map.addControl(ctrl_sca);
            }
            
            initMap();
        </script>

        <!-- 获取联系方式 -->
        <script type="text/javascript">
           $(window).ready(function(){
        	   $('#btnDial').click(function(){
	        	   $(this).html('<i class="fa fa-phone mr-3"></i>'
	                       + '${fn:substring(house.publisher.realname,0,1)}${house.publisher.gender == 1 ? "先生" : "女士"}'
	                       + '：${house.publisher.phone}');
	        	   $(this).attr('href', 'tel:${house.publisher.phone}');
	        	   $(this).unbind('click');
	        	   return false;
        	   });
           });
        </script>

        <jsp:include page="footer.htm"></jsp:include>
    </body>
</html>
