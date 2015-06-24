<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="UTF-8"%>
<div class=" banner-search onlineHelpBoxa">
	<div class="warp tab_list ">
		<div class="tab_t">
			<ul id="myTab" class="nav nav-tabs">
				<li class="active"><a href="#home" class="tab_a  on"
					data-toggle="tab"> 在线订位 </a> <i></i></li>
				<li><a href="#ios" class="tab_a" data-toggle="tab" id="yycgli">预约参观</a></li>
			</ul>
		</div>
		<div id="myTabContent" class="tab-content">
			<div class="tab-pane fade in active" id="home">
				<form action="" method="post" id="ul1_cf">
					<ul class="ul1 ul2 cf ">
						<li class="i1">
							<p class="dropdown-toggle select-box" data-toggle="dropdown"
								style="width: 90%;" id="reserv_build_p">办公位置</p>
							<input type="hidden" id="reserv_build"> <b class="caret"></b>
							<div class="dropdown-menu top_meuna" id="buildinglist_div">
								<%-- <c:forEach items="${buildinglist}" var="build">
									<a href="javascript:;"
										onclick="turnselect('${build.uuid}','${build.title}','reserv_build')"><p>${build.title}</p></a>
								</c:forEach> --%>
							</div>
						</li>
						<li class="i1">
						<input class="laydate-icon" style="border: none; display: inline-block; height: 40px;" id="startDatestr" name="startDatestr" value="开始日期" readonly="readonly"> 
						<!-- <input id="startDatestr" name="startDatestr"
							style="border: none; display: inline-block; height: 40px;"
							class="form-control w4" type="text" value="开始日期"
							onFocus="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false, readOnly:true})"
							onchange="blurstartdate('')" /> --></li>
						<li class="i1">
							<p class="dropdown-toggle select-box" data-toggle="dropdown"
								style="width: 90%;" id="duration_p">租用周期</p> <input
							type="hidden" id="duration">
							<div class="dropdown-menu top_meuna week"
								style="top: -175px !important;">
								<a href="javascript:;" onclick="turnduration('1','1月','')"><p>1月</p></a>
								<a href="javascript:;" onclick="turnduration('2','2月','')"><p>2月</p></a>
								<a href="javascript:;" onclick="turnduration('3','3月','')"><p>3月</p></a>
								<a href="javascript:;" onclick="turnduration('4','4月','')"><p>4月</p></a>
								<a href="javascript:;" onclick="turnduration('5','5月','')"><p>5月</p></a>
								<a href="javascript:;" onclick="turnduration('6','6月','')"><p>6月</p></a>
								<a href="javascript:;" onclick="turnduration('7','7月','')"><p>7月</p></a>
								<a href="javascript:;" onclick="turnduration('8','8月','')"><p>8月</p></a>
								<a href="javascript:;" onclick="turnduration('9','9月','')"><p>9月</p></a>
								<a href="javascript:;" onclick="turnduration('10','10月','')"><p>10月</p></a>
								<a href="javascript:;" onclick="turnduration('11','11月','')"><p>11月</p></a>
								<a href="javascript:;" onclick="turnduration('12','12月','')"><p>12月</p></a>
							</div>
						</li>
						<li class="i1">
							<p class="select-box" style="width: 90%" id="endDatestr_p">
								结束日期</p>
							<input type="hidden" id="endDatestr"> <span class="caret"></span>
						</li>
						<li class="i5"><a style="cursor: pointer;" target="_self"
							href="javascript:;" onclick="submit_reservation('')">立即订位</a></li>
					</ul>
				</form>
			</div>
			<div class="tab-pane fade" id="ios">
				<p>
				<ul class="ul1 cf ">
					<li class="i1" style="width: 240px">
						<p class="dropdown-toggle select-box" data-toggle="dropdown"
							style="width: 90%;" id="building_p">办公位置</p>
						<input type="hidden" id="building"> <b class="caret"></b>
						<div class="dropdown-menu top_meuna" id="buildinglist_div2">
						</div>
					</li>
					<li class="i1" style="width: 120px">
					<input class="laydate-icon" style="border: none; display: inline-block; height: 40px;" id="visitDatestr" name="visitDatestr" value="参观日期" readonly="readonly"> 
					<!-- <input id="visitDatestr" name="visitDatestr"
						style="border: none; display: inline-block; height: 40px;"
						class="form-control w4" type="text" value="参观日期"
						onFocus="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false, readOnly:true})" /> -->
					</li>
					<li class="i1" style="width: 100px">
						<p class="dropdown-toggle select-box" data-toggle="dropdown"
							style="width: 85%;" id="visitTimestr_p">参观时间</p>
						<input type="hidden" id="visitTimestr"><b class="caret"></b>
						<div class="dropdown-menu top_meuna">
							<a href="javascript:;"
								onclick="turnselect('09:00','09:00','visitTimestr')"><p>09:00</p></a>
							<a href="javascript:;"
								onclick="turnselect('10:00','10:00','visitTimestr')"><p>10:00</p></a>
							<a href="javascript:;"
								onclick="turnselect('11:00','11:00','visitTimestr')"><p>11:00</p></a>
							<a href="javascript:;"
								onclick="turnselect('12:00','12:00','visitTimestr')"><p>12:00</p></a>
							<a href="javascript:;"
								onclick="turnselect('13:00','13:00','visitTimestr')"><p>13:00</p></a>
							<a href="javascript:;"
								onclick="turnselect('14:00','14:00','visitTimestr')"><p>14:00</p></a>
							<a href="javascript:;"
								onclick="turnselect('15:00','15:00','visitTimestr')"><p>15:00</p></a>
							<a href="javascript:;"
								onclick="turnselect('16:00','16:00','visitTimestr')"><p>16:00</p></a>
							<a href="javascript:;"
								onclick="turnselect('17:00','17:00','visitTimestr')"><p>17:00</p></a>
							<a href="javascript:;"
								onclick="turnselect('18:00','18:00','visitTimestr')"><p>18:00</p></a>
						</div>
					<li class="i1" style="width: 120px"><input class="select-data"
						style="border: none; display: inline-block; height: 40px"
						class="form-control" type="text" id="applicantName"
						name="applicantName" value="姓名" onclick="this.select()"
						onblur="if(this.value == '') { this.value = '姓名' }"
						onfocus="if(this.value == '姓名') { this.value = '' }" maxlength="10"></li>
					<li class="i1" style="width: 80px"><input class="select-data"
						style="border: none; display: inline-block; height: 40px"
						class="form-control" type="text" id="vistorNum" name="vistorNum"
						value="参观人数" onclick="this.select()"
						onblur="if(this.value == '') { this.value = '参观人数' }"
						onfocus="if(this.value == '参观人数') { this.value = '' }"></li>
					<li class="i1" style="width: 120px"><input class="select-data"
						style="border: none; display: inline-block; height: 40px"
						class="form-control" type="text" id="telphone" name="telphone"
						value="联系电话" onclick="this.select()"
						onblur="if(this.value == '') { this.value = '联系电话' }"
						onfocus="if(this.value == '联系电话') { this.value = '' }"  maxlength="14">
					<li class="i1" style="width: 220px"><input class="select-data"
						style="border: none; display: inline-block; height: 40px;width: 200px"
						class="form-control" type="text" id="email" name="email"
						value="邮箱" onclick="this.select()"
						onblur="if(this.value == '') { this.value = '邮箱' }"
						onfocus="if(this.value == '邮箱') { this.value = '' }">
					<li class="i5"><a style="cursor: pointer;"
						href="javascript:;" onclick="submit_appointment()">立即预约</a></li>
				</ul>
			</div>
		</div>
	</div>
