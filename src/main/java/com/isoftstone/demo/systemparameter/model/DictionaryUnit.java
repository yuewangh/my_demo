package com.isoftstone.demo.systemparameter.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Type;


/**
 * 数据字典集单元
 * <p/>
 * 字典单元收录的数据类型
 *
 * @author huilit(Li Hui)
 */
@Entity
@Table(name="PORTAL_PARAMETER_GROUP")
public class DictionaryUnit implements Serializable {
    private static final long serialVersionUID = 1217822120508086864L;
    @Id
    @GeneratedValue(generator = "system-uuid")
    @GenericGenerator(name = "system-uuid", strategy = "uuid")
    @Column(name="UUID",length = 64)
    private String uuid;
    @Column(name="PARAM_KEY")
    private String paramKey;
    @Column(name="PARAM_NAME")
    private String paramName;
    @Column(name="OPTION_CODE")
    private int optionCode;
    @Column(name="PARAM_TYPE")
    private String paramType;
    @Column(name="PARAM_SUMMARY")
    @Type(type="text") 
    private String summary;

    public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public String getParamKey() {
        return paramKey;
    }

    public void setParamKey(String paramKey) {
        this.paramKey = paramKey;
    }

    public String getParamName() {
        return paramName;
    }

    public void setParamName(String paramName) {
        this.paramName = paramName;
    }

    public int getOptionCode() {
        return optionCode;
    }

    public void setOptionCode(int optionCode) {
        this.optionCode = optionCode;
    }

    public String getParamType() {
        return paramType;
    }

    public void setParamType(String paramType) {
        this.paramType = paramType;
    }

    public String getSummary() {
        return summary;
    }

    public void setSummary(String summary) {
        this.summary = summary;
    }
}

