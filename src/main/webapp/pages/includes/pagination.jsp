<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="UTF-8" %>
<%@ include file="/pages/includes/taglibs.jsp" %>
<c:set var="before" value="3"/>
<c:set var="after" value="3"/>
<c:set var="begin" value="0"/>
<c:set var="end" value="0"/>
<c:if test="${not empty gridBean}">
    <script type="text/javascript">
        var listForm = $('.pagination_form');

        function gotoPage(page) {
            if (null != page) {
                $('#current_page').val(page);
                listForm.submit();
            }
        }
    </script>
    <input type="hidden" name="page" id="current_page" value="${gridBean.page}">
    <ul class="pagination pull-right">


        <c:choose>
            <c:when test="${gridBean.page<= 1}">
                <li class="disabled"><a href="#">«</a></li>
            </c:when>
            <c:otherwise>
                <li><a href="javascript:gotoPage(${gridBean.page-1});">«</a></li>
            </c:otherwise>
        </c:choose>

        <c:choose>
            <c:when test="${gridBean.page == 1}">
                <li class="active"><a href="#">1</a></li>
            </c:when>
            <c:otherwise>
                <li><a href="javascript:gotoPage(1);">1</a></li>
            </c:otherwise>
        </c:choose>

        <c:if test="${gridBean.total >=3}">

            <c:choose>
                <c:when test="${1 <= gridBean.page-before-after}">
                    <c:set var="begin" value="${before+after}"/>
                </c:when>
                <c:when test="${1 < gridBean.page-before && 1 > gridBean.page-before-after}">
                    <c:set var="begin" value="${gridBean.page}"/>
                </c:when>
                <c:when test="${1 >= gridBean.page-before}">
                    <c:set var="begin" value="${gridBean.page-before+1}"/>
                </c:when>
            </c:choose>

            <c:choose>
                <c:when test="${gridBean.total >= gridBean.page+before+after}">
                    <c:set var="end" value="${before+after}"/>
                </c:when>
                <c:when test="${gridBean.total > gridBean.page+after && gridBean.total < gridBean.page+before+after}">
                    <c:set var="end" value="${(gridBean.total-(gridBean.page+after)+after)}"/>
                </c:when>
                <c:when test="${gridBean.total <= gridBean.page+after}">
                    <c:set var="end" value="${gridBean.total-gridBean.page}"/>
                </c:when>
            </c:choose>

            <c:if test="${begin >= 3 && end >= 3}">
                <c:set var="begin" value="3"/>
                <c:set var="end" value="3"/>
            </c:if>

            <c:if test="${begin>0}">
                <c:forEach begin="${gridBean.page-begin}" end="${gridBean.page-1}" var="p">
                    <c:if test="${p!=0&&p!=1}">
                        <li><a href="javascript:gotoPage(${p});">${p}</a></li>
                    </c:if>
                </c:forEach>
            </c:if>

            <c:if test="${gridBean.page != 1&&gridBean.page != gridBean.total}">
                <li class="active"><a href="#">${gridBean.page}</a></li>
            </c:if>

            <c:if test="${end>0}">
                <c:forEach begin="${gridBean.page+1}" end="${gridBean.page+end-1}" var="p">
                    <li><a href="javascript:gotoPage(${p});">${p}</a></li>
                </c:forEach>
            </c:if>

        </c:if>

        <c:if test="${gridBean.total >= 2}">
            <c:choose>
                <c:when test="${gridBean.page == gridBean.total}">
                    <li class="active"><a href="#">${gridBean.total}</a></li>
                </c:when>
                <c:otherwise>
                    <li><a href="javascript:gotoPage(${gridBean.total});">${gridBean.total}</a></li>
                </c:otherwise>
            </c:choose>
        </c:if>

        <c:choose>
            <c:when test="${gridBean.page >= gridBean.total}">
                <li class="disabled"><a href="#">»</a></li>
            </c:when>
            <c:otherwise>
                <li><a href="javascript:gotoPage(${gridBean.page+1});">»</a></li>
            </c:otherwise>
        </c:choose>

        <li>
            <a>共${gridBean.records}条</a>
        </li>
    </ul>
</c:if>
<c:if test="${empty gridBean}">
    <ul class="pagination pull-right">
        <li>
            没有获取到任何符合数据。
        </li>
    </ul>
</c:if>