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
  <div class="top_servicefixed" >
    <ul id="myTab" >
      <li onclick="top_mao('#Space')"> <a href="javascript:void(0)"   data-toggle="tab">
        <div class="col-md-6 col-sm-6 col-pading">
          <div class="grid mask">
            <figure> <img width="100%" class="img-responsive" src="<sys:param key="SERVICE_STANDARD_IMG"/>" alt="">
              <figcaption>
                <h2 >标准服务</h2>
              </figcaption>
            </figure>
          </div>
        </div>
        </a> </li>
    
      <li onclick="top_mao('#rengong')" > <a href="javascript:void(0)" data-toggle="tab">
        <div class="col-md-6 col-sm-6 col-pading">
          <div class="grid mask">
            <figure> <img width="100%"class="img-responsive" src="<sys:param key="SERVICE_INCREMENT_IMG"/>" alt="">
              <figcaption>
                <h2>增值服务</h2>
              </figcaption>
            </figure>
          </div>
        </div>
        </a> </li>
    </ul>
 </div>
<section class="service_top servicefixeda " >
  <div class="tab-content" >
         <div name=""  class="container object-non-visible" data-animation-effect="fadeIn">
         		<div class="row">
                	<div class="col-md-12 col-sm-12">
                    	<h2  id="Space" class="title text-center" style=" padding-top:40px;">标准服务</h2>
                        <div class="service_conrer_icon row">
                        	<ul class=" col-lg-3 col-sm-3">
                            	<span class="border_circle"><i class="icon1"><img src="${base}/resources/portal/images/server_icon1.png" /></i></span>
                            	<li><h3><b>办公工位</b></h3><p>即租即用、空间使用灵活</p></li>
                            </ul>
                            <ul  class=" col-lg-3 col-sm-3">
                            	<span class="border_circle"><i class=""><img src="${base}/resources/portal/images/server_icon2.png" /></i></span>
                            	<li><h3><b>云享客会议室</b></h3><p>即定即用、限时免费</p></li>
                            </ul>
                             <ul  class=" col-lg-3 col-sm-3">
                            	<span class="border_circle"><i class=""><img src="${base}/resources/portal/images/server_icon3.png" /></i></span>
                            	<li><h3><b>沙发区
</b></h3><p>适用于会客、休闲、小
组讨论之用</p></li>
                            </ul>
                            <ul  class=" col-lg-3 col-sm-3">
                            	<span class="border_circle"><i class=""><img src="${base}/resources/portal/images/server_icon4.png" /></i></span>
                            	<li><h3><b>电话间
</b></h3><p>既保证私密性又免于干扰
他人</p></li>
                            </ul>
                            <ul  class=" col-lg-3 col-sm-3">
                            	<span class="border_circle"><i class=""><img src="${base}/resources/portal/images/server_icon5.png" /></i></span>
                            	<li><h3><b>员工餐厅

</b></h3><p>刷卡就餐</p></li>
                            </ul>
                            <ul class=" col-lg-3 col-sm-3">
                            	<span class="border_circle"><i class=""><img src="${base}/resources/portal/images/server_icon6.png" /></i></span>
                            	<li><h3><b>茶水间
</b></h3><p>提供免费热水</p></li>
                            </ul>
                            <ul  class=" col-lg-3 col-sm-3">
                            	<span class="border_circle"><i class=""><img src="${base}/resources/portal/images/server_icon7.png" /></i></span>
                            	<li><h3><b>办公储物柜

</b></h3><p>每个工位下配备</p></li>
                            </ul>
                            <ul  class=" col-lg-3 col-sm-3">
                            	<span class="border_circle"><i class=""><img src="${base}/resources/portal/images/server_icon8.png" /></i></span>
                            	<li><h3><b>衣柜
</b></h3><p>免费提供</p></li>
                            </ul>
                            <ul  class=" col-lg-3 col-sm-3">
                            	<span class="border_circle"><i class=""><img src="${base}/resources/portal/images/server_icon9.png" /></i></span>
                            	<li><h3><b>电动车、自行车车棚

