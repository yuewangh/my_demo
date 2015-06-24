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
<section>
<div class="row">
		<div class="reserve_top">
        	<div class="container">
            	<div class="reserver_topa">
                	<ul>
                        <li>
                        	<span>办公位置 ：</span>
                        	<select style=" background:none; border:none;" id="building_uuid" name="building_uuid" onchange="turnBuilding()">
                        	<c:forEach items="${buildinglist}" var="build">
                        		<c:choose>
                        			<c:when test="${build.uuid == building_uuid}"><option value="${build.uuid}" selected="selected">${build.title}</option></c:when>
                        			<c:otherwise><option value="${build.uuid}">${build.title}</option></c:otherwise>
                        		</c:choose>
                        	</c:forEach>
                        </select>
                        </li>
                        <li style="vertical-align: middle;"> 
                        	<span>开始日期：</span>
	                       <%--  <input id="startDatestr" name="startDatestr" style="width:120px; background:none; border:none; display:inline-block;" class="" type="text" value="${startDatestr}" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false, readOnly:true})" onchange="blurstartdate()"/> --%>
	                        <input class="laydate-icon" style="width:120px; background:none; border:none; display:inline-block;" id="startDatestr" name="startDatestr" value="${startDatestr}" readonly="readonly"> 
	                    </li>	
                        <li>
                        <span>租用周期：<input type="hidden" id="duration" value="${duration}"></span>
                        	 <p class="dropdown-toggle select-box" data-toggle="dropdown" id="duration_p">${duration}月</p>
	                        <div class="dropdown-menu top_meuna week" style="z-index: 9999; background: #FFF;">
	                        		<c:forEach var="i" begin="1" end="12">
                          				<a href="javascript:;" onclick="blurduration('${i}')"><p>${i}月</p></a>
                          			</c:forEach>
	                        </div>
                       </li>
                        <li><span>结束日期：</span>
                       <%--  <input class="select-data" style="width:80px; background:none; border:none; display:inline-block;" class="" type="text" id="endDatestr" name="endDatestr" value="${endDatestr}" readonly="readonly"> --%>
                         <input class="laydate-icon" style="width:120px; background:none; border:none; display:inline-block;" id="endDatestr" name="endDatestr" value="${endDatestr}" readonly="readonly"> 
                       </li>
                    </ul>
                </div>
            </div>
        </div>
        <div  class="container">
            <div class="col-lg-8 col-sm-8">
            	<ul id="myTab1" class="tabs_resrver">
                  <li id="bgs_imgli" onclick="turnulli('bgs_img','bgz_img')" class="active">独立办公室</li>
                  <li id="bgz_imgli" onclick="turnulli('bgz_img','bgs_img')">办公桌</li>
                 </ul> 
           
             <div class="border_left" style="display:none;" id="bgz_img">
             
                	<div class="pull-right check_reser"><span><p class="bg_yello"></p><label>可租</label></span><span><p class="bg_with"></p><label>已租</label></span><span><p class="bg_yello"><i class="fa fa-ok"></i></p><label>已选</label></span></div>
                    <div class="rese_bottom">
                          <ul style="text-align: left;">
                          	<c:forEach items="${officelist}" var="office">
                          		<c:if test="${office.type == '0'}">
                         	  	<c:choose>
                         	  		<c:when test="${office.isuse == '1' }">
                         	  			<%-- <li id="offli0${office.uuid}" class="deskli_yellow" onclick="selectOff('0','${office.uuid}');"><i class="faia"></i>
										${office.title}
										</li> --%>
										<li id="offli0${office.uuid}" class="bg_yello" onclick="selectOff('0','${office.uuid}');">
			                            	<div class=" web-design" >
			                                  <div class="fp-item">
			                                    <div class="fp-thumb"><a href="#"><img width="100%" height="300" src="${office.picture}" class="attachment-carousel-thumb wp-post-image" alt="1"></a></div>
			                                    <div class="fp-title fp-position"><a href="#">${office.title}</a></div>
			                                    <div class="sale-box sale-box-bg sale-box-bga"> 
			                                     <span class="hover_floatdiv">
			                                        
			                                        </span>
			                                     </div>
			                                    
			                                  </div>
			                                </div>
			                            	<i class="fai_big"></i>
			                                
			                              </li>
                         	  		</c:when>
                         	  		<c:otherwise>
                         	  			 <%-- <li class="deskli_grey"> <i class="faia"></i>
                         	  			 	${office.title}
                         	  			 </li> --%>
                         	  			 <li class="bg_gri"> 
			                            	<div class="  web-design" >
			                                  <div class="fp-item">
			                                    <div class="fp-thumb"><a href="#"><img width="100%" height="300" src="${office.picture}" class="attachment-carousel-thumb wp-post-image" alt="1"></a></div>
			                                    <div class="fp-title fp-position"><a href="#">${office.title}</a></div>
			                                    <div class="sale-box sale-box-bg sale-box-bggrey"> 
			                                     <span class="hover_floatdiv">
			                                        
			                                        </span>
			                                     </div>
			                                    
			                                  </div>
			                                </div>
			                            </li>
                         	  		</c:otherwise>
                         	  	</c:choose>
                         	  	</c:if>
                         	  </c:forEach>
                         </ul>
                    </div>       
                </div>
         
                <div class="border_left" style="display:block;" id="bgs_img"> 
                	<div class="pull-right check_reser"><span><p class="bg_yello"></p><label>可租</label></span><span><p class="bg_with"></p><label>已租</label></span><span><p class="bg_yello"><i class="fa fa-ok"></i></p><label>已选</label></span></div>
                    <div class="rese_bottom">
	                    <ul style="text-align: left;">
	                          	<c:forEach items="${officelist}" var="office">
	                          	<c:if test="${office.type == '1'}">
	                         	  	<c:choose>
	                         	  		<c:when test="${office.isuse == '1' }">
	                         	  			<%-- <li id="offli1${office.uuid}" class="bg_yello" style="width:240px; height:200px;margin-top: 5px;text-align: center;" onclick="selectOff('1','${office.uuid}');"><i class="fai_big"></i>
											${office.title}
											</li> --%>
											<li id="offli1${office.uuid}" class="bg_yello" onclick="selectOff('1','${office.uuid}');">
			                            	<div class=" web-design" >
			                                  <div class="fp-item">
			                                    <div class="fp-thumb"><a href="#"><img width="100%" height="300" src="${office.picture}" class="attachment-carousel-thumb wp-post-image" alt="1"></a></div>
			                                    <div class="fp-title fp-position"><a href="#">${office.title}</a></div>
			                                    <div class="sale-box sale-box-bg sale-box-bga"> 
			                                     <span class="hover_floatdiv">
			                                        
			                                        </span>
			                                     </div>
			                                    
			                                  </div>
			                                </div>
			                            	<i class="fai_big"></i>
			                                
			                              </li>
											
	                         	  		</c:when>
	                         	  		<c:otherwise>
	                         	  			<%--  <li class="bg_gri"  style="width:240px; height: 200px;margin-top: 5px;text-align: center;" > <i class="fai_big"></i>
	                         	  			 	${office.title}
	                         	  			 </li> --%>
	                         	  			 <li class="bg_gri"> 
				                            	<div class="  web-design" >
				                                  <div class="fp-item">
				                                    <div class="fp-thumb"><a href="#"><img width="100%" height="300" src="${office.picture}" class="attachment-carousel-thumb wp-post-image" alt="1"></a></div>
				                                    <div class="fp-title fp-position"><a href="#">${office.title}</a></div>
				                                    <div class="sale-box sale-box-bg sale-box-bggrey"> 
				                                     <span class="hover_floatdiv">
				                                        
				                                        </span>
				                                     </div>
				                                    
				                                  </div>
				                                </div>
				                            </li>
	                         	  		</c:otherwise>
	                         	  	</c:choose>
	                         	  	</c:if>
	                         	  </c:forEach>
                         </ul>
                    </div>   
                </div>    
            </div>
            <div class="col-lg-4 col-sm-4  bg_gary right_rese">
                <h2><c:forEach items="${buildinglist}" var="build">
                	<c:if test="${build.uuid == building_uuid}">${build.title}</c:if>
                </c:forEach>
                </h2>
                 <ul id="myTab" class="nav  tabs_right">
                  <li id="bgs_imgli1" onclick="turnulli('bgs_img','bgz_img')" class="active"><button class="tab_a  on" data-toggle="tab">独立办公室</button></li>
                  <li id="bgz_imgli1" onclick="turnulli('bgz_img','bgs_img')" ><button class="" data-toggle="tab">办公桌</button></li>
                 </ul>
                 <div id="myTabContent" class="tab-content">
	                  <div class="tab-pane fade in active m_5" id="bgs_img1" style="display:block;">
		                  <c:forEach items="${officelist}" var="office">
		                  	<c:if test="${office.isuse=='1' && office.type == '1'}">
		                  	  <ul class="right_listul">
		                        <li><input type="checkbox" name="office_uuid" id="offcheck1${office.uuid}" value="${office.uuid}" onclick="selectOff('1','${office.uuid}');"/></li>
		                        <li><img src="${office.picture}" width="165" height="135" alt="办公室图片"> </li>
		                        <li><h5><b>名称：</b>${office.title}</h5>
		                        	<h5><b>面积：</b>${office.area}平米</h5>
		                        	<h5><b>工位：</b>${office.capactity}座</h5>
		                        	<h5><b>价格：</b>${office.unitPrice}元/${office.unitAccount}</h5>
		                        </li>
		                      </ul>
		                    </c:if>
		                  </c:forEach>
	                  </div>
	                  <div class="tab-pane fade in active m_5" id="bgz_img1" style="display:none;">
		                  <c:forEach items="${officelist}" var="office">
		                  	<c:if test="${office.isuse=='1' && office.type == '0'}">
		                  	  <ul class="right_listul">
		                        <li><input type="checkbox" name="office_uuid" id="offcheck0${office.uuid}" value="${office.uuid}" onclick="selectOff('0','${office.uuid}');"/></li>
		                        <li><img src="${office.picture}" width="165" height="135" alt="办公桌图片"> </li>
		                        <li><h5><b>名称：</b>${office.title}</h5>
		                        	<h5><b>工位：</b>${office.capactity}座</h5>
		                        	<h5><b>价格：</b>${office.unitPrice}元/${office.unitAccount}</h5>
		                        </li>
		                      </ul>
		                    </c:if>
		                  </c:forEach>
	                  </div>
				</div>                  
                 <!--  <button class="btn btn-or  text-center" onclick="toappointment()">预约参观</button> -->
                 <div style="text-align: center;">
	                  <button class="btn btn-or  text-center" onclick="toreservation()">立即预订</button>
                 </div>
            </div>
         </div>
    </div>
