<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="UTF-8" %>
<%@ include file="/pages/includes/taglibs.jsp" %>
<c:set var="before" value="3"/>
<c:set var="after" value="3"/>
<c:set var="begin" value="0"/>
<c:set var="end" value="0"/>
<c:if test="${not empty pageModel}">
    <script type="text/javascript">
        var listForm = $('.pagination_form');

        function gotoPage(page) {
            if (null != page) {
                $('#current_page').val(page);
                listForm.submit();
            }
        }
        //alert("${pageModel.page}");
    </script>
    <input type="hidden" name="page" id="current_page" value="${pageModel.page}">
    <ul class="pagination pagination-lg pull-right user_page">


        <c:choose>
            <c:when test="${pageModel.page<= 1}">
                <li class="disabled">
                    <a class="icon" href="#"><i class="fa fa-long-arrow-left"></i></a>
                </li>
            </c:when>
            <c:otherwise>
                <li>
                    <a class="icon" href="javascript:gotoPage(${pageModel.page-1});" class="disabled"><i class="fa fa-long-arrow-left"></i></a>
                </li>
            </c:otherwise>
        </c:choose>

        <c:choose>
            <c:when test="${pageModel.page == 1}">
                <li class="active"><a href="#">1</a></li>
            </c:when>
            <c:otherwise>
                <li><a href="javascript:gotoPage(1);">1</a></li>
            </c:otherwise>
        </c:choose>

        <c:if test="${pageModel.total >=3}">

            <c:choose>
                <c:when test="${1 <= pageModel.page-before-after}">
                    <c:set var="begin" value="${before+after}"/>
                </c:when>
                <c:when test="${1 < pageModel.page-before && 1 > pageModel.page-before-after}">
                    <c:set var="begin" value="${pageModel.page}"/>
                </c:when>
                <c:when test="${1 >= pageModel.page-before}">
                    <c:set var="begin" value="${pageModel.page-before+1}"/>
                </c:when>
            </c:choose>

            <c:choose>
                <c:when test="${pageModel.total >= pageModel.page+before+after}">
                    <c:set var="end" value="${before+after}"/>
                </c:when>
                <c:when test="${pageModel.total > pageModel.page+after && pageModel.total < pageModel.page+before+after}">
                    <c:set var="end" value="${(pageModel.total-(pageModel.page+after)+after)}"/>
                </c:when>
                <c:when test="${pageModel.total <= pageModel.page+after}">
                    <c:set var="end" value="${pageModel.total-pageModel.page}"/>
                </c:when>
            </c:choose>

            <c:if test="${begin >= 3 && end >= 3}">
                <c:set var="begin" value="3"/>
                <c:set var="end" value="3"/>
            </c:if>

            <c:if test="${begin>0}">
                <c:forEach begin="${pageModel.page-begin}" end="${pageModel.page-1}" var="p">
                    <c:if test="${p!=0&&p!=1}">
                        <li><a href="javascript:gotoPage(${p});">${p}</a></li>
                    </c:if>
                </c:forEach>
            </c:if>

            <c:if test="${pageModel.page != 1&&pageModel.page != pageModel.total}">
                <li class="active"><a href="#">${pageModel.page}</a></li>
            </c:if>

            <c:if test="${end>0}">
                <c:forEach begin="${pageModel.page+1}" end="${pageModel.page+end-1}" var="p">
                    <li><a href="javascript:gotoPage(${p});">${p}</a></li>
                </c:forEach>
            </c:if>

        </c:if>

        <c:if test="${pageModel.total >= 2}">
            <c:choose>
                <c:when test="${pageModel.page == pageModel.total}">
                    <li class="active"><a href="#">${pageModel.total}</a></li>
                </c:when>
                <c:otherwise>
                    <li><a href="javascript:gotoPage(${pageModel.total});">${pageModel.total}</a></li>
                </c:otherwise>
            </c:choose>
        </c:if>

        <c:choose>
            <c:when test="${pageModel.page >= pageModel.total}">
                <li class="disabled">
                  <a class="icon" href="#"><i class="fa fa-long-arrow-right"></i></a>
                </li>
            </c:when>
            <c:otherwise>
                <li>
                  <a class="icon" href="javascript:gotoPage(${pageModel.page+1});"><i class="fa fa-long-arrow-right"></i></a>
                </li>
            </c:otherwise>
        </c:choose>

        <li>
            <a>共${pageModel.records}条</a>
        </li>
    </ul>
</c:if>
<c:if test="${empty pageModel}">
    <ul class="pagination pull-right">
        <li>
            没有获取到任何符合数据。
        </li>
    </ul>
</c:if>