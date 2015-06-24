package com.isoftstone.demo.userManager.constants;

import org.apache.commons.lang3.StringUtils;

/**
 * Created by lidey on 14-6-24.
 */
public enum GenderFormat {
    MALE, FEMALE;

    public static GenderFormat parse(String value) {
        if (StringUtils.isNotEmpty(value))
            return GenderFormat.valueOf(value);
        return null;
    }
}
