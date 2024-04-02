package com.aselcni.jtu.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aselcni.jtu.model.JtuProdItem;
import com.aselcni.jtu.service.JtuServiceInterface;
import com.aselcni.psa.model.WorkProd;


@Controller
@RequiredArgsConstructor
public class JtuController {
	private final JtuServiceInterface js;
	
	
	@RequestMapping("proditem")
	public String proditem(Model model) {
		System.out.println("JtuController getMethodName Start... ");

		
		return "jtu/jtuProdItemView";
	}
	
	@ResponseBody
	@RequestMapping("workProdNoRegiModal")
	public List<WorkProd> getWprListAjax(Model model) {
		System.out.println("JtuController getWprListAjax Start... ");
		List<WorkProd> wprList =js.getWprList();
		System.out.println("JtuController getWprListAjax wpdList --> " + wprList);
		
		return wprList;
	}
	
	@RequestMapping("workProdNoRegiSubmit")
	public String setPriOne(Model model, JtuProdItem pri) {
		System.out.println("JtuController setPriOne Start... ");
		System.out.println("JtuController setPriOne pri --> " + pri);
		
		js.setPriOne();
		
		return "jtu/jtuProdItemView";
	}
	
	@RequestMapping("aaa")
	public String aaa(Model model) {
		System.out.println("JtuController getMethodName Start... ");
		
		return "psa/workprod";
	}
	
}