</div>
<!--移动-->
<div class="banner-search top_blockfixed">
	<div class="warp tab_list  warpfixed">
		<div id="myTabContent" class="tab-content">
			<div class="tab-pane fade in active" id="home">
				<form action="" method="post" id="ul1_cf">
					<ul class="ul1 ul2 cf ">
						<li class="i5"><a style="cursor: pointer;" href="#">在线订位</a>
						</li>
						<li class="i1">
							<p class="dropdown-toggle select-box" data-toggle="dropdown"
								style="width: 90%;" id="reserv_buildyd_p">办公位置</p>
							<input type="hidden" id="reserv_buildyd"> <b
							class="caret"></b>
							<div class="dropdown-menu top_meuna" id="buildinglist_div3">
								<%-- <c:forEach items="${buildinglist}" var="build">
									<a href="javascript:;"
										onclick="turnselect('${build.uuid}','${build.title}','reserv_buildyd')"><p>${build.title}</p></a>
								</c:forEach> --%>
							</div>
						</li>
						<li class="i1">
						<input class="laydate-icon" style="border: none; display: inline-block; height: 40px;" id="startDatestryd" name="startDatestryd" value="开始日期" readonly="readonly"> 
						<!-- <input id="startDatestryd"
							name="startDatestryd"
							style="border: none; display: inline-block; height: 40px;top: 175px !important;"
							class="form-control w4" type="text" value="开始日期"
							onFocus="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false})"
							onchange="blurstartdate('yd')" /> --></li>
						<li class="i1">
							<p class="dropdown-toggle select-box" data-toggle="dropdown"
								style="width: 90%;" id="durationyd_p">租用周期</p> <input
							type="hidden" id="durationyd">
							<div class="dropdown-menu top_meuna week">
								<a href="javascript:;" onclick="turnduration('1','1月','yd')"><p>1月</p></a>
								<a href="javascript:;" onclick="turnduration('2','2月','yd')"><p>2月</p></a>
								<a href="javascript:;" onclick="turnduration('3','3月','yd')"><p>3月</p></a>
								<a href="javascript:;" onclick="turnduration('4','4月','yd')"><p>4月</p></a>
								<a href="javascript:;" onclick="turnduration('5','5月','yd')"><p>5月</p></a>
								<a href="javascript:;" onclick="turnduration('6','6月','yd')"><p>6月</p></a>
								<a href="javascript:;" onclick="turnduration('7','7月','yd')"><p>7月</p></a>
								<a href="javascript:;" onclick="turnduration('8','8月','yd')"><p>8月</p></a>
								<a href="javascript:;" onclick="turnduration('9','9月','yd')"><p>9月</p></a>
								<a href="javascript:;" onclick="turnduration('10','10月','yd')"><p>10月</p></a>
								<a href="javascript:;" onclick="turnduration('11','11月','yd')"><p>11月</p></a>
								<a href="javascript:;" onclick="turnduration('12','12月','yd')"><p>12月</p></a>
							</div>
						</li>
						<li class="i1">
							<p class="select-box" style="width: 90%" id="endDatestryd_p">
								结束日期</p>
							<input type="hidden" id="endDatestryd"> <span
							class="caret"></span>
						</li>
						<li class="i5"><a style="cursor: pointer;" target="_self"
							href="javascript:;" onclick="submit_reservation('yd')">立即订位</a></li>
					</ul>
				</form>

			</div>
		</div>
	</div>
