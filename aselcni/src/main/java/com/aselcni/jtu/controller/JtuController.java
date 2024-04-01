package com.aselcni.jtu.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.aselcni.jtu.service.JtuService;


@Controller
@RequiredArgsConstructor
public class JtuController {
	private final JtuService js;
	
	
	@RequestMapping("proditem")
	public String getMethodName(Model model) {
		System.out.println("JtuController getMethodName Start... ");
		
		return "jtu/jtuProdItemRegistry";
	}
	
	@RequestMapping("aaa")
	public String aaa(Model model) {
		System.out.println("JtuController getMethodName Start... ");
		
		return "psa/workprod";
	}
	
}