</b></h3><p>配备电动充电桩装置</p></li>
                            </ul>
                             <ul  class=" col-lg-3 col-sm-3">
                            	<span class="border_circle"><i class=""><img src="${base}/resources/portal/images/server_icon10.png" /></i></span>
                            	<li><h3><b>接待中心


</b></h3><p>提供咨询、接待、指引
代为收发、手续办理、物
品订购等服务；受理服务
申请及投诉</p></li>
                            </ul>
                            <ul  class=" col-lg-3 col-sm-3">
                            	<span class="border_circle"><i class=""><img src="${base}/resources/portal/images/server_icon11.png" /></i></span>
                            	<li><h3><b>专职保洁</b></h3><p>免费定期清扫</p></li>
                            </ul>
                            <ul  class=" col-lg-3 col-sm-3">
                            	<span class="border_circle"><i class=""><img src="${base}/resources/portal/images/server_icon12.png" /></i></span>
                            	<li><h3><b>安保服务</b></h3><p>提供7*24小时的安保服务，
配备门禁权限、安全监控、
门卫巡逻等</p></li>
                            </ul>
                            
                            <ul  class=" col-lg-3 col-sm-3">
                            	<span class="border_circle"><i class=""><img src="${base}/resources/portal/images/server_icon13.png" /></i></span>
                            	<li><h3><b>水电供应
</b></h3><p>免费提供电灯照明、饮
用水等设备</p></li>
                            </ul>
                            <ul  class=" col-lg-3 col-sm-3">
                            	<span class="border_circle"><i class=""><img src="${base}/resources/portal/images/server_icon14.png" /></i></span>
                            	<li><h3><b>独立网络
</b></h3><p>10兆独立网络</p></li>
                            </ul> 
                             <ul  class=" col-lg-3 col-sm-3">
                            	<span class="border_circle"><i class=""><img src="${base}/resources/portal/images/server_icon15.png" /></i></span>
                            	<li><h3><b>打印及复印

</b></h3><p>提供公用打印机，随
需随打</p></li>
                            </ul>
                            <ul  class=" col-lg-3 col-sm-3">
                            	<span class="border_circle"><i class=""><img src="${base}/resources/portal/images/server_icon16.png" /></i></span>
                            	<li><h3><b>iSMC智能一卡通

</b></h3><p>一卡实现门禁、考勤、餐饮、
身份识别、电梯使用等功能</p></li>
                            </ul>
                            <ul  class=" col-lg-3 col-sm-3">
                            	<span class="border_circle"><i class=""><img src="${base}/resources/portal/images/server_icon17.png" /></i></span>
                            	<li><h3><b>定期活动



</b></h3><p>比赛、演讲、聚会、
DIY等</p></li>
                            </ul>
                           
                            
                           
                           
                        </div>
                    </div>
                </div>
         </div>
         <div  class="bg_gary" data-animation-effect="fadeIn" id="rengong">
         <div class="container" >
         		<div class="row">
                	<div class="col-md-12 col-sm-12" data-animation-effect="fadeIn">
                    	<h2 class="title text-center">增值服务</h2>
                        <div class="service_conrer_icon row">
                        	<ul class=" col-lg-3 col-sm-3">
                            	<span class="border_circle"><i class=""><img src="${base}/resources/portal/images/server2_icon1.png" /></i></span>
                            	<li><h3><b>共享会议室</b></h3><p>根据不同需求提供不同
大小和级别的会议室及
多功能厅...</p></li>
                            </ul>
                            <ul  class=" col-lg-3 col-sm-3">
                            	<span class="border_circle"><i class=""><img src="${base}/resources/portal/images/server2_icon2.png" /></i></span>
                            	<li><h3><b>商务餐厅</b></h3><p>分为商务大厅和包间两
种，供应三餐，满足客
户日常就餐和商务宴请
等不同级别需求</p></li>
                            </ul>
                            <ul  class=" col-lg-3 col-sm-3">
                            	<span class="border_circle"><i class=""><img src="${base}/resources/portal/images/server2_icon3.png" /></i></span>
                            	<li><h3><b>商务接待/活动礼仪
