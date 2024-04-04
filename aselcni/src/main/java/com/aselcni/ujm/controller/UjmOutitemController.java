package com.aselcni.ujm.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.aselcni.ujm.service.UjmOutitemService;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;


@Controller
@RequiredArgsConstructor
@Slf4j
public class UjmOutitemController {

	private final UjmOutitemService ujmOutitemService;
	
	@RequestMapping(value = "ujmExample") // 로그인 폼으로 이동시킴
	public String ujmLoginForm(HttpServletRequest request) {
		return "ujm/example"; 
	}
	
	@RequestMapping(value = "outitem") // 로그인 폼으로 이동시킴
	public String ujmOutitemForm(HttpServletRequest request) {
		return "ujm/ujmOutitem"; 
	}
}
