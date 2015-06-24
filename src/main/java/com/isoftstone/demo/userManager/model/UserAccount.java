package com.isoftstone.demo.userManager.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;

import org.hibernate.annotations.CacheConcurrencyStrategy;

import com.isoftstone.demo.userManager.constants.GenderFormat;

/**
 * Created by lidey on 14-6-24.
 */
@Entity
@Table(name = "USER_ACCOUNT")
@PrimaryKeyJoinColumn(name = "USER_UUID")
@org.hibernate.annotations.Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class UserAccount extends User implements Serializable {

    @Column(name = "GENDER_FLAG", length = 32)
    @Enumerated(EnumType.STRING)
    private GenderFormat gender;

    @Column(name = "JOB", length = 32)
    private String job;

    @Column(name = "DEPT", length = 32)
    private String dept;

    @Column(name = "TEL", length = 32)
    private String tel;

    public GenderFormat getGender() {
        return gender;
    }

    public void setGender(GenderFormat gender) {
        this.gender = gender;
    }

    public String getJob() {
        return job;
    }

    public void setJob(String job) {
        this.job = job;
    }

    public String getDept() {
        return dept;
    }

    public void setDept(String dept) {
        this.dept = dept;
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }
}
