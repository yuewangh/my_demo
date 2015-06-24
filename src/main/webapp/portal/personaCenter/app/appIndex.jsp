<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="UTF-8" %>
<%@ include file="/pages/includes/taglibs.jsp" %>
<!DOCTYPE html>
<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
    <c:import url="/portal/includes/personaHead-libs.jsp"/>
</head>
<body>
<section id="user_info">
  <!-- top start -->
  <c:import url="/portal/personaCenter/top.jsp"/>
  <!-- top end -->
  <div class="container user_teble m_5">
 <h2 class="text-left m_4">推荐应用</h2>
 	<div class="tab-pane active" id="food">
            <div class="tab-contenta">
              <div class="col-lg-3 col-sm-3 col-pading">
                <div class="box_inner"><div class="appli_hot"><i class="fa fa-cloud"></i></div>
                  <div class="bag_desc">
                    <h4>办公室</h4>
                    <p>及租即用，随时退租。..</p>
                  </div>
                  <div class="sale-box"></div>
                </div>
              </div>
              <div class="col-lg-3 col-sm-3 col-pading">
                <div class="box_inner"><div class="appli_hot"><i class="fa fa-camera"></i></div>
                  <div class="bag_desc">
                    <h4>会议室</h4>
                    <p>即定即用（每天给予半 小时免费时间）..</p>
                  </div>
                  <div class="sale-box"></div>
                </div>
              </div>
              <div class="col-lg-3 col-sm-3 col-pading">
                <div class="box_inner"> <div class="appli_hot"><i class="fa fa-envelope"></i></div>
                  <div class="bag_desc">
                    <h4>健身房</h4>
                    <p>工作之余、休息、健身 （一定时限免费）</p>
                  </div>
                  <div class="sale-box"></div>
                </div>
              </div>
              <div class="col-lg-3 col-sm-3 col-pading">
                <div class="box_inner"> <div class="appli_hot"><i class="fa fa-group"></i></div>
                  <div class="bag_desc">
                    <h4>健身房</h4>
                    <p>工作之余、休息、健身 （一定时限免费）</p>
                  </div>
                  <div class="sale-box"></div>
                </div>
              </div>
            </div>
          </div>
          
     <div class="tab-pane active" id="food">
            <div class="tab-contenta">
              <div class="col-lg-3 col-sm-3 col-pading">
                <div class="box_inner"><div class="appli_hot"><i class="fa fa-cloud-download"></i></div>
                  <div class="bag_desc">
                    <h4>办公室</h4>
                    <p>及租即用，随时退租。..</p>
                  </div>
                  <div class="sale-box"></div>
                </div>
              </div>
              <div class="col-lg-3 col-sm-3 col-pading">
                <div class="box_inner"><div class="appli_hot"><i class="fa fa-cloud"></i></div>
                  <div class="bag_desc">
                    <h4>会议室</h4>
                    <p>即定即用（每天给予半 小时免费时间）..</p>
                  </div>
                  <div class="sale-box"></div>
                </div>
              </div>
              <div class="col-lg-3 col-sm-3 col-pading">
                <div class="box_inner"> <div class="appli_hot"><i class="fa fa-archive"></i></div>
                  <div class="bag_desc">
                    <h4>健身房</h4>
                    <p>工作之余、休息、健身 （一定时限免费）</p>
                  </div>
                  <div class="sale-box"></div>
                </div>
              </div>
              <div class="col-lg-3 col-sm-3 col-pading">
                <div class="box_inner"> <div class="appli_hot"><i class="fa fa-gift"></i></div>
                  <div class="bag_desc">
                    <h4>健身房</h4>
                    <p>工作之余、休息、健身 （一定时限免费）</p>
                  </div>
                  <div class="sale-box"></div>
                </div>
              </div>
            </div>
          </div>
    <ul class="pagination pagination-lg pull-right user_page">
                      <li>
                        <a class="icon" href="#"><i class="fa fa-long-arrow-left"></i></a>
                      </li>
                      <li class="active">
                        <a href="#">1</a>
                      </li>
                      <li>
                        <a href="#">2</a>
                      </li>
                      <li>
                        <a href="#">3</a>
                      </li>
                      <li>
                        <a href="#">4</a>
                      </li>
                      <li>
                        <a href="#">5</a>
                      </li>
                      <li>
                        <a class="icon" href="#"><i class="fa fa-long-arrow-right"></i></a>
                      </li>
                    </ul>
 </div> 
 
</section>

<!-- JavaScript files placed at the end of the document so the pages load faster
		================================================== --> 
<!-- Jquery and Bootstap core js files --> 
<script type="text/javascript">
	//login登录切换忘记密码
window.onload = function () {
	var oBtnLeft = document.getElementById("goleft");
	var oBtnRight = document.getElementById("goright");
	var oDiv = document.getElementById("userdiv");
	var oDiv1 = document.getElementById("user_infoid");
	var oUl = oDiv.getElementsByTagName("ul")[0];
	var aLi = oUl.getElementsByTagName("li");
	var now = -1* (aLi[0].offsetWidth + 13);
	oUl.style.width = aLi.length * (aLi[0].offsetWidth + 1) + 'px';
	oBtnRight.onclick = function () {
		var n = Math.floor((aLi.length * (aLi[0].offsetWidth + 1) + oUl.offsetLeft) / aLi[0].offsetWidth);

		if (n <= 1) {
			move(oUl, 'left', 0);
		}
		else {
			move(oUl, 'left', oUl.offsetLeft + now);
		}
	}
	oBtnLeft.onclick = function () {
		var now1 = -Math.floor((aLi.length / 2)) * 2 * (aLi[0].offsetWidth + 2);

		if (oUl.offsetLeft >= 0) {
			move(oUl, 'left', now1);
		}
		else {
			move(oUl, 'left', oUl.offsetLeft - now);
		}
	}
	

};

function getStyle(obj, name) {
	if (obj.currentStyle) {
		return obj.currentStyle[name];
	}
	else {
		return getComputedStyle(obj, false)[name];
	}
}

function move(obj, attr, iTarget) {
	clearInterval(obj.timer)
	obj.timer = setInterval(function () {
		var cur = 0;
		if (attr == 'opacity') {
			cur = Math.round(parseFloat(getStyle(obj, attr)) * 100);
		}
		else {
			cur = parseInt(getStyle(obj, attr));
		}
		var speed = (iTarget - cur) / 6;
		speed = speed > 0 ? Math.ceil(speed) : Math.floor(speed);
		if (iTarget == cur) {
			clearInterval(obj.timer);
		}
		else if (attr == 'opacity') {
			obj.style.filter = 'alpha(opacity:' + (cur + speed) + ')';
			obj.style.opacity = (cur + speed) / 100;
		}
		else {
			obj.style[attr] = cur + speed + 'px';
		}
	}, 30);
}
</script> 
</body>
</html>