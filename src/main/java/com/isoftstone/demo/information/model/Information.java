/**
 *
 */
package com.isoftstone.demo.information.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import com.isoftstone.demo.common.util.DateConvertUtils;

import org.apache.commons.lang3.StringUtils;
import org.hibernate.annotations.*;

import com.isoftstone.demo.information.constants.InformationConstants;

/**
 * @author 姚丰利(lidey)
 *         创建时间：2012-8-6 下午03:42:20
 */
@Entity
@Table(name = "INFORMATION_INFO")
@DynamicInsert
@DynamicUpdate
@Where(clause = "DELETE_DATE IS NULL")
@Inheritance(strategy = InheritanceType.JOINED)
@org.hibernate.annotations.Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public abstract class Information implements Serializable {
	@Transient
	private final String sampleDateFmt = "yyyy-MM-dd HH:mm";
	
	
    @Id
    @Column(name = "UUID", length = 64)
    @GeneratedValue(generator = "system-uuid")
    @GenericGenerator(name = "system-uuid", strategy = "uuid")
    private String uuid;

    @Column(name = "TITLE", nullable = false, length = 32)
    private String title;

    @Column(name = "PICTURE_URL", nullable = true, length = 255)
    private String pictureUrl;

    @Column(name = "SOURCE", nullable = true, length = 255)
    private String informationSource;//信息来源

    @Column(name = "SUMMARY", nullable = true, length = 255)
    private String summary;

    @Column(name = "PORTLET_ID", nullable = false, length = 32, updatable = false)
    private String portletId;

    @Column(name = "TYPE_FLAG", nullable = false, length = 32, updatable = false)
    @Enumerated(EnumType.STRING)
    private InformationConstants.type type = InformationConstants.type.TEXT;

    @Column(name = "STATUS_FLAG", nullable = false, length = 32)
    @Enumerated(EnumType.STRING)
    private InformationConstants.status status = InformationConstants.status.DRAFT;

    @Column(name = "AUTHOR_ID", nullable = false, length = 64, updatable = false)
    private String authorId;

    @Column(name = "AUTHOR_NAME", nullable = false, length = 32, updatable = false)
    private String authorName;

    @Column(name = "SORT_NUM", nullable = true)
    private Integer sortNum;//排序字段

    @Column(name = "VIEW_NUM", nullable = true)
    private int viewNum;

    @Column(name = "CREATE_DATE", nullable = false, updatable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date createDate;

    @Column(name = "MODIFY_DATE")
    @Temporal(TemporalType.TIMESTAMP)
    private Date modifyDate;

    @Column(name = "DELETE_DATE")
    @Temporal(TemporalType.TIMESTAMP)
    private Date deleteDate;

    @Column(name = "PROMULGATION_DATE")
    @Temporal(TemporalType.TIMESTAMP)
    private Date promulgationDate;
    
    //*******************以下为平台活动扩展字段******//
    //活动举办日期
    @Column(name = "ACTIVITY_DATE")
    @Temporal(TemporalType.TIMESTAMP)
    private Date activityDate;
    @Transient
	private String activityDateStr;
    //活动举办地址
    @Column(name = "ACTIVITY_ADDRESS", nullable = true, length = 255)
    private String activityAddress;
    

    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getPictureUrl() {
        if (StringUtils.isEmpty(pictureUrl))
            return null;
        else
            return pictureUrl;

    }

    public void setPictureUrl(String pictureUrl) {
        this.pictureUrl = pictureUrl;
    }

    public String getInformationSource() {
        return informationSource;
    }

    public void setInformationSource(String informationSource) {
        this.informationSource = informationSource;
    }

    public String getSummary() {
        return summary;
    }

    public void setSummary(String summary) {
        this.summary = summary;
    }

    public String getPortletId() {
        return portletId;
    }

    public void setPortletId(String portletId) {
        this.portletId = portletId;
    }

    public InformationConstants.type getType() {
        return type;
    }

    public String getTypeStr() {
        return type.toCn();
    }

    public void setType(InformationConstants.type type) {
        this.type = type;
    }

    public InformationConstants.status getStatus() {
        return status;
    }

    public String getStatusStr() {
        return status.toCn();
    }

    public void setStatus(InformationConstants.status status) {
        this.status = status;
    }

    public String getAuthorId() {
        return authorId;
    }

    public void setAuthorId(String authorId) {
        this.authorId = authorId;
    }

    public String getAuthorName() {
        return authorName;
    }

    public void setAuthorName(String authorName) {
        this.authorName = authorName;
    }

    public Integer getSortNum() {
        return sortNum;
    }

    public void setSortNum(Integer sortNum) {
        this.sortNum = sortNum;
    }

    public int getViewNum() {
        return viewNum;
    }

    public void setViewNum(int viewNum) {
        this.viewNum = viewNum;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public String getCreateDateStr() {
        return DateConvertUtils.format(createDate, "yyyy-MM-dd");
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public Date getModifyDate() {
        return modifyDate;
    }

    public String getModifyDateStr() {
        return DateConvertUtils.format(modifyDate, "yyyy-MM-dd");
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

    public Date getPromulgationDate() {
        return promulgationDate;
    }

    public String getPromulgationDateStr() {
        if (modifyDate == null)
            return "信息未发布";
        return DateConvertUtils.format(modifyDate, "yyyy-MM-dd");
    }

    public void setPromulgationDate(Date promulgationDate) {
        this.promulgationDate = promulgationDate;
    }

	public Date getActivityDate() {
		return activityDate;
	}

	public void setActivityDate(Date activityDate) {
		this.activityDate = activityDate;
	}

	public String getActivityAddress() {
		return activityAddress;
	}

	public void setActivityAddress(String activityAddress) {
		this.activityAddress = activityAddress;
	}

	public String getActivityDateStr() {
		return DateConvertUtils.format(activityDate, sampleDateFmt);
	}

	public void setActivityDateStr(String activityDateStr) {
		this.activityDateStr = activityDateStr;
		this.activityDate = DateConvertUtils.parse(activityDateStr, sampleDateFmt);
	}
}
