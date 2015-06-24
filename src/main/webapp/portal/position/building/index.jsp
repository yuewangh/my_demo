<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="UTF-8" %>
<%@ include file="/pages/includes/taglibs.jsp" %>
<!DOCTYPE html>
<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <c:import url="/portal/includes/head-libs.jsp"/> 
</head>

<body class="no-trans">
<!-- banner start --> 
<!-- ================ -->
<div class="" style=" height:495px;"> 
  <!--<div class="banner-image"></div>-->
  <div class="slide-main" id="touchMain"> <a class="prev" style="top:150px;" href="javascript:;" stat="prev1001"><img src="${base}/resources/portal/images/l-btn.png" /></a>
    <div class="slide-box" id="slideContent"> 
      <sys:forEach key="SYSTEM.INDEX.BANNER" entry="entry">
             <div class="slide" style="background:url(${entry.key})"> 
		        <a stat="sslink-1" href="#">
			        <div class="obj-e"></div>
			        <div class="obj-f">${entry.value}</div>
	        	</a> 
        	</div>
         </sys:forEach>
  		<div>
        	<jsp:include page="/portal/index/orderDiv.jsp"></jsp:include>
        </div>
    </div>
    <a class="next" style="top:150px;" href="javascript:;" stat="next1002"><img src="${base}/resources/portal/images/r-btn.png" /></a> </div>
</div>
<!-- banner end --> 

<!-- section start -->
<section>
  <div class="bg_gary1 position_section">
    <div class="container">
      <div class="row">
        <div class="col-lg-4 col-sm-4 "> <img src="${building.picture }" class="img_border" width="100%"> </div>
        <div class="col-lg-8 col-sm-8 position_container">
          <h3>${building.title}</h3>
          <p>${building.description} </p>
          <i class="fa fa-map-marker font_size_f"></i>
          <h4>${building.address}</h4>
        </div>
      </div>
    </div>
  </div>
    <c:if test="${pageModel.records>0}">
  <div class="container">
  <h1 class="text-center title" style="padding-bottom:25px;">办公室</h1>
    <div class="separator"></div>
    <div class="row object-non-visible animated object-visible fadeIn" data-animation-effect="fadeIn">
      <div class="col-md-12"> 
        <!-- portfolio items start -->
         <form class="pagination_form">
         <input style="display:none" name="uuid" value="${building.uuid }"/>
        <div class="isotope-container row grid-space-20" style="position: relative; height: 318px;">
         <c:forEach items="${pageModel.rows}" var="office" begin="0" end="2" step="1">
          <div class="col-md-4  col-sm-4 isotope-item web-design" style="position: absolute; left: 0px; top: 0px;">
            <div class="">
              <div class="fp-thumb"><img width="100%" height="367" src="${office.picture}" class="attachment-carousel-thumb wp-post-image" alt="办公室图片"></div>
            </div>
            <div class="bg_gary1 position_bggrir">
              <h3 class="with_h3"><b>
                <p class="yelloa pull-left">${office.unitPrice}元/${office.unitAccount}</p>
                </b>
                <p class="pull-right">工位数量：${office.capactity}个</p>
              </h3>
            </div>
          </div>
         </c:forEach>
        <!-- portfolio items end --> 
        
      </div>
      <c:if test="${pageModel.records>0}"><c:import url="/portal/includes/pagination.jsp"/></c:if>
      	
   	</form>
    </div>
  </div>
  </div>
  </c:if>
  <div class="container">
  <h1 class="text-center title" style="padding-bottom:25px; padding-top:70px;">地图</h1>
     <div id="preview">
        <div id="float_search_bar">
            <input type="text" id="keyword" disabled="disabled" style="display:none;"/>
        </div>
        <div id="map_container"></div>
    </div>
    <div id="result" style="margin-top: 4px;width:500px;"></div>
  </div>
