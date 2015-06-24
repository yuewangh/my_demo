<#macro isActive c p>
    <#if c==p>
    <li class="active"><a href="#">${p}</a></li>
    <#else>
    <li><a href="?page=${p}">${p}</a></li>
    </#if>
</#macro>

<#if gridBean?? && gridBean.rows??>
<div class="row">
    <div class="col-sm-3">
        <div class="dataTables_info" id="sample-table-2_info">
            <input type="hidden" name="page" value="${gridBean.page}"/>
        </div>
    </div>
    <div class="col-sm-9">
        <div class="dataTables_paginate paging_bootstrap">
            <ul class="pagination">
                <#if gridBean.hasPre??&&gridBean.hasPre>
                    <li class="prev"><a href="?page=${gridBean.prePage}"><i class="icon-double-angle-left"></i></a></li>
                <#else>
                    <li class="prev disabled"><a href="#"><i class="icon-double-angle-left"></i></a></li>
                </#if>

                <#if gridBean.page==1>
                    <li class="active"><a href="#">1</a></li>
                <#else>
                    <li><a href="?page=1">1</a></li>
                </#if>

                <#if gridBean.total!=1>

                    <#if (gridBean.total>2)>
                        <#if (gridBean.total<7)>
                            <#list 2..gridBean.total as s>
                                <@isActive gridBean.page s/>
                            </#list>
                        <#elseif (gridBean.total-gridBean.page<7)>
                            <#list gridBean.total-6..gridBean.total as s>
                                <@isActive gridBean.page s/>
                            </#list>
                        <#else>
                            <#list gridBean.page-3..gridBean.page as s>
                                <@isActive gridBean.page s/>
                            </#list>
                            <#list gridBean.page+1..gridBean.page+4 as s>
                                <@isActive gridBean.page s/>
                            </#list>
                        </#if>
                    </#if>

                    <#if gridBean.page==gridBean.total>
                        <li class="active"><a href="#">1</a></li>
                    <#else>
                        <li><a href="?page=${gridBean.total}">${gridBean.total}</a></li>
                    </#if>
                </#if>

                <#if gridBean.hasNext??&&gridBean.hasNext>
                    <li class="next"><a href="?page=${gridBean.nextPage}"><i class="icon-double-angle-right"></i></a>
                    </li>
                <#else>
                    <li class="next disabled"><a href="#"><i class="icon-double-angle-right"></i></a></li>
                </#if>
            </ul>
        </div>
    </div>
</div>
</#if>