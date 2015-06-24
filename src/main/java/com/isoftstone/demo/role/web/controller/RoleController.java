package com.isoftstone.demo.role.web.controller;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.isoftstone.demo.common.exception.CustomException;
import com.isoftstone.demo.common.model.PageModel;
import com.isoftstone.demo.common.model.TreeBean;
import com.isoftstone.demo.common.util.StringUtil;
import com.isoftstone.demo.operation_log.enumeration.ModeName;
import com.isoftstone.demo.operation_log.model.Log;
import com.isoftstone.demo.role.model.Resource;
import com.isoftstone.demo.role.model.Role;
import com.isoftstone.demo.role.service.ResourceService;
import com.isoftstone.demo.role.service.RoleService;
import com.isoftstone.demo.userManager.model.User;

@RequestMapping("/system/role")
@Controller
public class RoleController {
	/*<result name="success" type="dispatcher">/pages/role/roleIndex.jsp</result>
    <result name="edit">/pages/role/edit.jsp</result>
    <result name="reload" type="json">
        <param name="root">#request.actionMessage</param>
    </result>
    <result name="find" type="json">
        <param name="root">#request.exist</param>
    </result>
    <result name="assign">/pages/role/assign.jsp</result>
    <result name="tree" type="json">
        <param name="root">#request.tree</param>
    </result>
    <result name="saved" type="redirectAction">role_home</result>*/
	@Autowired
	RoleService roleService;
	@Autowired
	ResourceService resourceService;
	
	@RequestMapping("/index")
	public ModelAndView index(){
		return new ModelAndView("/pages/role/list.jsp");
	}
    @RequestMapping(method = RequestMethod.GET, value = "/list", headers = "Accept=application/json")
	@ResponseBody
	public PageModel<Role> list(
			@RequestParam(value="key",defaultValue="") String key,
			@RequestParam(value="name",defaultValue="")String name,
			@RequestParam(value="survivalStr",defaultValue="")String survivalStr,
			@RequestParam(value="page",defaultValue="1")String page,
			@RequestParam(value="rows")String rows
			){
        Map<String, Object> params = new HashMap<String, Object>();
        if (!StringUtil.isNull(key)) {
            params.put("key", key);
        }
        if (!StringUtil.isNull(name)) {
            params.put("name", name);
        }
        
        if (StringUtils.isNotEmpty(survivalStr)) {
        	if("true".equals(survivalStr)){
        	  params.put("survivalStatus", true);
        	}else{
        		params.put("survivalStatus", false);
        	}
        }
        params.put("hideStatus", false);
        PageModel<Role> model = roleService.findRoleInfoGridByParams(params, page,rows);
		return model;
    }
    @RequestMapping("/addOrUpdateView")
    public ModelAndView addOrUpdateView(@RequestParam(value="uuid",defaultValue="")String uuid,Model model){
    	if(!"".equals(uuid)){
    		Role role = new Role();
			try {
				role = roleService.getRoleById(uuid);
			} catch (CustomException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
    		model.addAttribute("role",role);
    	}
    	return new ModelAndView("/pages/role/roleInfo.jsp");
    }
    @RequestMapping(value="/assignView")
    public ModelAndView assignView(@RequestParam(value="uuid",required=true)String uuid,HttpServletRequest request){
    	request.setAttribute("uuid",uuid);
    	return new ModelAndView("/pages/role/assign.jsp");
    }

    @RequestMapping( value = "/saveAssign")
	@ResponseBody
    public Boolean saveAssign(@RequestParam(value="roleId",defaultValue="")String roleId,@RequestParam(value="authIds",defaultValue="")String authIds,HttpServletRequest request){
    	if(!"".equals(roleId) && !"".equals(authIds)){
    		try {
				roleService.saveAssign(roleId, authIds);
				return true;
			} catch (CustomException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
    	}
    	return false;
    }

    @RequestMapping(value = "/tree")
	@ResponseBody
    public List<TreeBean> tree(@RequestParam(value="uuid")String uuid){
    	Role role;
		try {
			role = roleService.getRoleById(uuid);
	    	Set<Resource> resourceList = role.getPrivileges();
	    	List<Resource> list = new ArrayList<Resource>();
	    	for (Iterator iterator = resourceList.iterator(); iterator.hasNext();) {
				Resource resource = (Resource) iterator.next();
				list.add(resource);
				
			}
	    	List<TreeBean> tree = resourceService.getAuthorizedTree(list);
	    	return tree;
		} catch (CustomException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	return null;
    }

    @RequestMapping(value = "/saveRole")
	@ResponseBody
    public Role saveRole(@ModelAttribute Role role,HttpServletRequest request){
    	if(role != null && role.getDescription() != null)
    		role.setDescription(role.getDescription().trim());
    	roleService.saveRole(role);
    	return role;
    }

	@Log(type = ModeName.ROLE, content = "进行了删除操作")
    @RequestMapping(value = "/delete")
	@ResponseBody
    public Map<String,Object> deleteRole(@RequestParam(value="ids",defaultValue="")String ids){
    	HashMap<String,Object> ret = new HashMap<String,Object>();
    	boolean flag = false;
    	String msg = "";
        String[] idArray = ids.split(",");
        for (int i = 0; i < idArray.length; i++) {
            Role role;
			try {
				role = roleService.getRoleById(idArray[i]);
	            Set<User> users = role.getUsers();
	            //如果users非空，说明有关联的用户
	            if (!users.isEmpty()) {
	                msg =  "该角色已关联用户，不能被删除!";
	            }
			} catch (CustomException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				msg = "获取角色信息异常！请稍后重试！";
			}
        }
        try {
            if (StringUtils.isNotEmpty(ids)) {
                roleService.deleteBulkRole(ids);
                msg = "角色信息删除成功!";
                flag = true;
            }else{
            	msg = "请选择需要删除的角色";
            }
        } catch (Exception e) {
            e.printStackTrace();
            msg = "角色信息删除失败!";
        }
        ret.put("success",flag);
        ret.put("msg",msg);
        ret.put("bId",ids);
        return ret;
    }
    
    @RequestMapping(method = RequestMethod.GET, value = "/validateRoleKey", headers = "Accept=application/json")
	@ResponseBody
    public Boolean validateRoleKey(@RequestParam(value="key",defaultValue="")String key){
    	try {
            key = new String(key.getBytes("ISO8859-1"), "UTF-8");
        } catch (UnsupportedEncodingException e1) {
            e1.printStackTrace();
        }
        boolean flag = false;
        if (roleService.findRoleInfoByKey(key) == null) {
            flag = true;
        }
        return flag;
    }
}
