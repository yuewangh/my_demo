package com.isoftstone.demo.operation_log.Aspectj;

import java.lang.reflect.Method;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.builder.ReflectionToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import org.apache.commons.logging.LogFactory;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.isoftstone.demo.operation_log.model.Log;
import com.isoftstone.demo.operation_log.model.Operation_log;
import com.isoftstone.demo.operation_log.model.Operation_log.Successed;
import com.isoftstone.demo.operation_log.service.Operation_logService;
import com.isoftstone.demo.security.util.SecurityUtils;
import com.isoftstone.demo.userManager.model.User;

/**
 * 记录被{@link com.isoftstone.demo.operation_log.model.Log}注解标记的方法，所产生的操作日志<br/>
 * 其中在执行方法前获取相应的注解值和方法参数；<br/>
 * 被标记方法执行完成后，保存所产生的日志；<br/>
 * 如果标记方法在执行过程中失败或异常，则记录失败的日志。
 */
@Aspect
@Component
public class OperationLogAspectj {
	
	private static org.apache.commons.logging.Log logger = LogFactory.getLog(OperationLogAspectj.class);
	private Log logAnn;
	@Autowired
	private Operation_logService operation_logService;
	private static String useruuid;
	private static String loginname;
	private static String fullname;
	private static String userip;
	private static String bId;
	private static String content;
	@Pointcut("@annotation(com.isoftstone.demo.operation_log.model.Log)")
	public void executeLog(){};
	
	@SuppressWarnings("rawtypes")
	@Before(value = "executeLog()")
	public void initOperationLog(JoinPoint jp){
		logger.trace("切面 @Before OperationLogAspectj initOperationLog(@annotation(com.isoftstone.demo.operation_log.model.Log))");
		String _signatureName = jp.getSignature().getName();
		Class targetClass = jp.getTarget().getClass();
		logger.trace(String.format("Join Point kind : %s", jp.getKind()));
		logger.trace(String.format("Signature declaring type : %s", jp.getSignature().getDeclaringTypeName()));
		logger.trace(String.format("Signature name : %s", _signatureName));
		logger.trace(String.format("Target class : %s", targetClass.getName()));
		logger.trace(String.format("This class : %s", jp.getThis().getClass().getName()));
		
		Object[] args = jp.getArgs();
		getRequestArgs(args);
		
		Method[] targetMethods = targetClass.getDeclaredMethods();
		for (Method _method : targetMethods) {
			if (_method.getName().equalsIgnoreCase(_signatureName)) {
				logAnn = _method.getAnnotation(Log.class);
			}
		}
	}
	
	@SuppressWarnings("unchecked")
	@AfterReturning(value = "executeLog()", returning = "result")
	public void executeResultMethod(Object result){
		logger.debug("=====>返回结果内容：" + ReflectionToStringBuilder.toString(result, ToStringStyle.MULTI_LINE_STYLE));
		if (result != null) {
			Map<String, Object> tageResult = null;
			if (result instanceof ModelAndView){
				tageResult =( (ModelAndView) result).getModel();
			} else if (result instanceof Map){
				tageResult = (Map<String, Object>) result;
			}
			if (tageResult == null)
				throw new IllegalArgumentException("您执行的方法的返回值类型错误，请返回 java.util.Map 或 org.springframework.web.servlet.ModelAndView类型");
			if(bId == null) {
				bId = (String) tageResult.get("bId");
			}
			content = (String) tageResult.get("content");
			if(useruuid == null){
				useruuid = (String) tageResult.get("useruuid");
				if(useruuid != null){
					loginname = (String) tageResult.get("loginname");
					fullname = (String) tageResult.get("fullname");
				}
			}
			if(userip == null){
				userip = (String) tageResult.get("ip");
			}
			
		}
		this.createLog(Successed.SUCCESSED, "");
	}
	
	@AfterThrowing(value = "executeLog()", argNames = "exception", throwing = "exception")
	public void throwProcess(Exception exception){
		logger.trace("执行带有返回值的方法");
		bId = "-1";
		this.createLog(Successed.FAILED, exception.getMessage());
	}
	
	private void createLog(Successed successed, String cause){
		if (bId == null)
			throw new IllegalArgumentException("您执行的方法的参数和返回值中都没有bId(business id)参数，导致无法保存日志");
		Operation_log oLog = new Operation_log(logAnn, useruuid, loginname, fullname, userip, bId, successed, cause,content);
		logger.debug("=====>日志内容：" + ReflectionToStringBuilder.toString(oLog, ToStringStyle.MULTI_LINE_STYLE));
		operation_logService.insert(oLog);
	}

	/**
	 * 从{@link javax.servlet.http.HttpSession}中获取登录用户的id
	 * @param args controller方法的参数
	 */
	private void getRequestArgs(Object[] args) {
		HttpServletRequest req = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		if (req != null){
			User usr;
			try {
				usr = SecurityUtils.getUserInfoDetails();
				useruuid = usr.getUuid();
				loginname = usr.getLoginName();
				fullname = usr.getName();
			} catch (Exception e) {
				useruuid = null;
				loginname = "未登录用户";
				fullname = "未登录用户";
			}
			bId = req.getAttribute("bId") == null ? req.getParameter("bId") : (String) req.getAttribute("bId");
			userip = req.getRemoteAddr();
		}
	}
}
