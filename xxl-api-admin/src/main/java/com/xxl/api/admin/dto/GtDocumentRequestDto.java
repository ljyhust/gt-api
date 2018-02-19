package com.xxl.api.admin.dto;

import java.io.Serializable;

public class GtDocumentRequestDto implements Serializable{

	private static final long serialVersionUID = 3064258717105874575L;

	private String productId;
	
	private String docId;

	public String getProductId() {
		return productId;
	}

	public void setProductId(String productId) {
		this.productId = productId;
	}

	public String getDocId() {
		return docId;
	}

	public void setDocId(String docId) {
		this.docId = docId;
	}
	
}
