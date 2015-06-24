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
<section id="service" class="home-section color-dark bg-gray">
<div class="text-center">
        <div class=" bg_color">
        	<c:forEach items="${pageModel.rows }" var="info" varStatus="status">
        		<c:if test="${status.index%2 != 0 }" var="flag">
        			<div class="col-xs-6 col-sm-3 col-md-3 col-pading">
						<div class="wow fadeInUp animated animated" data-wow-delay="0.2s" style="visibility: visible;-webkit-animation-delay: 0.2s; -moz-animation-delay: 0.2s; animation-delay: 0.2s;">
		                <div class="service-box">
							<div class="service-desc">
								 <div class="col-lg-12 col-sm-12">
		                               <a href="${base }/portal/community/showDetail.vhtml?uuid=${info.uuid}" target="_blank"> <h3 class="acti_title">${info.title }</h3></a>
		                                <p class="acti_conter text-left"> ${info.summary }</p>
		                            </div>
								  <a href="${base }/portal/community/showDetail.vhtml?uuid=${info.uuid}" target="_blank" title="This is an image title" data-lightbox-gallery="gallery1" data-lightbox-hidpi="${base }/resources/portal/img/works/1@2x.jpg">
										<img  width="100%" src="${info.pictureUrl }" class="img-responsive" alt="img">
									</a>
		                           <h1  class="yelloa"><c:if test="${status.index+1 < 10 }">0</c:if>${status.index+1 }</h1>
							</div>
		                </div>
						</div>
		            </div>
        		</c:if>
        		<c:if test="${!flag }">
	        		<div class="col-xs-6 col-sm-3 col-md-3 col-pading">
						<div class="wow fadeInLeft animated animated" data-wow-delay="0.2s" style="visibility: visible;-webkit-animation-delay: 0.2s; -moz-animation-delay: 0.2s; animation-delay: 0.2s;">
		                <div class="service-box">
							<div class="service-desc">						
								<h1  class="yelloa"><c:if test="${status.index+1 < 10 }">0</c:if>${status.index+1 }</h1>
								  <a href="${base }/portal/community/showDetail.vhtml?uuid=${info.uuid}" target="_blank" title="This is an image title" data-lightbox-gallery="gallery1" data-lightbox-hidpi="${base }/resources/portal/img/works/1@2x.jpg">
										<img  width="100%" src="${info.pictureUrl }" class="img-responsive" alt="img">
									</a>
		                            <div class="col-lg-12 col-sm-12">
		                               <a href="${base }/portal/community/showDetail.vhtml?uuid=${info.uuid}" target="_blank"> <h3 class="acti_title">${info.title }</h3></a>
		                                <p class="acti_conter text-left"> ${info.summary }</p>
		                            </div>
							</div>
		                </div>
						</div>
		            </div>
        		</c:if>
        	</c:forEach>
		</div>
        <!-- <div class="col-lg-2 activ_button text-center">
        <a href="#" class="btn btn-lg btn-warning-outline">申请举办活动</a>
       </div> -->
       </div>
	</section>
</body>
</html>