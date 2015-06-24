/**
 * 
 */
package com.isoftstone.demo.role.model;


import java.io.Serializable;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Where;
import org.springframework.security.core.GrantedAuthority;

import com.isoftstone.demo.userManager.model.User;
/**
* 项目名称：demo   
* 类名称：Role   
* 类描述：   角色
* 创建人：xlzhangf   
* 创建时间：2015年4月20日 下午4:44:20   
* 修改人：xlzhangf   
* 修改时间：2015年4月20日 下午4:44:20   
* 修改备注：   
* @version    
 */
@Entity
@Table(name="ROLE_INFO") @Where(clause="DELETE_DATE IS NULL")
public class Role implements Serializable,GrantedAuthority {

	private static final long serialVersionUID = 1L;
	@Id @Column(name="UUID")
    @GeneratedValue(generator = "system-uuid")
    @GenericGenerator(name = "system-uuid", strategy = "uuid")
	private String uuid;
	@Column(name="ROLE_KEY")
	private String key;
	@Column(name="NAME")
	private String name;
	@Column(name="SURVIVAL_STATUS")
	private boolean survivalStatus=true;
	@Column(name="ONLY_STATUS")
	private boolean onlyStatus=false;
	@Column(name="hideStatus")
	private boolean hideStatus=false;
	@Column(name="DESCRIPTION")
	private String description;
	@Column(name="CREATE_DATE")
	private Date createDate;
	@Column(name="MODIFY_DATE")
	private Date modifyDate;
	@Column(name="DELETE_DATE")
	private Date deleteDate;
	@OneToMany(mappedBy="roles",targetEntity=User.class)
	private Set<User> users=new HashSet<User>();
	@ManyToMany(targetEntity=Resource.class)
	@JoinTable(name="ROLE_RESOURCE",joinColumns=@JoinColumn(name="ROLE_UUID",referencedColumnName="UUID"),inverseJoinColumns=@JoinColumn(name="RESOURCE_UUID",referencedColumnName="UUID"))
    private Set<Resource> privileges = new HashSet<Resource>();

    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }

    public String getKey() {
		return key;
	}
	public void setKey(String key) {
		this.key = key;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public Set<User> getUsers() {
		return users;
	}
	public void setUsers(Set<User> users) {
		this.users = users;
	}


    public boolean isSurvivalStatus() {
        return survivalStatus;
    }

    public void setSurvivalStatus(boolean survivalStatus) {
        this.survivalStatus = survivalStatus;
    }

    public boolean isOnlyStatus() {
        return onlyStatus;
    }

    public void setOnlyStatus(boolean onlyStatus) {
        this.onlyStatus = onlyStatus;
    }

    public boolean isHideStatus() {
        return hideStatus;
    }

    public void setHideStatus(boolean hideStatus) {
        this.hideStatus = hideStatus;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public Date getModifyDate() {
        return modifyDate;
    }

    public void setModifyDate(Date modifyDate) {
        this.modifyDate = modifyDate;
    }

    public Date getDeleteDate() {
        return deleteDate;
    }

    public void setDeleteDate(Date deleteDate) {
        this.deleteDate = deleteDate;
    }
	public Set<Resource> getPrivileges() {
		return privileges;
	}
	public void setPrivileges(Set<Resource> privileges) {
		this.privileges = privileges;
	}

    public void addPrivilege(Resource privilege) {
        this.privileges.add(privilege);
    }
    
    public void addUsers(User user){
    	this.users.add(user);
    }

	@Override
	public String getAuthority() {
		// TODO Auto-generated method stub
		return this.key;
	}
    
}
