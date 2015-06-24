package com.isoftstone.demo.operation_log.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import org.hibernate.annotations.GenericGenerator;




@Entity
@Table(name="PORTAL_SYS_LOG")
public class Operation_log implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 9154287614360655382L;
	@Id
	@GeneratedValue(generator = "system-uuid")
	@GenericGenerator(name = "system-uuid", strategy = "uuid")
	@Column(name = "UUID", length = 32)
	private String uuid;
	//模块名称
	@Column(name = "MODNAME",length=20)
	private String modname;
	
	//用户UUID
	@Column(name = "USERUUID")
	private String useruuid; //User usr = SecurityUtils.getUserInfoDetails();
	//用户名
	@Column(name = "LOGINNAME")
	private String loginname;
	//名字
	@Column(name = "FULLNAME")
	private String fullname;
	//用户IP
	@Column(name = "USERIP")
	private String userip;//request.getRemoteAddr()
	//操作日期
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "OPERDATE")
	private Date operdate;
	@Transient
	private String operdatestr;
	
	@Column(name = "BID",length=3000)
	private String bId;//操作业务ID
	//成功失败
	@Column(name = "SUCCESSED",columnDefinition="VARCHAR(10) DEFAULT 'SUCCESSED'")
	@Enumerated(EnumType.STRING)
	private Successed successed;//成功/失败 标志 SUCCESSED表示成功，FAILED表示失败
	
	//操作描述
	@Column(name = "CONTENT",length=200)
	private String content;
	
	//失败原因
	@Column(name = "OPERDESC",length=3000)
	private String cause;
	
	public Operation_log() {
		super();
	}
	public enum Successed {
		SUCCESSED, FAILED, ;
	}
	public Operation_log(Log log,String useruuid, String loginname,
			String fullname, String userip,String bId,
			Successed successed, String cause, String content) {
		super();
		this.content=log.content();
		if(content != null && !content.equals("")){
			this.content=content;
		}
		this.modname=log.type().toString();
		this.useruuid = useruuid;
		this.loginname = loginname;
		this.fullname = fullname;
		this.userip = userip;
		this.bId = bId;
		this.operdate = new Date();
		this.successed = successed;
		this.cause = cause;
	}

	public String getUuid() { 
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}
	public String getModname() { 
		return modname;
	}

	public void setModname(String modname) {
		this.modname= modname;
	}
	public String getUseruuid() { 
		return useruuid;
	}

	public void setUseruuid(String useruuid) {
		this.useruuid= useruuid;
	}
	public String getLoginname() { 
		return loginname;
	}

	public void setLoginname(String loginname) {
		this.loginname= loginname;
	}
	public String getFullname() { 
		return fullname;
	}

	public void setFullname(String fullname) {
		this.fullname= fullname;
	}
	public String getUserip() { 
		return userip;
	}

	public void setUserip(String userip) {
		this.userip= userip;
	}
	public Date getOperdate() { 
		return operdate;
	}

	public void setOperdate(Date operdate) {
		this.operdate= operdate;
	}
	public Successed getSuccessed() {
		return successed;
	}
	public void setSuccessed(Successed successed) {
		this.successed = successed;
	}

	public String getbId() {
		return bId;
	}

	public void setbId(String bId) {
		this.bId = bId;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getCause() {
		return cause;
	}

	public void setCause(String cause) {
		this.cause = cause;
	}

	public String getOperdatestr() {
		return operdatestr;
	}

	public void setOperdatestr(String operdatestr) {
		this.operdatestr = operdatestr;
	}
	
}