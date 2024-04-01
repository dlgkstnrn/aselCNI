package com.aselcni.kdw.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.aselcni.kdw.model.TB_PRODPLAN;
import com.aselcni.kdw.service.KdwProdPlanService;

import java.util.List;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class KdwProdPlanController {
	
	private final KdwProdPlanService kdwProdPlanService;
	
	// 계획생산 리스트 조회(달력폼) 이동
	@GetMapping(value = "prodplan")
	public String getProdPlanMainForm(Model model) {
		System.out.println("KdwProductionPlanningController getproductionPlanningForm Start...");
		List<TB_PRODPLAN> prodPlans = kdwProdPlanService.getProdPlanList();
		return "kdw/kdwProductionPlanning";
	}
}
