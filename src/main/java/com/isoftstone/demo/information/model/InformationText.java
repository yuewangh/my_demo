package com.isoftstone.demo.information.model;

import java.io.Serializable;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Lob;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;

import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

/**
 * 门户新闻内容表
 *
 * @author
 */
@Entity
@Table(name = "INFORMATION_TEXT")
@DynamicInsert
@DynamicUpdate
@PrimaryKeyJoinColumn(name = "INFORMATION_UUID")
@org.hibernate.annotations.Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class InformationText extends Information implements Serializable {

    @Lob
    @Basic(fetch = FetchType.LAZY)
    @Column(name = "CONTENT")
    private String content;

    /**
     * @return the content
     */
    public String getContent() {
        return content;
    }

    /**
     * @param content the content to set
     */
    public void setContent(String content) {
        this.content = content;
    }
}