<!--  map-->
<%--   <div class="map"><img src="${base}/resources/portal/images/img.jpg" /></div> --%>
<!--map end-->
  <div class="container posi_pading">
    <h1 class="text-center title" style="padding-bottom:30px;">基础设施</h1>
    	<div class="row">
            <div class="col-lg-a" style="border-left:1px solid #eee;">
				<div class="wow fadeInLeft animated" data-wow-delay="0.2s" style="visibility: visible;-webkit-animation-delay: 0.2s; -moz-animation-delay: 0.2s; animation-delay: 0.2s;">
                <div class="service-box">
					<div class="service-icon">
						<span class="fa fa-coffee fa-5x yello"></span> 
					</div>
					<div class="service-desc">						
						<h2>会议室</h2>
					</div>
                </div>
				</div>
            </div>
			<div class="col-lg-a">
				<div class="wow fadeInUp animated" data-wow-delay="0.2s" style="visibility: visible;-webkit-animation-delay: 0.2s; -moz-animation-delay: 0.2s; animation-delay: 0.2s;">
                <div class="service-box">
					<div class="service-icon">
						<span class="fa fa-group fa-5x yello"></span> 
					</div>
					<div class="service-desc">
						<h2>高速网络</h2>
					</div>
                </div>
				</div>
            </div>
			<div class="col-lg-a">
				<div class="wow fadeInUp animated" data-wow-delay="0.2s" style="visibility: visible;-webkit-animation-delay: 0.2s; -moz-animation-delay: 0.2s; animation-delay: 0.2s;">
                <div class="service-box">
					<div class="service-icon">
						<span class="fa fa-food fa-5x yello"></span> 
					</div>
					<div class="service-desc">
						<h2>打印复印机</h2>
						
					</div>
                </div>
				</div>
            </div>
			<div class="col-lg-a">
				<div class="wow fadeInRight animated" data-wow-delay="0.2s" style="visibility: visible;-webkit-animation-delay: 0.2s; -moz-animation-delay: 0.2s; animation-delay: 0.2s;">
                <div class="service-box">
					<div class="service-icon">
						<span class="fa fa-rss fa-5x yello"></span> 
					</div>
					<div class="service-desc">
						<h2>餐厅</h2>
					</div>
                </div>
				</div>
            </div>
            <div class="col-lg-a">
				<div class="wow fadeInRight animated" data-wow-delay="0.2s" style="visibility: visible;-webkit-animation-delay: 0.2s; -moz-animation-delay: 0.2s; animation-delay: 0.2s;">
                <div class="service-box">
					<div class="service-icon">
						<span class="fa fa-rss fa-5x yello"></span> 
					</div>
					<div class="service-desc">
						<h2>私人电话亭</h2>
					
					</div>
                </div>
				</div>
            </div>
        </div>
        <div class="row" style="border-top:1px solid #eee;">
            <div class="col-lg-a" style="border-left:1px solid #eee;">
				<div class="wow fadeInLeft animated" data-wow-delay="0.2s" style="visibility: visible;-webkit-animation-delay: 0.2s; -moz-animation-delay: 0.2s; animation-delay: 0.2s;">
                <div class="service-box">
					<div class="service-icon">
						<span class="fa fa-headphones fa-5x yello"></span> 
					</div>
					<div class="service-desc">						
						<h2>健身房</h2>
					</div>
                </div>
				</div>
            </div>
			<div class="col-lg-a">
				<div class="wow fadeInUp animated" data-wow-delay="0.2s" style="visibility: visible;-webkit-animation-delay: 0.2s; -moz-animation-delay: 0.2s; animation-delay: 0.2s;">
                <div class="service-box">
					<div class="service-icon">
						<span class="fa fa-github-alt fa-5x yello"></span> 
					</div>
					<div class="service-desc">
						<h2>咖啡厅</h2>
					</div>
                </div>
				</div>
            </div>
			<div class="col-lg-a">
				<div class="wow fadeInRight animated" data-wow-delay="0.2s" style="visibility: visible;-webkit-animation-delay: 0.2s; -moz-animation-delay: 0.2s; animation-delay: 0.2s;">
                <div class="service-box">
					<div class="service-icon">
						<span class="fa fa-shopping-cart fa-5x yello"></span> 
					</div>
					<div class="service-desc">
						<h2>图书馆</h2>
					</div>
                </div>
				</div>
            </div>
            <div class="col-lg-a">
				<div class="wow fadeInRight animated" data-wow-delay="0.2s" style="visibility: visible;-webkit-animation-delay: 0.2s; -moz-animation-delay: 0.2s; animation-delay: 0.2s;">
                <div class="service-box">
					<div class="service-icon">
						<span class="fa fa-ambulance fa-5x yello"></span> 
					</div>
					<div class="service-desc">
						<h2>储物柜</h2>
					
					</div>
                </div>
				</div>
            </div>
            
			<div class="col-lg-a">
				<div class="wow fadeInUp animated" data-wow-delay="0.2s" style="visibility: visible;-webkit-animation-delay: 0.2s; -moz-animation-delay: 0.2s; animation-delay: 0.2s;">
                <div class="service-box">
					<div class="service-icon">
						<span class="fa fa-cloud-download fa-5x yello"></span> 
					</div>
					<div class="service-desc">
						<h2>电动车自行车停放处</h2>
						
					</div>
                </div>
				</div>
            </div>
        </div>
  </div>
