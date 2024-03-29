package com.aselcni.psa.controller;

import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;

@org.springframework.stereotype.Controller
@RequiredArgsConstructor

public class PsaWorkprodController {

	@RequestMapping(value = "workprod")
	public String workprod() {
		
		
		return "/psa/workprod";
		
	}
	
}
