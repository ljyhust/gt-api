package com.xxl.api.admin.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xxl.api.admin.controller.annotation.PermessionLimit;
import com.xxl.api.admin.core.model.GtDocEditRequestDto;
import com.xxl.api.admin.core.model.GtDocumentDes;
import com.xxl.api.admin.core.model.XxlApiProject;
import com.xxl.api.admin.dao.GtDocumentDesDao;
import com.xxl.api.admin.dao.IXxlApiProjectDao;
import com.xxl.api.admin.dto.ApiDocIndexNodeDto;
import com.xxl.api.admin.dto.GtDocumentRequestDto;

/**
 * 文档管理
 * @ClassName: GtDocumentController 
 * @author lijinyang 
 * @date 2018年1月19日 上午10:30:30
 */
@Controller
@RequestMapping("/gt-document")
public class GtDocumentController {
	
	@Resource
	private IXxlApiProjectDao xxlApiProjectDao;
	
	@Resource
	private GtDocumentDesDao gtDocumentDao;
    
    @RequestMapping
    @PermessionLimit(limit=false)
    public String index(Model model, @RequestParam(required = false) Integer productId) {

        // 项目id
    	if (null != productId) {
    		model.addAttribute("productId", productId);
    		// 项目
    		XxlApiProject xxlApiProject = xxlApiProjectDao.load(productId);
    		if (xxlApiProject == null) {
    			throw new RuntimeException("系统异常，项目ID非法");
    		}
    		model.addAttribute("project", xxlApiProject);
    	}
 		//目录
 		List<GtDocumentDes> contentList = gtDocumentDao.getContensByProject(productId);
 		model.addAttribute("docCatalogList", contentList);

        return "document/document.list";
    }
    
    /**
     * 获取文档目录
     * @param docReqDto
     * @return
     */
    @RequestMapping("getDocIndex")
    @ResponseBody
    @PermessionLimit(limit=false)
    public List<ApiDocIndexNodeDto> getApiDocIndexTree(GtDocumentRequestDto docReqDto) {
    	boolean isTopIndex = !StringUtils.isBlank((docReqDto.getProductId()));
    	List<GtDocumentDes> contentsList = gtDocumentDao.getContensByProject(
    			isTopIndex ? Integer.valueOf(docReqDto.getProductId()) : null);
    	List<ApiDocIndexNodeDto> resList = new ArrayList<>();
    	if (isTopIndex) {
    		for (GtDocumentDes elem : contentsList) {
    			ApiDocIndexNodeDto apiDoc = new ApiDocIndexNodeDto();
    			apiDoc.setText(elem.getDocTitle());
    			apiDoc.setDocId(elem.getId());
    			apiDoc.setProjectId(new Integer(docReqDto.getProductId()));
    			resList.add(apiDoc);
    		}
    	} else {
    		Map<Integer, List<ApiDocIndexNodeDto>> map = new HashMap<>();
    		for (GtDocumentDes elem : contentsList) {
    			if (!map.containsKey(elem.getProjectId())) {
    				map.put(elem.getProjectId(), new ArrayList<ApiDocIndexNodeDto>());
    			}
    			List<ApiDocIndexNodeDto> nodeDtoList = map.get(elem.getProjectId());
    			ApiDocIndexNodeDto apiDoc = new ApiDocIndexNodeDto();
    			apiDoc.setText(elem.getDocTitle());
    			apiDoc.setDocId(elem.getId());
    			apiDoc.setProjectId(elem.getProjectId());
    			apiDoc.setProjectName(elem.getProjectName());
    			nodeDtoList.add(apiDoc);
    		}
    		ApiDocIndexNodeDto apiDoc = new ApiDocIndexNodeDto();
    		Set<Entry<Integer, List<ApiDocIndexNodeDto>>> indexSet = map.entrySet();
    		for (Entry<Integer, List<ApiDocIndexNodeDto>> entry : indexSet) {
    			List<ApiDocIndexNodeDto> value = entry.getValue();
				apiDoc.setProjectId(entry.getKey());
				apiDoc.setText(value.get(0).getProjectName());
				apiDoc.setNodes(value);
				resList.add(apiDoc);
			}
    	}
    	
    	return resList;
    }
    
    
    
    @RequestMapping("addDoc")
    public String edtiDoc(
            Model model,
            @RequestParam(required = false)String docTitle,
            @RequestParam(required=false) Integer productId,
            @RequestParam(required=false) Integer docId) {
    	if (null != productId) {
    		model.addAttribute("productId", productId);
    	}
        /*GtDocumentDes doc = new GtDocumentDes();
        doc.setDocTitle(docTitle);
        doc.setProjectId(productId);
        model.addAttribute("docCatalogId", gtDocumentDao.insert(doc));
        
        List<GtDocumentDes> docList = gtDocumentDao.getContensByProject(productId);
        model.addAttribute("docCatalogList", docList);*/
        if (null != docId) {
        	model.addAttribute("docId", docId);
        }
        return "document/doc.edit";
    }
    
    /**
     * 保存文档
     * @param docTitle
     * @param projectId
     * @param docMd
     * @return
     */
    @RequestMapping("saveDocMd")
    @ResponseBody
    public Map<String, Object> saveDocMd(GtDocEditRequestDto requestDto) {
    	// projectId
    	GtDocumentDes doc = new GtDocumentDes();
    	
    	doc.setDocTitle(requestDto.getDocTitle());
    	doc.setDocContent(requestDto.getDocMd());
    	doc.setProjectId(new Integer(requestDto.getProjectId()));
    	
    	Map<String, Object> resMap = new HashMap<>();
    	if (StringUtils.isBlank(requestDto.getDocId())) {
    		gtDocumentDao.insert(doc);
    		// 返回doc_id
    		resMap.put("docId", doc.getId());
    	} else {
	    	doc.setId(Integer.valueOf(requestDto.getDocId()));
	    	gtDocumentDao.updateById(doc);
	    	resMap.put("docId", requestDto.getDocId());
    	}
        return resMap;
    }

    /**
     * 获取文档
     * @param projectId
     * @return
     */
    @RequestMapping("/getDocMd")
    @ResponseBody
    @PermessionLimit(limit=false)
    public Map<String, Object> getContents(@RequestParam int docId) {
    	GtDocumentDes gtDoc = gtDocumentDao.selectById(docId);
    	Map<String, Object> resMap = new HashMap<String, Object>();
    	resMap.put("gtDoc", gtDoc);
        return resMap;
    }
    
}
