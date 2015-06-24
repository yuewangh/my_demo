package com.isoftstone.demo.userManager.constants;

import org.apache.commons.lang3.StringUtils;

/**
 * Created by lidey on 14-6-24.
 */
public enum SurvivalFormat {

    ENABLE, DISABLE, VERIFY;

    public static SurvivalFormat parse(String value) {
        if (StringUtils.isNotEmpty(value))
            return SurvivalFormat.valueOf(value);
        return null;
    }
}
