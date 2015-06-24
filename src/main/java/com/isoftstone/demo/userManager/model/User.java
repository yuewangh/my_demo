package com.isoftstone.demo.userManager.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Where;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import com.isoftstone.demo.role.model.Role;
import com.isoftstone.demo.userManager.constants.UserConstants;

/**
 * Created by lidey on 14-6-24.
 */
@Entity
@Table(name = "USER_BASE")
//@Where(clause = "DELETE_DATE IS NULL")
@Inheritance(strategy = InheritanceType.JOINED)
@org.hibernate.annotations.Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class User implements Serializable, UserDetails {

    @Id
    @Column(name = "UUID", length = 64)
    @GeneratedValue(generator = "system-uuid")
    @GenericGenerator(name = "system-uuid", strategy = "uuid")
    private String uuid;

    @Column(name = "LOGINNAME", nullable = false, length = 32)
    private String loginName;

    @Column(name = "NAME", nullable = false, length = 32)
    private String name;

    @Column(name = "USER_PASSWORD", nullable = false, length = 64)
    private String password;

    @Column(name = "IDENTITY_FLAG", nullable = false, length = 64)
    @Enumerated(EnumType.STRING)
    private UserConstants.identity identity;

    @Column(name = "SURVIVAL_FLAG", nullable = false, length = 64)
    @Enumerated(EnumType.STRING)
    private UserConstants.survival survival;

    @Column(name = "E_MAIL", length = 255)
    private String mail;

    @Column(name = "REGISTER_DATE")
    @Temporal(TemporalType.TIMESTAMP)
    private Date registerDate;

    @Column(name = "DELETE_DATE")
    @Temporal(TemporalType.TIMESTAMP)
    private Date deleteDate;
    

    @Column(name = "HEAD_URL", length = 255)
    private String headUrl;

    @ManyToMany(targetEntity = Role.class)
    @JoinTable(name = "USER_ROLE",
            joinColumns = @JoinColumn(name = "USER_UUID", referencedColumnName = "UUID"),
            inverseJoinColumns = @JoinColumn(name = "ROLE_UUID", referencedColumnName = "UUID"))
    private Set<Role> roles = new HashSet<Role>();

    @Transient
    private List<GrantedAuthority> grantedAuthorityList;


    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }

    public String getLoginName() {
        return loginName;
    }

    public void setLoginName(String loginName) {
        this.loginName = loginName;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public UserConstants.identity getIdentity() {
        return identity;
    }

    public void setIdentity(UserConstants.identity identity) {
        this.identity = identity;
    }

    public UserConstants.survival getSurvival() {
        return survival;
    }

    public void setSurvival(UserConstants.survival survival) {
        this.survival = survival;
    }

    public String getMail() {
        return mail;
    }

    public void setMail(String mail) {
        this.mail = mail;
    }

    public Date getRegisterDate() {
        return registerDate;
    }

    public void setRegisterDate(Date registerDate) {
        this.registerDate = registerDate;
    }

    public Date getDeleteDate() {
        return deleteDate;
    }

    public void setDeleteDate(Date deleteDate) {
        this.deleteDate = deleteDate;
    }

    public Set<Role> getRoles() {
        return roles;
    }

    public void addRole(Role role) {
        roles.add(role);
    }

    public void setRoles(Set<Role> roles) {
        this.roles = roles;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
        if (roles != null) {
            List<Role> list = new ArrayList<Role>();
            for (Iterator iterator = roles.iterator(); iterator.hasNext(); ) {
                Role role = (Role) iterator
                        .next();
                list.add(role);
            }
            authorities.addAll(list);
        }
        if (grantedAuthorityList != null)
            authorities.addAll(grantedAuthorityList);
        return authorities;
    }

    @Override
    public String getPassword() {
        return password;
    }

    @Override
    public String getUsername() {
        return loginName;
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        if (survival == UserConstants.survival.DISABLE)
            return false;
        else
            return true;
    }

    public List<GrantedAuthority> getGrantedAuthorityList() {
        return grantedAuthorityList;
    }

    public void setGrantedAuthorityList(List<GrantedAuthority> grantedAuthorityList) {
        this.grantedAuthorityList = grantedAuthorityList;
    }

    /**
     * @param grantedAuthority
     */
    public void addGrantedAuthority(GrantedAuthority grantedAuthority) {
        if (grantedAuthorityList == null) {
            grantedAuthorityList = new ArrayList<GrantedAuthority>();
        }
        grantedAuthorityList.add(grantedAuthority);
    }

	public String getHeadUrl() {
		return headUrl;
	}

	public void setHeadUrl(String headUrl) {
		this.headUrl = headUrl;
	}
}