</section>
<script>
!function(){
	laydate.skin('molv');//切换皮肤，请查看skins下面皮肤库
	laydate({elem: '#startDatestr',isclear: false,event: 'focus',
		choose: function(datas){ //选择日期完毕的回调
			blurstartdate();
	    }});//绑定元素
}();
//预约参观
function toappointment(){
	window.location.href="${path}/portal/index.vhtml?yytype=yycgli";
}
function turnBuilding(){
	var building_uuid = $("#building_uuid").val();
	var duration = $("#duration").val();
	var startDatestr = $("#startDatestr").val();
	var endDatestr = $("#endDatestr").val();
	window.location.href="${path}/portal/reserve.vhtml?duration="+duration+"&building_uuid="+building_uuid+"&startDatestr="+startDatestr+"&endDatestr="+endDatestr;
}
//立即下单
function toreservation(){
	/* if('${user_uuid}' == ''){
		alert("您还没有登陆，请登陆以后下单！");
		window.location.href="${path}/portal/login.vhtml";
		return;
	} */
	var office_uuids="";
	$('input[name="office_uuid"]:checked').each(function(){ 
		office_uuids +=  $(this).val()+","; 
	}); 
	if(office_uuids == ""){
		alert("请选择办公室！");
		return;
	}
	window.open("${path}/portal/order_submit.vhtml?office_uuids="+office_uuids
			+"&building_uuid="+$("#building_uuid").val()+"&startDatestr="+$("#startDatestr").val()+"&endDatestr="
			+$("#endDatestr").val()+"&duration="+$("#duration").val());
}
//修改开始时间
function blurstartdate(){
	var startDatestr = $("#startDatestr").val();
	var duration = $("#duration").val();
	addMonths(startDatestr,duration);
}
function blurduration(vl){
	$("#duration").val(vl);
	$("#duration"+"_p").text(vl+"月");
	var startDatestr = $("#startDatestr").val();
	var duration = $("#duration").val();
	addMonths(startDatestr,duration);
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
		turnBuilding();
	});
}

//点击切换
function selectOff(type,id){
	if($("#offli"+type+id).hasClass('active')){
        $("#offli"+type+id).removeClass("active");
        $("#offcheck"+type+id).prop("checked", false);
    }else{
        $("#offli"+type+id).addClass("active");
        $("#offcheck"+type+id).prop("checked", true);
    }
}
//点击切换
function turnulli(v1,v2){
	$("#"+v1+"li").addClass("active");
	$("#"+v2+"li").removeClass("active");
	$("#"+v1+"li1").addClass("active");
	$("#"+v2+"li1").removeClass("active");
	
	$("#"+v1).show();
	$("#"+v2).hide();
	$("#"+v1+"1").show();
	$("#"+v2+"1").hide();
}

</script>
</body>
</html>
