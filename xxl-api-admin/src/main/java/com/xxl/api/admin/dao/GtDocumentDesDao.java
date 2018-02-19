package com.xxl.api.admin.dao;

import java.util.List;

import com.xxl.api.admin.core.model.GtDocumentDes;

/**
 * 文档Dao
 * @ClassName: GtDocumentDesDao 
 * @author lijinyang 
 * @date 2018年1月22日 下午4:20:06
 */
public interface GtDocumentDesDao {
    
    public int insert(GtDocumentDes doc);
    
    public void updateById(GtDocumentDes doc);
    
    public List<GtDocumentDes> getContensByProject(Integer projectId);
    
    public GtDocumentDes selectById(Integer id);
    
    public void deleteById(Integer id);
}
