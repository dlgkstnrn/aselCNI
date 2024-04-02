package com.aselcni.jtu.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aselcni.jtu.model.JtuProdItem;
import com.aselcni.jtu.model.JtuWorkProd;
import com.aselcni.jtu.service.JtuServiceInterface;


@Controller
@RequiredArgsConstructor
public class JtuController {
	private final JtuServiceInterface js;
	
	
	@RequestMapping("proditem")
	public String proditem(Model model) {
		System.out.println("JtuController getMethodName Start... ");
		
		JtuProdItem jpri = js.getWhCode();

		
		return "jtu/jtuProdItemView";
	}
	
	@ResponseBody
	@RequestMapping("getWorkProdNoRegiModalList")
	public List<JtuWorkProd> getWprListAjax(Model model) {
		System.out.println("JtuController getWprListAjax Start... ");
		List<JtuWorkProd> wprList =js.getWprList();
		System.out.println("JtuController getWprListAjax wpdList --> " + wprList);
		
		return wprList;
	}
	
	@RequestMapping("submitWorkProdNoRegiModal")
	public String setPriOne(Model model, JtuProdItem jpri) {
		System.out.println("JtuController setPriOne Start... ");
		System.out.println("JtuController setPriOne jpri --> " + jpri);
		
		js.setPriOne(jpri);
		
		return "jtu/jtuProdItemView";
	}
	
	@RequestMapping("aaa")
	public String aaa(Model model) {
		System.out.println("JtuController getMethodName Start... ");
		
		return "psa/workprod";
	}
	
}
