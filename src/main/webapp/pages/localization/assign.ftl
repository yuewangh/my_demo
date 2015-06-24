<#if request??&&request.contextPath??>
    <#assign base=request.contextPath>
<#else>
    <#assign base=''>
    <#assign path=''>
</#if>