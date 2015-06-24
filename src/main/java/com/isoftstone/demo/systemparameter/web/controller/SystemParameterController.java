package com.isoftstone.demo.systemparameter.web.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.isoftstone.demo.common.exception.CustomException;
import com.isoftstone.demo.common.model.PageModel;
import com.isoftstone.demo.common.util.PageOrder;
import com.isoftstone.demo.common.util.StringUtil;
import com.isoftstone.demo.systemparameter.model.DictionaryUnit;
import com.isoftstone.demo.systemparameter.model.SystemParameter;
import com.isoftstone.demo.systemparameter.service.SystemParameterService;

@Controller
@RequestMapping("/dictionary")
public class SystemParameterController{
    /**
     *
     */
    final Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    private SystemParameterService systemParameterService;
    
    private SystemParameter systemParameter;

    public SystemParameter getSystemParameter() {
		return systemParameter;
	}


	public void setSystemParameter(SystemParameter systemParameter) {
		this.systemParameter = systemParameter;
	}
	@RequestMapping("/index")
    @ResponseBody
	public  ModelAndView index(String duId,HttpServletRequest request){
		  List<DictionaryUnit> list = systemParameterService.getAllDictionaryUnitBean();
	        if(!StringUtil.isNull(duId)){
	        	DictionaryUnit dictionaryUnit = systemParameterService.findDictionaryUnitBeanById(duId);
	        	request.setAttribute("dictionaryUnit", dictionaryUnit);
	        }else{
	        	request.setAttribute("dictionaryUnit", list.get(0));
	        }
		return  new ModelAndView("/pages/dictionary/index.jsp");
	}

	/**
     * @return
     */
	@RequestMapping(value = "/getList")
    @ResponseBody
    public PageModel<SystemParameter>  getList(
    		@RequestParam(value = "page", required = false, defaultValue = "1") int page,
			@RequestParam(value = "sidx", required = false) String sidx,
			@RequestParam(value = "sord", required = false) String sord,
			@RequestParam(value = "rows", required = false, defaultValue = "10") int rows,
			String duId,String paramKey,String paramName,HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		 Map<String, String> order = new HashMap<String, String>();
 		if (StringUtils.isNotEmpty(sidx))
 			order.put(PageOrder.NAME, sidx);
 		if (StringUtils.isNotEmpty(sord))
 			order.put(PageOrder.TYPE, sord);
 		 if (!StringUtil.isNull(paramKey))
             map.put("paramKey", paramKey);
        if (!StringUtil.isNull(paramName))
            map.put("paramName", paramName);
        
        /* ------------数据字典方法 begin------------ */
        if (!StringUtil.isNull(duId)) {
            try {
                map.put("duId", duId);
                DictionaryUnit dictionaryUnit = systemParameterService.findDictionaryUnitBeanById(duId);
                request.setAttribute("dictionaryUnit", dictionaryUnit);
            } catch (NumberFormatException e) {
                duId = null;
            } catch (Exception e) {
                duId = null;
            }
        }

        if (duId != null && !"".equals(duId)
                && !"undefined".equals(duId) && !"null".equals(duId)) {
            request.setAttribute("id", duId);
        }
        /* ------------数据字典方法 end------------ */

        PageModel<SystemParameter> pageModel = systemParameterService.findGridByParams(map, page, rows, order);
        request.setAttribute("pageModel", pageModel);
        request.setAttribute("paramName", paramName);
        return pageModel;
    }
	/**
	    * @Title: systemParameterView
	    * @param @return
	    * @return ModelAndView
	    * @throws
	     */
	    @RequestMapping("/systemParameterView")
	    public ModelAndView systemParameterView(String duId,String operateType,String uuid,HttpServletRequest request){
	    	if(operateType.toLowerCase().equals("add")){
	    		SystemParameter systemParameter = new SystemParameter();
	            if (StringUtils.isNotEmpty(duId)) {
	                try {
	                    DictionaryUnit dictionaryUnit = systemParameterService.findDictionaryUnitBeanById(duId);
	                    systemParameter.setDuId(dictionaryUnit.getUuid());
	                    if (!"none".equals(dictionaryUnit.getParamType())){
	                    	systemParameter.setParamKey(dictionaryUnit.getParamKey());
	                    	systemParameter.setParamType("string");
	                    }
	                    systemParameter.setParamType(dictionaryUnit.getParamType());
	                    request.setAttribute("systemParameter", systemParameter);
	                    request.setAttribute("dictionaryUnit", dictionaryUnit);
	                } catch (NumberFormatException e) {
	                    e.printStackTrace();
	                }
	            }
	    		return new ModelAndView("/pages/dictionary/systemParameterInfo.jsp");
	    	}
	    	if(operateType.toLowerCase().equals("update")){
	    		try {
	    			SystemParameter systemParameter = systemParameterService.loadSystemParameterBean(uuid);
					request.setAttribute("systemParameter", systemParameter);
				} catch (CustomException e) {
					e.printStackTrace();
				}
	    		return new ModelAndView("/pages/dictionary/systemParameterInfo.jsp");
	    	}
	    	if(operateType.toLowerCase().equals("detail")){
	    		try {
	    			SystemParameter systemParameter = systemParameterService.loadSystemParameterBean(uuid);
					request.setAttribute("systemParameter", systemParameter);
				} catch (CustomException e) {
					e.printStackTrace();
				}
	    		return new ModelAndView("/pages/dictionary/systemParameterDetail.jsp");
	    	}
	    	return new ModelAndView("/pages/dictionary/systemParameterInfo.jsp");
	    }
    /**
     * @return 添加
     */
	@RequestMapping(value = "/add")
    @ResponseBody
    public Map<String,Object> add(String duId,HttpServletRequest request) {
		Map<String,Object> messageMap = new  HashMap<String,Object>();
        systemParameter = new SystemParameter();
        if (StringUtils.isNotEmpty(duId)) {
            try {
                DictionaryUnit dictionaryUnit = systemParameterService.findDictionaryUnitBeanById(duId);
                systemParameter.setDuId(dictionaryUnit.getUuid());
                if (!"none".equals(dictionaryUnit.getParamType())||!"text".equals(dictionaryUnit.getParamType())){
                    systemParameter.setParamKey(dictionaryUnit.getParamKey());
                    systemParameter.setParamType(dictionaryUnit.getParamType());
                }
                request.setAttribute("summary", dictionaryUnit.getSummary());
                messageMap.put("success", true);
            } catch (NumberFormatException e) {
                e.printStackTrace();
                messageMap.put("success", false);
            }
        }
        return messageMap;
    }

