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
<body>
<!-- banner start --> 
<!-- ================ -->
<div id="banner" class="banner"> 
  <!--<div class="banner-image"></div>-->
  <div class="slide-main" id="touchMain"> <a class="prev" href="javascript:;" stat="prev1001"><img src="${base }/resources/portal/images/l-btn.png" /></a>
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
        	<jsp:include page="orderDiv.jsp"></jsp:include>
        </div>
      </div>
    <a class="next" href="javascript:;" stat="next1002"><img src="${base }/resources/portal/images/r-btn.png" /></a> </div>
</div>
<!-- banner end --> 
<!-- section start --> 
<!-- ================ -->
<div class="section clearfix object-non-visible" data-animation-effect="fadeIn">
  <div class="container">
    <div class="row">
      <div class="col-md-12 col-sm-12">
        <h1 id="about" class="title text-center" style=" padding-top:40px;">办公楼位置 </h1>
        <div class="space"></div>
        <div class="row"> 
         <c:forEach items="${buildinglist}" var="building" varStatus="status" begin="0" end="1" step="1">
          <div class="col-md-6 col-sm-6">
            <article id="${building.uuid}" class="post-1978 post type-post status-publish format-standard has-post-thumbnail hentry category-movies row archive homepage-article gridt">
              <div class="featured-thumb">
                <div class="gridt-meta">
                  <div class="meta-title"><a href="${path}/portal/position/building/index.vhtml?uuid=${building.uuid}">${building.title}</a></div>
                </div>
                <div class="sale-box sale-box-bg"> <span class="hover_floatdiv meta-title">
       
             </span></div>
                <a href="${path}/portal/position/building/index.vhtml?uuid=${building.uuid}"> <img width="100%" src="${building.picture}" height="340" class="attachment-gridt-thumb wp-post-image" alt="办公楼图片"> </a>
               </div>
            </article>
            <!-- #post-## --> 
          </div>
              </c:forEach>
        </div>
        <div class="space"></div>
      
        
      </div>
    </div>
  </div>
</div>
<!-- section end --> 

<!-- section start --> 
<!-- ================ -->
<div class="section" style="padding-bottom:110px;">
  <div class="container object-non-visible" data-animation-effect="fadeIn">
    <h1 class="text-center title">享客服务</h1>
    <div class="space"></div>
    <div class="row">
            <div class="col-xs-6 col-sm-3 col-md-3 yele_hover" style="border-left:1px solid #eee;">
				<div class="wow fadeInLeft animated" data-wow-delay="0.2s" style="visibility: visible;-webkit-animation-delay: 0.2s; -moz-animation-delay: 0.2s; animation-delay: 0.2s;">
                <div class="service-box">
					<div class="service-icon">
						<span class="fa fa-coffee fa-5x yello"></span> 
					</div>
					<div class="service-desc">						
						<h2>咖啡厅</h2>
						<p>独特个性的休闲小吧，舒倘，漫长</p>
					</div>
                </div>
				</div>
            </div>
			<div class="col-xs-6 col-sm-3 col-md-3 yele_hover">
				<div class="wow fadeInUp animated" data-wow-delay="0.2s" style="visibility: visible;-webkit-animation-delay: 0.2s; -moz-animation-delay: 0.2s; animation-delay: 0.2s;">
                <div class="service-box">
					<div class="service-icon">
						<span class="fa fa-group fa-5x yello"></span> 
					</div>
					<div class="service-desc">
						<h2>会议室</h2>
						<p>风格别致，设施完善
						</p>
						
					</div>
                </div>
				</div>
            </div>
			<div class="col-xs-6 col-sm-3 col-md-3 yele_hover">
				<div class="wow fadeInUp animated" data-wow-delay="0.2s" style="visibility: visible;-webkit-animation-delay: 0.2s; -moz-animation-delay: 0.2s; animation-delay: 0.2s;">
                <div class="service-box">
					<div class="service-icon">
						<span class="fa fa-food fa-5x yello"></span> 
					</div>
					<div class="service-desc">
						<h2>餐厅</h2>
						<p>
						菜肴精致，品种丰富，色味俱佳
						</p>
						
					</div>
                </div>
				</div>
            </div>
			<div class="col-xs-6 col-sm-3 col-md-3 yele_hover" >
				<div class="wow fadeInRight animated" data-wow-delay="0.2s" style="visibility: visible;-webkit-animation-delay: 0.2s; -moz-animation-delay: 0.2s; animation-delay: 0.2s;">
                <div class="service-box">
					<div class="service-icon">
						<span class="fa fa-rss fa-5x yello"></span> 
					</div>
					<div class="service-desc">
						<h2>高速网络</h2>
						<p>
						想要多快，就有多快
						</p>
					
					</div>
                </div>
				</div>
            </div>
        </div>
  </div>
</div>
<!-- section end --> 

<!-- section start --> 
<!-- ================ -->
<div class="section bg_gary">
  <div class="container">
    <h1 class="text-center title" style="padding-bottom:25px;">活动资讯<a style="font-size:14px; padding-top:20px; color:#333;" class="pull-right" href="${base }/portal/community/index.vhtml" target="_blank">MORE+</a></h1>
    <div class="separator"></div>
  
    <div class="row object-non-visible" data-animation-effect="fadeIn">
      <div class="col-md-12"> 
        
        <!-- isotope filters start -->
        <!--<div class="filters text-center">
          <ul class="nav nav-pills">
            <li class="active"><a href="#" data-filter="*">All</a></li>
            <li><a href="#" data-filter=".web-design">Web design</a></li>
            <li><a href="#" data-filter=".app-development">App development</a></li>
            <li><a href="#" data-filter=".site-building">Site building</a></li>
          </ul>
        </div>-->
        <!-- isotope filters end --> 
        
        <!-- portfolio items start -->
        <div class="isotope-container row grid-space-20">
          <c:forEach items="${activityList }" var="activity">
          	<div class="col-md-4  col-sm-4 isotope-item web-design" >
            <div class="fp-item">
		         <div class="fp-thumb"><a href="${base }/portal/community/showDetail.vhtml?uuid=${activity.uuid}" target="_blank"><img width="100%" height="240" src="${activity.pictureUrl}" class="attachment-carousel-thumb wp-post-image" alt="1"></a></div>
		         	
		         <div class="fp-title"><a href="${base }/portal/community/showDetail.vhtml?uuid=${activity.uuid}" target="_blank">${activity.title}</a></div>
               
		         </div>
            <p>${activity.summary}</p>
          </div>
          </c:forEach>
        </div>
        <!-- portfolio items end --> 
        
      </div>
    </div>
  </div>
</div>
<!-- section end --> 
<script>
var yytype = '${yytype}';
if(yytype == "yycgli"){
	$("#yycgli").click();
}
</script>
</body>
</html>