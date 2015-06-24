package com.isoftstone.demo.userManager.constants;

import org.apache.commons.lang3.StringUtils;

/**
 * Group: 姚丰利（lidey）
 * Date: 2015-04-21
 * Time: 11:15
 * To change this template use File | Settings | File Templates.
 */
public class UserConstants {

    public enum identity {
        ACCOUNT, COMPANY, PERSONA
    }

    public enum survival {
        ENABLE, DISABLE, VERIFY
    }

    public enum gender {
        MALE, FEMALE
    }

    /**
     * @param value
     * @return
     */
    public static identity parseIdentity(String value) {
        if (StringUtils.isNotEmpty(value))
            return identity.valueOf(value);
        return null;
    }

    /**
     * @param value
     * @return
     */
    public static survival parseSurvival(String value) {
        if (StringUtils.isNotEmpty(value))
            return survival.valueOf(value);
        return null;
    }

    /**
     * @param value
     * @return
     */
    public static gender parseGender(String value) {
        if (StringUtils.isNotEmpty(value))
            return gender.valueOf(value);
        return null;
    }
}