    /**
     * @return 修改
     */
	@RequestMapping(value = "/update")
    @ResponseBody
    public Map<String,Object> update(String id, String duId,HttpServletRequest request) {
		Map<String,Object> messageMap = new  HashMap<String,Object>();
        if (id != null && !StringUtil.isNull(id)) {
            try {
                DictionaryUnit dictionaryUnit = systemParameterService.findDictionaryUnitBeanById(duId);
                systemParameter = systemParameterService.loadSystemParameterBean(id);
                request.setAttribute("summary", dictionaryUnit.getSummary());
                messageMap.put("success", true);
            } catch (Exception e) {
                e.printStackTrace();
                messageMap.put("success", false);
            }
        }
        return messageMap;
    }


    /**
     * @return 展示
     */
	@RequestMapping(value = "/showText")
    @ResponseBody
    public String showText(String id,HttpServletRequest request) {
        if (id != null && !StringUtil.isNull(id)) {
            try {
                systemParameter = systemParameterService.loadSystemParameterBean(id);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return "success";
    }

    /**
     * @return 保存
     */
	@RequestMapping(value = "/saveOrUpdate")
    @ResponseBody
    public Map<String,Object> saveOrUpdate(@ModelAttribute SystemParameter systemParameter) {
		Map<String,Object> messageMap = new  HashMap<String,Object>();
        try {
        	if (StringUtils.isEmpty(systemParameter.getUuid())) {
        		  systemParameterService.saveSystemParameter(systemParameter);
                  messageMap.put("opt", "保存");
        	}else{
        		  systemParameterService.updateSystemParameter(systemParameter);
                  messageMap.put("opt", "更新");
        	}
        	systemParameterService.refreshSystemParameter(systemParameter);
            messageMap.put("success", true);
        } catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage());
            messageMap.put("success", false);
        }
        return messageMap;
    }

    /**
     * @return
     */
	  @RequestMapping(value = "/delete")
	  @ResponseBody
    public Map<String,Object> delete(String idStr,String did,HttpServletRequest request) {
		Map<String,Object> messageMap = new  HashMap<String,Object>();
        try {
            if (StringUtils.isNotEmpty(idStr)) {
                systemParameterService.deleteSystemParameterByIds(idStr.split(","));

                if (StringUtils.isNotEmpty(did)) {
                	//刷新缓存
                    systemParameterService.refreshSystemParameter(did);
                }
                messageMap.put("success", true);
            }
        } catch (Exception e) {
            e.printStackTrace();
            messageMap.put("success", false);
            logger.error(e.getMessage());
        }
        messageMap.put("did", did);
        return messageMap;
    }

    /**
     * @return
     */
    @RequestMapping(value = "/menu")
    @ResponseBody
    public List<DictionaryUnit> showDictionaryUnitMenu(HttpServletRequest request) {
        List<DictionaryUnit> list = systemParameterService.getAllDictionaryUnitBean();
        request.setAttribute("duList", list);
        return list;
    }

    /**
     * @return
     */
    @RequestMapping(value = "/isNotExist")
    @ResponseBody
    public Boolean isNotExist(String paramKey) {
        boolean exist = false;
        String val = systemParameterService.getValueByKey(paramKey);
        if (val == null)
            exist = true;
        return exist;
    }


    /**
     * @return
     */
    @RequestMapping(value = "/nameIsNotExist")
    @ResponseBody
    public Boolean  nameIsNotExist(String duId,String paramName) {
        boolean exist = false;
        exist = systemParameterService.validateForName(duId, paramName);
        return exist;
    }
}
