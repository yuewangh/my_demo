package com.isoftstone.demo.information.web.controller;

import com.isoftstone.demo.common.model.PageModel;
import com.isoftstone.demo.common.util.PageOrder;
import com.isoftstone.demo.information.constants.InformationConstants;
import com.isoftstone.demo.information.model.Information;
import com.isoftstone.demo.information.model.InformationText;
import com.isoftstone.demo.information.service.InformationService;
import com.isoftstone.demo.security.util.SecurityUtils;
import com.isoftstone.demo.userManager.model.User;
import com.isoftstone.demo.userManager.model.UserAccount;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Group: 姚丰利（lidey）
 * Date: 2015-04-24
 * Time: 09:39
 * To change this template use File | Settings | File Templates.
 */
@Controller
@RequestMapping("/library/information")
public class InformationController {

    @Autowired
    private InformationService informationService;

    @RequestMapping("/{portletId}/index")
    public String index(@PathVariable(value = "portletId") String portletId, Model model) {
        model.addAttribute("portletId", portletId);
        return "/pages/information/index.ftl";
    }

    /**
     * @param params
     * @param page
     * @param sidx
     * @param sord
     * @param title
     * @param portletId
     * @param limit
     * @return
     */
    private PageModel<Information> getGrid(Map<String, Object> params, int page, String sidx, String sord,
                                           String title, String portletId, int limit) {
        Map<String, String> order = new HashMap<String, String>();

        if (StringUtils.isNotEmpty(sidx))
            order.put(PageOrder.NAME, sidx);
        if (StringUtils.isNotEmpty(sord))
            order.put(PageOrder.TYPE, sord);

        if (StringUtils.isNotEmpty(title))
            params.put("title", title);

        return informationService.findInformationGridByParam(params, page, limit, order);
    }

    /**
     * @param page
     * @param sidx
     * @param sord
     * @param title
     * @param portletId
     * @param limit
     * @param request
     * @return
     */
    @RequestMapping(value = "/{portletId}/getInformationDraftGrid", method = RequestMethod.GET, produces = "application/json")
    @ResponseBody
    public PageModel<Information> getInformationDraftGrid(
            @PathVariable(value = "portletId") String portletId,
            @RequestParam(value = "page", required = false, defaultValue = "1") int page,
            @RequestParam(value = "sidx", required = false) String sidx,
            @RequestParam(value = "sord", required = false) String sord,
            @RequestParam(value = "status", required = false) String status,
            @RequestParam(value = "title", required = false) String title,
            @RequestParam(value = "limit", required = false, defaultValue = "15") int limit,
            HttpServletRequest request) {
        Map<String, Object> params = new HashMap<String, Object>();
        if (StringUtils.isNotEmpty(status)) {
            params.put("status", InformationConstants.parseStatus(status));
        } else {
            List<InformationConstants.status> statusList = new ArrayList<InformationConstants.status>();
            statusList.add(InformationConstants.status.DRAFT);
            statusList.add(InformationConstants.status.REJECT);
            statusList.add(InformationConstants.status.AUDIT);
            params.put("status", statusList);
        }
        if (StringUtils.isNotEmpty(portletId))
            params.put("portletId", portletId);
        User userAccount = SecurityUtils.getUserInfoDetails();
        params.put("authorId", userAccount.getUuid());
        return this.getGrid(params, page, sidx, sord, title, portletId, limit);
    }

