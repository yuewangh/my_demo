package com.isoftstone.demo.systemparameter.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Type;

/**
 * PortalSystemParameter entity.
 * 
 * @author fenghuc
 */
@Entity
@Table(name="PORTAL_PARAMETER_INFO")
public class SystemParameter implements java.io.Serializable {
	private static final long serialVersionUID = 6786066984842221947L;
	@Id
    @GeneratedValue(generator = "system-uuid")
    @GenericGenerator(name = "system-uuid", strategy = "uuid")
	@Column(name="UUID",length = 64)
	private String uuid;//主键
	@Column(name="PARAM_KEY")
	private String paramKey;//参数编码
	@Column(name="PARAM_NAME")
    private String paramName;//参数名称
	@Column(name="PARAM_VAL")
	@Type(type="text") 
    private String paramVal;//参数值
	@Column(name="PARAM_TYPE")
	private String paramType;//参数类型
	@Column(name="PARAM_SUMMARY")
	@Type(type="text") 
    private String summary;//参数描述
	@Column(name="DU_ID")
	private String duId;//数据字典外键

	// Constructors

	/** default.ftl constructor */
	public SystemParameter() {
	}

	/** full constructor */
	public SystemParameter(String uuid, String paramKey, String paramName, String paramVal,
			String paramType) {
		this.uuid = uuid;
		this.paramKey = paramKey;
        this.paramName = paramName;
		this.paramVal = paramVal;
		this.paramType = paramType;
	}

	// Property accessors


    public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public String getParamKey() {
		return this.paramKey;
	}

	public void setParamKey(String paramKey) {
		this.paramKey = paramKey;
	}

	public String getParamVal() {
		return this.paramVal;
	}

	public void setParamVal(String paramVal) {
		this.paramVal = paramVal;
	}

	public String getParamType() {
		return this.paramType;
	}

	public void setParamType(String paramType) {
		this.paramType = paramType;
	}

    public String getParamName() {
        return paramName;
    }

    public void setParamName(String paramName) {
        this.paramName = paramName;
    }

	public String getDuId() {
		return duId;
	}

	public void setDuId(String duId) {
		this.duId = duId;
	}

    public String getSummary() {
        return summary;
    }

    public void setSummary(String summary) {
        this.summary = summary;
    }
}