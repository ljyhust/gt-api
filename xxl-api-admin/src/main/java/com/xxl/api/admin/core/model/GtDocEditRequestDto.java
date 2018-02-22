package com.xxl.api.admin.core.model;

import java.io.Serializable;

public class GtDocEditRequestDto implements Serializable{

	private static final long serialVersionUID = -6720704041060363258L;

	private String docTitle;
	
	private String projectId;
	
	private String docMd;
	
	private String docId;

	public String getDocTitle() {
		return docTitle;
	}

	public void setDocTitle(String docTitle) {
		this.docTitle = docTitle;
	}

	public String getProjectId() {
		return projectId;
	}

	public void setProjectId(String projectId) {
		this.projectId = projectId;
	}

	public String getDocMd() {
		return docMd;
	}

	public void setDocMd(String docMd) {
		this.docMd = docMd;
	}

	public String getDocId() {
		return docId;
	}

	public void setDocId(String docId) {
		this.docId = docId;
	}
	
}