    /**
     * @param page
     * @param sidx
     * @param sord
     * @param title
     * @param portletId
     * @param limit
     * @param request
     * @return
     */
    @RequestMapping(value = "/{portletId}/getInformationManagerGrid", method = RequestMethod.GET, produces = "application/json")
    @ResponseBody
    public PageModel<Information> getInformationPromulgationGrid(
            @RequestParam(value = "page", required = false, defaultValue = "1") int page,
            @RequestParam(value = "sidx", required = false) String sidx, @RequestParam(value = "sord", required = false) String sord,
            @RequestParam(value = "title", required = false) String title, @RequestParam(value = "status", required = false) String status,
            @PathVariable(value = "portletId") String portletId,
            @RequestParam(value = "limit", required = false, defaultValue = "15") int limit, HttpServletRequest request) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("status", InformationConstants.status.PROMULGATION);
        if (StringUtils.isNotEmpty(status)) {
            params.put("status", InformationConstants.parseStatus(status));
        } else {
            List<InformationConstants.status> statusList = new ArrayList<InformationConstants.status>();
            statusList.add(InformationConstants.status.PROMULGATION);
            statusList.add(InformationConstants.status.HIDE);
            params.put("status", statusList);
        }
        if (StringUtils.isNotEmpty(portletId))
            params.put("portletId", portletId);
        return this.getGrid(params, page, sidx, sord, title, portletId, limit);
    }

    @RequestMapping("/{portletId}/addText")
    public String addText(@PathVariable(value = "portletId") String portletId, Model model) {
        InformationText text = new InformationText();
        text.setPortletId(portletId);
        text.setType(InformationConstants.type.TEXT);
        model.addAttribute("information", text);
        return "/pages/information/edit.ftl";
    }

    @RequestMapping("/{uuid}/edit")
    public String edit(@PathVariable(value = "uuid") String uuid, Model model) {
        Information information = informationService.findInformationByUuid(uuid);
        model.addAttribute("information", information);
        return "/pages/information/edit.ftl";
    }

    private void save(Information information) {
        if (StringUtils.isNotEmpty(information.getUuid())) {
            informationService.updateInformation(information);
        } else {
            User userAccount = SecurityUtils.getUserInfoDetails();
            information.setAuthorId(userAccount.getUuid());
            informationService.saveInformation(information);
        }
    }

    @RequestMapping(value = "/save/text", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> saveText(@ModelAttribute InformationText information, Model model, RedirectAttributes attributes) {
        Map<String, Object> json = new HashMap<String, Object>();
        try {
            information.setStatus(InformationConstants.status.DRAFT);
            information.setType(InformationConstants.type.TEXT);
            this.save(information);
            json.put("status", true);
            json.put("message", "信息保存成功！");
        } catch (Exception e) {
            e.printStackTrace();
            json.put("status", false);
            json.put("message", "信息保存失败！");
        }
        return json;
    }

    @RequestMapping(value = "/promulgation/text", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> promulgationText(@ModelAttribute InformationText information, Model model, RedirectAttributes attributes) {
        Map<String, Object> json = new HashMap<String, Object>();
        try {
            information.setStatus(InformationConstants.status.PROMULGATION);
            this.save(information);
            json.put("status", true);
            json.put("message", "信息发布成功！");
        } catch (Exception e) {
            e.printStackTrace();
            json.put("status", false);
            json.put("message", "信息发布失败！");
        }
        return json;
    }


    @RequestMapping(value = "/hide/text", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> hideText(@ModelAttribute InformationText information, Model model, RedirectAttributes attributes) {
        Map<String, Object> json = new HashMap<String, Object>();
        try {
            information.setStatus(InformationConstants.status.HIDE);
            this.save(information);
            json.put("status", true);
            json.put("message", "信息发布成功！");
        } catch (Exception e) {
            e.printStackTrace();
            json.put("status", false);
            json.put("message", "信息发布失败！");
        }
        return json;
    }

    /**
     * @param uuid
     * @param model
     * @return
     */
    @RequestMapping(value = "/delete")
    @ResponseBody
    public Map<String, Object> delete(@RequestParam(value = "uuid", required = false) String uuid, Model model) {
        Map<String, Object> json = new HashMap<String, Object>();
        try {
            informationService.deleteInformation(uuid);
            json.put("status", true);
            json.put("message", "信息删除成功！");
        } catch (Exception e) {
            e.printStackTrace();
            json.put("status", false);
            json.put("message", "信息删除失败！");
        }
        return json;
    }
}
