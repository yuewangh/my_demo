package com.isoftstone.demo.userManager.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import com.isoftstone.demo.common.util.DateConvertUtils;
import com.isoftstone.demo.userManager.constants.GenderFormat;

/**
 * Created by lidey on 14-6-24.
 */
@Entity
@Table(name = "USER_PERSONA")
@PrimaryKeyJoinColumn(name = "USER_UUID")
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class UserPersona extends User implements Serializable {
	@Transient
	private final String sampleDateFmt = "yyyy-MM-dd";
    @Column(name = "GENDER_FLAG", length = 32)
    @Enumerated(EnumType.STRING)
    private GenderFormat gender;

    @Column(name = "BIRTHDAY")
    private Date birthday;
    @Transient
    private String birthdayStr;

    @Column(name = "JOB_INFO", length = 32)
    private String jobInfo;

    @Column(name = "UNIT_INFO", length = 32)
    private String unit;

    @Column(name = "TEL", length = 32)
    private String tel;

    @Column(name = "ADDRESS")
    private String address;

    public GenderFormat getGender() {
        return gender;
    }

    public void setGender(GenderFormat gender) {
        this.gender = gender;
    }

    public Date getBirthday() {
        return birthday;
    }

    public void setBirthday(Date birthday) {
        this.birthday = birthday;
    }


    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

	public String getBirthdayStr() {
		return DateConvertUtils.format(birthday, sampleDateFmt);
	}

	public void setBirthdayStr(String birthdayStr) {
		this.birthdayStr = birthdayStr;
		this.birthday = DateConvertUtils.parse(birthdayStr, sampleDateFmt);
	}

	public String getJobInfo() {
		return jobInfo;
	}

	public void setJobInfo(String jobInfo) {
		this.jobInfo = jobInfo;
	}
}
