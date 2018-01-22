package com.xxl.api.admin.core.model;

import java.io.Serializable;

/**
 * 文档模型
 * @ClassName: GtDocumentDes 
 * @author lijinyang 
 * @date 2018年1月22日 下午3:10:09
 */
public class GtDocumentDes implements Serializable{
    
    private static final long serialVersionUID = 2598856342749730886L;

    private Integer id;
    
    private String docTitle;
    
    private String docContent;
    
    private Integer projectId;
    
    private Boolean status;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getDocTitle() {
        return docTitle;
    }

    public void setDocTitle(String docTitle) {
        this.docTitle = docTitle;
    }

    public String getDocContent() {
        return docContent;
    }

    public void setDocContent(String docContent) {
        this.docContent = docContent;
    }

    public Integer getProjectId() {
        return projectId;
    }

    public void setProjectId(Integer projectId) {
        this.projectId = projectId;
    }

    public Boolean getStatus() {
        return status;
    }

    public void setStatus(Boolean status) {
        this.status = status;
    }
    
}
