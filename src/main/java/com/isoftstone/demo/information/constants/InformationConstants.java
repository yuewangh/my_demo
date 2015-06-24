package com.isoftstone.demo.information.constants;

import org.apache.commons.lang3.StringUtils;

/**
 * Group: 姚丰利（lidey）
 * Date: 2015-04-21
 * Time: 11:15
 * To change this template use File | Settings | File Templates.
 */
public class InformationConstants {

    public enum status {
        DRAFT, AUDIT, PROMULGATION, HIDE, REJECT, COMPLETE;

        public String toCn() {
            switch (this) {
                case DRAFT:
                    return "草稿";
                case AUDIT:
                    return "待审批";
                case PROMULGATION:
                    return "发布";
                case HIDE:
                    return "隐藏";
                case REJECT:
                    return "未通过";
                case COMPLETE:
                    return "已完成";
                default:
                    return this.toString();
            }
        }
    }

    public enum type {
        TEXT, PICTURE, LINK;

        public String toCn() {
            switch (this) {
                case TEXT:
                    return "文本信息";
                case PICTURE:
                    return "图片信息";
                case LINK:
                    return "链接信息";
                default:
                    return this.toString();
            }
        }
    }

    /**
     * @param value
     * @return
     */
    public static status parseStatus(String value) {
        if (StringUtils.isNotEmpty(value))
            return status.valueOf(value);
        return null;
    }

    /**
     * @param value
     * @return
     */
    public static type parseType(String value) {
        if (StringUtils.isNotEmpty(value))
            return type.valueOf(value);
        return null;
    }

}
