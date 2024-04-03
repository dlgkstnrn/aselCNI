package com.aselcni.kdw.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aselcni.kdw.model.TB_ITEM_PROD;
import com.aselcni.kdw.model.TB_PRODPLAN;
import com.aselcni.kdw.service.KdwProdPlanService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
		System.out.println("KdwProductionPlanningController getProdPlanMainForm Start...");
		// 제품 리스트
		List<TB_PRODPLAN> prodPlans = kdwProdPlanService.getProdPlanList();
		System.out.println("KdwProductionPlanningController getProdPlanMainForm prodPlans.size(): " + prodPlans.size());
		// 자재 리스트(제품하나에 여러 자재)
		List<TB_ITEM_PROD> prodItems = kdwProdPlanService.getProdItemList();
		System.out.println("KdwProductionPlanningController getProdPlanMainForm prodItems.size(): " + prodItems.size());
		
	    model.addAttribute("prodPlans", prodPlans); // 제품정보
	    model.addAttribute("prodItems", prodItems); // 자재정보
		return "kdw/kdwProductionPlanning";
	}
	// 계획생산 
	@GetMapping(value = "prodplanCalenderList", produces = "application/json")
	@ResponseBody
	public Map<String, Object> getProdPlanData() {
	    List<TB_PRODPLAN> prodPlans = kdwProdPlanService.getProdPlanList();
	    List<TB_ITEM_PROD> prodItems = kdwProdPlanService.getProdItemList();
	    Map<String, Object> responseProdPlans = new HashMap<>();
	    responseProdPlans.put("prodPlans", prodPlans); // 제품정보
	    responseProdPlans.put("prodItems", prodItems); // 자재정보
	    return responseProdPlans;
	}
}
