package com.xxl.api.admin.dto;

import java.util.List;

/**
 * 文档目录
 * Created by lijinyang on 2018/2/1.
 */
public class ApiDocIndexNodeDto extends CommonPublicDto{

	private static final long serialVersionUID = 1L;
	
	// 节点名称, 即doc_title
	private String text;
	
	private Integer docId;
	
	private Integer projectId;
	
	private String projectName;
	
	// 子节点信息
    private List<ApiDocIndexNodeDto> nodes;

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public Integer getDocId() {
		return docId;
	}

	public void setDocId(Integer docId) {
		this.docId = docId;
	}

	public Integer getProjectId() {
		return projectId;
	}

	public void setProjectId(Integer projectId) {
		this.projectId = projectId;
	}
	
	public String getProjectName() {
		return projectName;
	}

	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}

	public List<ApiDocIndexNodeDto> getNodes() {
		return nodes;
	}

	public void setNodes(List<ApiDocIndexNodeDto> nodes) {
		this.nodes = nodes;
	}

}
