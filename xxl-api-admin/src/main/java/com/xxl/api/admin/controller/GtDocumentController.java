package com.xxl.api.admin.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.xxl.api.admin.core.model.XxlApiProject;
import com.xxl.api.admin.dao.IXxlApiProjectDao;

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
    
    @RequestMapping
    public String index(Model model, @RequestParam(required = false, defaultValue = "0") int productId) {

        // 项目id
        model.addAttribute("productId", productId);
        // 项目
 		XxlApiProject xxlApiProject = xxlApiProjectDao.load(productId);
 		if (xxlApiProject == null) {
 			throw new RuntimeException("系统异常，项目ID非法");
 		}
 		model.addAttribute("productId", productId);
 		model.addAttribute("project", xxlApiProject);
 		//目录
 		
 		model.addAttribute("docCatalogList", null);

        return "document/document.list";
    }
}