</section>
<!-- JavaScript files placed at the end of the document so the pages load faster
		================================================== --> 
<!-- Jquery and Bootstap core js files --> 

<script>
$(function(){
        var navH = $(".top_blockfixed").offset().top;
        $(window).scroll(function(){
            var scroH = $(this).scrollTop();
            if(scroH>=navH){
                $(".top_blockfixed").addClass("fixed");
				
            }else if(scroH<navH){
                $(".top_blockfixed").removeClass("fixed");
            }
        })
		 var navH = $(".onlineHelpBoxa").offset().top;
        $(window).scroll(function(){
            var scroH = $(this).scrollTop();
            if(scroH>=navH){
                $(".onlineHelpBoxa").addClass("fixed");
				
            }else if(scroH<navH){
                $(".onlineHelpBoxa").removeClass("fixed");
            }
        })
    })

</script> 
<script type="text/javascript" src="http://api.map.baidu.com/api?v=1.2"></script>
    <script type="text/javascript">
        function getUrlParas(){
            var hash = location.hash,
                para = {},
                tParas = hash.substr(1).split("&");
            for(var p in tParas){
                if(tParas.hasOwnProperty(p)){
                    var obj = tParas[p].split("=");
                    para[obj[0]] = obj[1];
                }
            }
            return para;
        }
        var para = getUrlParas(),
            center = para.address?decodeURIComponent(para.address) : "${building.address}",
            city = para.city?decodeURIComponent(para.city) : "${building.region}";
    
        document.getElementById("keyword").value = center;
    
        var marker_trick = false;
        var map = new BMap.Map("map_container");
        //map.enableScrollWheelZoom();
    
        var marker = new BMap.Marker(new BMap.Point(116.404, 39.915), {
            enableMassClear: false,
            //raiseOnDrag: true
		 });
        marker.enableDragging();
        //map.addOverlay(marker);
    
        map.addEventListener("click", function(e){
            if(!(e.overlay)){
                map.clearOverlays();
                marker.show();
                marker.setPosition(e.point);
                setResult(e.point.lng, e.point.lat);
            }
        });
        marker.addEventListener("dragend", function(e){
            setResult(e.point.lng, e.point.lat);
        });
    
        var local = new BMap.LocalSearch(map, {
            renderOptions:{map: map},
			 pageCapacity: 1
        });
        local.setSearchCompleteCallback(function(results){
            if(local.getStatus() !== BMAP_STATUS_SUCCESS){
                //alert("未找到该建筑位置");
            } else {
			     marker.hide();
			 }
        });
        local.setMarkersSetCallback(function(pois){
            for(var i=pois.length; i--; ){
                var marker = pois[i].marker;
                marker.addEventListener("click", function(e){
                    marker_trick = true;
                    var pos = this.getPosition();
                    setResult(pos.lng, pos.lat);
                });
            }
        });
    
        window.onload = function(){
            local.search(center);
            document.getElementById("search_button").onclick = function(){
                local.search(document.getElementById("keyword").value);
            };
            document.getElementById("keyword").onkeyup = function(e){
                var me = this;
                e = e || window.event;
                var keycode = e.keyCode;
                if(keycode === 13){
                    local.search(document.getElementById("keyword").value);
                }
            };
        };
        function a(){
            document.getElementById("float_search_bar").style.display = "none";
        }
        
        /*
         * setResult : 定义得到标注经纬度后的操作
         * 请修改此函数以满足您的需求
         * lng: 标注的经度
         * lat: 标注的纬度
         */
        function setResult(lng, lat){
            document.getElementById("result").innerHTML = lng + ", " + lat;
        }
   </script>
</body>
</html>