</b></h3><p>提供相关配套服务，包
括会场布置、参观指引、
礼仪迎宾、摄影摄像、商
务宴请等 </p></li>
                            </ul>
                            <ul  class=" col-lg-3 col-sm-3">
                            	<span class="border_circle"><i class=""><img src="${base}/resources/portal/images/server2_icon4.png" /></i></span>
                            	<li><h3><b>生活/娱乐类服务
</b></h3><p>楼内设有咖啡厅、洗衣房、小
卖部、文印中心、自动售货机、
自动取款机等配套设施</p></li>
                            </ul>
                            <ul  class=" col-lg-3 col-sm-3">
                            	<span class="border_circle"><i class=""><img src="${base}/resources/portal/images/server2_icon5.png" /></i></span>
                            	<li><h3><b>健身房
</b></h3><p>工作之余的健康之选</p></li>
                            </ul>
                            <ul  class=" col-lg-3 col-sm-3">
                            	<span class="border_circle"><i class=""><img src="${base}/resources/portal/images/server2_icon6.png" /></i></span>
                            	<li><h3><b>机票酒店预订
</b></h3><p>通过专业的第三方预订平
台，提供酒店机票预订服
务，并随时可改签、退订，
出具有效费用明细和凭证</p></li>
                            </ul>
                            <ul  class=" col-lg-3 col-sm-3">
                            	<span class="border_circle"><i class=""><img src="${base}/resources/portal/images/server2_icon7.png" /></i></span>
                            	<li><h3><b>维修服务</b></h3><p>除公共设施设备外，提供
用户自有设施设备的维修
服务</p></li>
                            </ul>
                            <ul  class=" col-lg-3 col-sm-3">
                            	<span class="border_circle"><i class=""><img src="${base}/resources/portal/images/server2_icon8.png" /></i></span>
                            	<li><h3><b>车位租赁
</b></h3><p>用户可采用定制车位方式进
行租赁</p></li>
                            </ul>
                            <ul  class=" col-lg-3 col-sm-3">
                            	<span class="border_circle"><i class=""><img src="${base}/resources/portal/images/server2_icon9.png" /></i></span>
                            	<li><h3><b>信息服务
</b></h3><p>提供有线与无线上网、电
话会议、视频会议、网络、
加速流量管控与上网行为
管理等信息服务</p></li>
                            </ul>
                            <ul  class=" col-lg-3 col-sm-3">
                            	<span class="border_circle"><i class=""><img src="${base}/resources/portal/images/server2_icon10.png" /></i></span>
                            	<li><h3><b>虚拟展厅
</b></h3><p>提供专业的虚拟展厅规划
设计、APP开发服务，以
及虚拟展厅线上运营管理
服务</p></li>
                            </ul>
                            <ul  class=" col-lg-3 col-sm-3">
                            	<span class="border_circle"><i class=""><img src="${base}/resources/portal/images/server2_icon11.png" /></i></span>
                            	<li><h3><b>现场IT服务</b></h3><p>提供桌面电脑、电话安装
服务、软硬件故障排除服
务，会场支持服务、电话
线路申请等现场服务</p></li>
                            </ul>
                            <ul  class=" col-lg-3 col-sm-3">
                            	<span class="border_circle"><i class=""><img src="${base}/resources/portal/images/server2_icon11.png" /></i></span>
                            	<li><h3><b>企业频道IPTV服务
</b></h3><p>提供场地内企业宣传平台</p></li>
                            </ul>
                            
                        </div>
                    </div>
                </div>
         </div ><span id="Artificial" ></span>
        </div>
        
  </div>

        
  </section>
  <script type="text/javascript">
  function top_mao(obj_name){
		var obj_top = $(obj_name).offset().top;
		$("html,body").animate({scrollTop:obj_top-39},300);
	}
  </script>
</body>
</html>
