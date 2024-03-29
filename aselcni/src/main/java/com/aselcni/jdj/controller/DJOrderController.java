package com.aselcni.jdj.controller;

import org.springframework.stereotype.Controller;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;


@Controller
@RequiredArgsConstructor
public class DJOrderController {

	@GetMapping("/order")
	public String getMethodName() {
		return "jdj/DJOrder";
	}
	
}
