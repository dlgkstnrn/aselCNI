package com.aselcni.kdw.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aselcni.kdw.model.KDW_TB_ORDER;
import com.aselcni.kdw.model.KDW_TB_ORDER_ITEM;
import com.aselcni.kdw.model.KDW_TB_TYPE_BIG;
import com.aselcni.kdw.model.KDW_TB_TYPE_MID;
import com.aselcni.kdw.model.KDW_TB_TYPE_SML;
import com.aselcni.kdw.model.TB_ITEM_PROD;
import com.aselcni.kdw.model.TB_PRODPLAN;
import com.aselcni.kdw.service.KdwProdPlanService;

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
		Map<String, Object> responseProdPlans = new HashMap<>();
	    List<TB_PRODPLAN> prodPlans = kdwProdPlanService.getProdPlanList();
	    List<TB_ITEM_PROD> prodItems = kdwProdPlanService.getProdItemList();
	    List<KDW_TB_ORDER> prodOrderList = kdwProdPlanService.getProdOrderList();
	    List<KDW_TB_ORDER_ITEM> prodOrderItemList = kdwProdPlanService.getProdOrderItemList();
	    responseProdPlans.put("prodPlans", prodPlans); // 제품정보
	    responseProdPlans.put("prodItems", prodItems); // 자재정보
	    responseProdPlans.put("prodOrderList", prodOrderList); // 주문정보
	    responseProdPlans.put("prodOrderItemList", prodOrderItemList); // 주문제품정보
	    return responseProdPlans;
	}
	// 제품, 자재 대중소 분류리스트
	@ResponseBody
    @GetMapping(value = "categories")
    public Map<String, Object> getAllCategories() {
		System.out.println("KdwProductionPlanningController getAllCategories Start...");
        Map<String, Object> itemCategories = new HashMap<>();
        // 대중소분류 데이터 로드
        List<KDW_TB_TYPE_BIG> itemMajorCategories = kdwProdPlanService.getProdPlanItemTypeBigList();
        List<KDW_TB_TYPE_MID> itemMiddleCategories = kdwProdPlanService.getProdPlanItemTypeMidList();
        List<KDW_TB_TYPE_SML> itemMinorCategories = kdwProdPlanService.getProdPlanItemTypeSmlList();

        itemCategories.put("itemMajorCategories", itemMajorCategories);
        itemCategories.put("itemMiddleCategories", itemMiddleCategories);
        itemCategories.put("itemMinorCategories", itemMinorCategories);

        return itemCategories;
    }

	
}
