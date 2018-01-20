package com.xxl.api.admin.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.xxl.api.admin.core.model.XxlApiBiz;

/**
 * 文档管理
 * @ClassName: GtDocumentController 
 * @author lijinyang 
 * @date 2018年1月19日 上午10:30:30
 */
@Controller
@RequestMapping("/gt-document")
public class GtDocumentController {
    
    @RequestMapping
    public String index(Model model, @RequestParam(required = false, defaultValue = "0") int bizId) {

        // 业务线ID
        model.addAttribute("bizId", bizId);


        return "document/document.list";
    }
}
