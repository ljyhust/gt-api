package com.xxl.api.admin.dao.impl;

import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.xxl.api.admin.core.model.GtDocumentDes;
import com.xxl.api.admin.dao.GtDocumentDesDao;

@Repository
public class GtDocumentDesImpl implements GtDocumentDesDao{

    @Resource
    public SqlSessionTemplate sqlSessionTemplate;
    
    @Override
    public Integer insert(GtDocumentDes doc) {
        return sqlSessionTemplate.insert("GtDocumentDesMapper.add", doc);
        
    }

    @Override
    public void updateById(GtDocumentDes doc) {
        sqlSessionTemplate.update("GtDocumentDesMapper.update", doc);
        
    }

    @Override
    public List<GtDocumentDes> getContensByProject(Integer projectId) {
        return sqlSessionTemplate.selectList("GtDocumentDesMapper.getContensByProject", projectId);
    }

    @Override
    public GtDocumentDes selectById(Integer id) {
        return sqlSessionTemplate.selectOne("GtDocumentDesMapper.selectById", id);
    }

    @Override
    public void deleteById(Integer id) {
        sqlSessionTemplate.delete("GtDocumentDesMapper.deleteById", id);
        
    }

}
