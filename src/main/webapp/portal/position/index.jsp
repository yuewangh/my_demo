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
        	<jsp:include page="/portal/index/orderDiv.jsp"></jsp:include>
        </div>
      </div>
    <a class="next" href="javascript:;" stat="next1002"><img src="${base }/resources/portal/images/r-btn.png" /></a> </div>
</div>
<!-- banner end --> 
<!-- section start -->
<section>
  <div class="section ">
    <div class="container">
      <h1 class="text-center title" style="padding-bottom:25px;">中国&nbsp;&bull;&nbsp;${region}</h1>
      <div class="separator"></div>
      <div class="row object-non-visible" data-animation-effect="fadeIn">
        <div class="col-md-12"> 
          
          <!-- portfolio items start -->
          <form class="pagination_form">
           <div class="isotope-container row grid-space-20">
           <c:if test="${pageModel.records==0}">
            <div class="col-md-4  col-sm-4 isotope-item web-design" >
              <div class="fp-item">
                <div class="fp-thumb"><a href="#"><img width="100%" height="300" src="${base}/resources/portal/images/conter1.jpg" class="attachment-carousel-thumb wp-post-image" alt=""></a></div>
                <div class="fp-title fp-position"><a href="#">敬请期待</a></div>
                <div class="sale-box sale-box-bg sale-box-bga"> 
                 <span class="hover_floatdiv">
                      <h2><b>敬请期待</b></h2>
                      <i class="fa fa-map-marker font_size_f"></i>
                    </span>
                 </div>
                
              </div>
          </div>
           <div class="col-md-4  col-sm-4 isotope-item web-design" >
              <div class="fp-item">
                <div class="fp-thumb"><a href="#"><img width="100%" height="300" src="${base}/resources/portal/images/conter1.jpg" class="attachment-carousel-thumb wp-post-image" alt=""></a></div>
                <div class="fp-title fp-position"><a href="#">敬请期待</a></div>
                <div class="sale-box sale-box-bg sale-box-bga"> 
                 <span class="hover_floatdiv">
                      <h2><b>敬请期待</b></h2>
                      <i class="fa fa-map-marker font_size_f"></i>
                    </span>
                 </div>
                
              </div>
          </div>
           <div class="col-md-4  col-sm-4 isotope-item web-design" >
              <div class="fp-item">
                <div class="fp-thumb"><a href="#"><img width="100%" height="300" src="${base}/resources/portal/images/conter1.jpg" class="attachment-carousel-thumb wp-post-image" alt=""></a></div>
                <div class="fp-title fp-position"><a href="#">敬请期待</a></div>
                <div class="sale-box sale-box-bg sale-box-bga"> 
                 <span class="hover_floatdiv">
                      <h2><b>敬请期待</b></h2>
                      <i class="fa fa-map-marker font_size_f"></i>
                    </span>
                 </div>
                
              </div>
          </div>
           </c:if>
            <c:if test="${pageModel.records>0}">
          <c:forEach items="${pageModel.rows}" var="building">
            <div class="col-md-4  col-sm-4 isotope-item web-design" >
              <div class="fp-item">
                <div class="fp-thumb"><a href="#"><img width="100%" height="300" src="${building.picture}" class="attachment-carousel-thumb wp-post-image" alt="1"></a></div>
                <div class="fp-title fp-position"><a href="#">${building.title}</a></div>
                <div class="sale-box sale-box-bg sale-box-bga"> 
                 <span class="hover_floatdiv">
                      <h2><b>${building.title}</b></h2>
                      <i class="fa fa-map-marker font_size_f"></i><p>${building.address}</p>
                      <a target="_blank" href="${path}/portal/position/building/index.vhtml?uuid=${building.uuid}" class="btn btn-lg btn-danger navbar-btn yele_bg">查看详细</a>
                    </span>
                 </div>
                
              </div>
          </div>
          </c:forEach>
          </c:if>
            </div>
            <c:import url="/portal/includes/pagination.jsp"/>
          </form>
          <!-- portfolio items end --> 
          
        </div>
      </div>
    </div>
  </div>
