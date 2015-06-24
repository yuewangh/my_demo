package com.isoftstone.demo.common.web.servlet.view.freemarker;

import org.springframework.web.servlet.view.freemarker.FreeMarkerView;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

/**
 * Group: 姚丰利（lidey）
 * Date: 2014-08-21
 * Time: 13:00
 * To change this template use File | Settings | File Templates.
 */
public class FreeMakerView extends FreeMarkerView {
    private static final String CONTEXT_PATH = "base";
    private static final String CONTEXT_PATH_ALL = "basePath";
    private static final String CONTEXT_PATH_ADDRESS = "baseAddress";

    @Override
    protected void exposeHelpers(Map model, HttpServletRequest request) throws Exception {
        model.put(CONTEXT_PATH, request.getContextPath());
        model.put(CONTEXT_PATH_ALL, request.getScheme() + "://"
                + request.getServerName() + ":" + request.getServerPort()
                + request.getContextPath());
        model.put(CONTEXT_PATH_ADDRESS, request.getScheme() + "://"
                + request.getServerName() + ":" + request.getServerPort());
        super.exposeHelpers(model, request);
    }
}
