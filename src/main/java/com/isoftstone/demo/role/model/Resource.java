package com.isoftstone.demo.role.model;

import java.io.Serializable;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;
import org.springframework.security.core.GrantedAuthority;
@Entity
@Table(name="RESOURCE_INFO")
public class Resource implements Serializable,GrantedAuthority {

    private static final long serialVersionUID = 3578695879005642917L;
    @Id
    @GeneratedValue(generator = "system-uuid")
    @GenericGenerator(name = "system-uuid", strategy = "uuid")
    @Column(name="UUID")
    private String uuid;
    @Column(name="RESOURCE_NAME")
    private String name;
    @Column(name="RESOURCE_KEY")
    private String key;
    @Column(name="PARENT_ID",insertable=false,updatable=false)
    private String parentId;
    @Column(name="RESOURCE_ORDER_NO")
    private int orderNo = 0;
    /*@ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="PARENT_ID",insertable=false,updatable=false)
    private Resource parent;*/
    @OneToMany(mappedBy="parentId",targetEntity=Resource.class,fetch=FetchType.LAZY)
    private Set<Resource> children;

    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }

    public String getName() {
        return this.name;
    }

    public void setName(String name) {
        this.name = name;
    }

/*
    public Resource getParent() {
        return parent;
    }

    public void setParent(Resource parent) {
        this.parent = parent;
    }
*/
    public int getOrderNo() {
        return orderNo;
    }

    public void setOrderNo(int orderNo) {
        this.orderNo = orderNo;
    }

    public Set<Resource> getChildren() {
        return children;
    }

    public void setChildren(Set<Resource> children) {
        this.children = children;
    }

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    public String getParentId() {
        return parentId;
    }

    public void setParentId(String parentId) {
        this.parentId = parentId;
    }

	@Override
	public String getAuthority() {
		// TODO Auto-generated method stub
		return this.key;
	}
}
