package com.aselcni.ujm.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aselcni.ujm.service.UjmReturnService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class UjmReturnController {
	
	private final UjmReturnService urs;
	
	@RequestMapping(value = "ujmReturnChk")
	@ResponseBody
	public int ujmReturnChk(@RequestParam("outitem_no") String outitem_no) {
		System.out.println("UjmReturnController 컨트롤러 ujmReturnChk 시작");
		int ujmReturnChk=urs.ujmReturnChk(outitem_no);
		System.out.println("UjmReturnController 컨트롤러 ujmReturnChk:"+ujmReturnChk);
		return ujmReturnChk;
	}

}
