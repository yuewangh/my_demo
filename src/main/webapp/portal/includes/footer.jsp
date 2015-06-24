<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<%@ include file="/pages/includes/taglibs.jsp" %>
 <!-- .footer start --> 
  <!-- ================ -->
  <div class="footer">
    <div class="container">
      <div class="row">
        <div class="col-sm-6">
          <div class="footer-content">
            <h3><i class="fa fa-phone pr-10"></i><sys:param key="HOT_LINE"/></h3>
            <ul class="list-icons">
              <a target="_blank" href="${path}/portal/link/aboutUs.vhtml">关于我们</a>   | <a target="_blank" href="${path }/portal/link/privacyPolicy.vhtml">隐私政策</a>   |  <a target="_blank" href="${path }/portal/link/lawStatement.vhtml">招聘信息</a>   |  <a target="_blank" href="${path }/portal/link/contactUs.vhtml">联系我们</a>
              <li><sys:param key="PORTAL_COPY_RIGHT"/></li>
            </ul>
          </div>
          
        </div>
        <div class="pull-right">
          <!-- JiaThis Button BEGIN -->
          <!-- <div class="share">
			<span class="jiathis_txt">分享到：</span>
          <div id="ckepop">
<a class="jiathis_button_tsina"></a>
<a class="jiathis_button_weixin"></a>
</div> 
</div>
<script type="text/javascript" src="http://v3.jiathis.com/code/jia.js?uid=1" charset="utf-8"></script> JiaThis Button END -->
          	<p class="code">
            	<img width="120" src="<sys:param key="WEIXIN_PUBLIC"/>">
            	<font style="line-height:35px;" size="-1">扫一扫，添加公众号</font>
            </p>
            <p class="code" style="padding-left:20px;text-align:center;">
            	<img width="120" src="<sys:param key="QR_CODE_ANDROID"/>">
            	<font style="line-height:35px;" size="-1">Android客户端下载</font>
            </p>
            <p class="code" style="padding-left:20px;text-align:center;">
            	<img width="120" src="<sys:param key="QR_CODE_IOS"/>">
            	<font style="line-height:35px;" size="-1">IOS客户端下载</font>
            </p>
        </div>
          </div>
      </div>
  </div>
  <!-- .footer end --> 