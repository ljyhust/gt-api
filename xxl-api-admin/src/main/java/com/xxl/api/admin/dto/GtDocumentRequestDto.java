package com.xxl.api.admin.dto;

import java.io.Serializable;

public class GtDocumentRequestDto implements Serializable{

	private static final long serialVersionUID = 3064258717105874575L;

	private Integer projectId;
	
	private Integer docId;

	public Integer getProjectId() {
		return projectId;
	}

	public void setProjectId(Integer projectId) {
		this.projectId = projectId;
	}

	public Integer getDocId() {
		return docId;
	}

	public void setDocId(Integer docId) {
		this.docId = docId;
	}
	
}