</div>
<script>	
!function(){
	laydate.skin('molv');//切换皮肤，请查看skins下面皮肤库
	laydate({elem: '#startDatestr',isclear: false,event: 'focus',
		choose: function(datas){ //选择日期完毕的回调
			blurstartdate('');
	    }});//绑定元素
	laydate({elem: '#startDatestryd',isclear: false,event: 'focus',
		choose: function(datas){ //选择日期完毕的回调
			blurstartdate('yd');
	    }});//绑定元素
	laydate({elem: '#visitDatestr',isclear: false,event: 'focus'});//绑定元素
}();
$(function(){
	$.post("${path}/portal/getBuildinglist.json", {
	}, function(data) {
		for(var i=0;i<data.length;i++){
			$("#buildinglist_div").append("<a href=\"javascript:;\" onclick=\"turnselect('"+data[i].uuid+"','"+data[i].title+"','reserv_build')\"><p>"+data[i].title+"</p></a>");
			$("#buildinglist_div2").append("<a href=\"javascript:;\" onclick=\"turnselect('"+data[i].uuid+"','"+data[i].title+"','building')\"><p>"+data[i].title+"</p></a>");
			$("#buildinglist_div3").append("<a href=\"javascript:;\" onclick=\"turnselect('"+data[i].uuid+"','"+data[i].title+"','reserv_buildyd')\"><p>"+data[i].title+"</p></a>");
		}
	});
});
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
function blurstartdate(yd){
var startDatestr = $("#startDatestr"+yd).val();
var duration = $("#duration"+yd).val();
if($.trim(startDatestr) != "开始日期"){
	if($.trim(duration) != '租用周期' && $.trim(duration) != ""){
		addMonths(startDatestr,duration,yd);
	}
}
}
function turnduration(vl,name,yd){
$("#duration"+yd).val(vl);
$("#duration"+yd+"_p").text(name);
var startDatestr = $("#startDatestr"+yd).val();
var duration = $("#duration"+yd).val();
if($.trim(startDatestr) != "开始日期"){
	addMonths(startDatestr,duration,yd);
}
}
//日期+月。日对日，若目标月份不存在该日期，则置为最后一日
function addMonths(d, n,yd) {
var end="";
$.post("${path}/common/addMonths.json", {
	"startDatestr" : d,
	"duration" : n
}, function(data) {
	end = data.endDate;
	$("#endDatestr"+yd).val(end);
	$("#endDatestr"+yd+"_p").text(d + "至" +end);
});
}
/**
* 预订
*/
function submit_reservation(yd){
var reserv_build = $("#reserv_build"+yd).val();
if(reserv_build == ""){
	alert("请选择办公位置");
	return;
}
var startDatestr = $("#startDatestr"+yd).val();
if($.trim(startDatestr) == "开始日期"){
	alert("请选择开始日期");
	return;
}
var duration = $("#duration"+yd).val();
if($.trim(duration) == "租用周期" || $.trim(duration) == ""){
	alert("请填写租用周期");
	return;
}
var endDatestr = $("#endDatestr"+yd).val();
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
var applicantName = $.trim($("#applicantName").val());
if(applicantName == "姓名"){
	alert("请填写联系人姓名");
	return;
} else if(!(/^[\u0391-\uFFE5\w]+$/.test(applicantName))){
	alert("联系人姓名只能由中文、英文、数字或下划线组成");
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
var email = $("#email").val();
if(email == "邮箱"){
	alert("请填写邮箱");
	return;
}else if(!(/^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/.test(email))){
	alert("邮箱格式错误");
	return;
}
if(confirm("您确定要预约吗？")){
	$.post("${path}/order/appointment/save.json", {
		"user.uuid" : '${user_uuid}',
		"building.uuid" : building,
		"visitDatestr" : visitDatestr,
		"visitTimestr" : visitTimestr,
		"applicantName" : applicantName,
		"email" : email,
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
}

</script>
