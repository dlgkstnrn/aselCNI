package com.aselcni.lhs.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class CompmstController {
	
	@GetMapping("compmst")
	public String compmst() {
		return "lhs/compmst";
	}
	
}