</section>
<!-- section end --> 
<script>
var yytype = '${yytype}';
if(yytype == "yycgli"){
	$("#yycgli").click();
}
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
//select选择
function turnselect(vl,name,id){
	$("#"+id).val(vl);
	$("#"+id+"_p").text(name);
}
//修改开始时间
function blurstartdate(){
	var startDatestr = $("#startDatestr").val();
	var duration = $("#duration").val();
	if($.trim(startDatestr) != "开始日期"){
		if($.trim(duration) != '租用月数'){
			addMonths(startDatestr,duration);
		}
	}
}
function blurduration(){
	var startDatestr = $("#startDatestr").val();
	var duration = $("#duration").val();
	if($.trim(duration) == ''){
		$("#duration").val('租用月数');
	}else if(!(/^[1-9]\d*$/.test(duration))){
		alert("租用月数必须是正整数");
		return;
	}else if($.trim(startDatestr) != "开始日期"){
		addMonths(startDatestr,duration);
	}
}
//日期+月。日对日，若目标月份不存在该日期，则置为最后一日
function addMonths(d, n) {
	var end="";
	$.post("${path}/common/addMonths.json", {
		"startDatestr" : d,
		"duration" : n
	}, function(data) {
		end = data.endDate;
		$("#endDatestr").val(end);
		$("#endDatestr_p").text(d + "至" +end);
	});
}
/**
 * 预订
 */
function submit_reservation(){
	var reserv_build = $("#reserv_build").val();
	if(reserv_build == ""){
		alert("请选择办公位置");
		return;
	}
	var startDatestr = $("#startDatestr").val();
	if($.trim(startDatestr) == "开始日期"){
		alert("请选择开始日期");
		return;
	}
	var duration = $("#duration").val();
	if(duration == "租用月数"){
		alert("请填写租用月数");
		return;
	}else if(!(/^[1-9]\d*$/.test(duration))){
		alert("租用月数必须是正整数");
		return;
	}
	var endDatestr = $("#endDatestr").val();
	window.location.href="${path}/portal/reserve.vhtml?duration="+duration+"&building_uuid="+reserv_build+"&startDatestr="+startDatestr+"&endDatestr="+endDatestr;
}
/**
 * 预约
 */
function submit_appointment(){
	var building = $("#building").val();
	if(building == ""){
		alert("请选择办公位置");
		return;
	}
	var visitDatestr = $("#visitDatestr").val();
	if($.trim(visitDatestr) == "参观日期"){
		alert("请选择参观日期");
		return;
	}
	var visitTimestr = $("#visitTimestr").val();
	if(visitTimestr == ""){
		alert("请填写参观时间");
		return;
	}
	var applicantName = $("#applicantName").val();
	if(applicantName == "姓名"){
		alert("请填写联系人姓名");
		return;
	}
	var vistorNum = $("#vistorNum").val();
	if(vistorNum == "参观人数"){
		alert("请填写参观人数");
		return;
	}else if(!(/^[1-9]\d*$/.test(vistorNum))){
		alert("参观人数必须是正整数");
		return;
	}
	var reg1 = /^1[3|5|7|8|]\d{9}$/;
	var reg2 = /^((0\d{2,3}-\d{7,8})|(0\d{2,3}\d{7,8}))$/;
	var telphone = $("#telphone").val();
	if(telphone == "联系电话"){
		alert("请填写联系人电话");
		return;
	}else if(!reg1.test(telphone) && !reg2.test(telphone)){
		alert("联系电话格式不对");
		return;
	}
	$.post("${path}/order/appointment/save.json", {
		"user.uuid" : '${user_uuid}',
		"building.uuid" : building,
		"visitDatestr" : visitDatestr,
		"visitTimestr" : visitTimestr,
		"applicantName" : applicantName,
		"vistorNum" : vistorNum,
		"telphone" : telphone
	}, function(data) {
		if(data.success){
			alert("预约成功！预约号："+data.code);
			window.location.reload();
		} else{
			alert(data.errmsg);
		}
	});
}
</script>
</body>
</html>