package com.aselcni.kdw.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class KdwProductionPlanningController {
	
	// 계획생산 리스트 조회(달력폼) 이동
	@GetMapping(value = "prodplan")
	public String getproductionPlanningForm(HttpServletRequest request, Model model) {
		System.out.println("KdwProductionPlanningController getproductionPlanningForm Start...");
		return "kdw/kdwProductionPlanning";
	}
}
