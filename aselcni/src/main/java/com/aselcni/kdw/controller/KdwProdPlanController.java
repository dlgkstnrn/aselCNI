package com.aselcni.kdw.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aselcni.kdw.model.KDW_TB_ITEMMST;
import com.aselcni.kdw.model.KDW_TB_ORDER;
import com.aselcni.kdw.model.KDW_TB_ORDER_ITEM;
import com.aselcni.kdw.model.KDW_TB_TYPE_BIG;
import com.aselcni.kdw.model.KDW_TB_TYPE_MID;
import com.aselcni.kdw.model.KDW_TB_TYPE_SML;
import com.aselcni.kdw.model.ProdPlanData;
import com.aselcni.kdw.model.ProdPlanDataUpdate;
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
	@GetMapping(value = "prodplanCalenderList")
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

	// 제품, 자재 대중소 분류
	@ResponseBody
	@GetMapping(value = "categories")
	public Map<String, Object> getAllCategories() {
		System.out.println("KdwProductionPlanningController getAllCategories Start...");
		Map<String, Object> itemCategories = new HashMap<>();
		// 대중소분류 데이터 로드
		List<KDW_TB_TYPE_BIG> itemMajorCategories = kdwProdPlanService.getProdPlanItemTypeBigList();
		List<KDW_TB_TYPE_MID> itemMiddleCategories = kdwProdPlanService.getProdPlanItemTypeMidList();
		List<KDW_TB_TYPE_SML> itemMinorCategories = kdwProdPlanService.getProdPlanItemTypeSmlList();

		itemCategories.put("itemMajorCategories", itemMajorCategories); // 대분류정보
		itemCategories.put("itemMiddleCategories", itemMiddleCategories); // 중분류정보
		itemCategories.put("itemMinorCategories", itemMinorCategories); // 소분류정보

		return itemCategories;
	}

	// 제품, 자재 대중소 분류된 리스트 가져오기
	@ResponseBody
	@GetMapping(value = "categoriesSearchList")
	public List<KDW_TB_ITEMMST> getItemsByCategory(@RequestParam(name = "bigNo") int bigNo,
			@RequestParam(name = "midNo") int midNo, @RequestParam(name = "smlNo") int smlNo) {
		System.out.println("KdwProductionPlanningController getItemsByCategory Start...");
		// 해당 분류에 맞는 아이템 리스트 조회 로직 호출
		List<KDW_TB_ITEMMST> itemCategoriesSearchList = kdwProdPlanService.getItemCategoriesSearchList(bigNo, midNo,
				smlNo);
		System.out.println(
				"KdwProductionPlanningController itemCategoriesSearchList.size(): " + itemCategoriesSearchList.size());
		return itemCategoriesSearchList;
	}
	// 생산계획등록
	@ResponseBody
	@PostMapping(value = "submitProdPlan")
	public String submitProdPlan(@RequestBody ProdPlanData prodPlanData, HttpServletRequest request) {
		System.out.println("KdwProductionPlanningController submitProdPlan Start...");
        String prodplan_emp_id = (String) request.getSession().getAttribute("user_id");
        // 서비스 레이어에 생산계획 및 자재 정보 저장을 요청
        kdwProdPlanService.saveProdPlanAndItems(prodPlanData, prodplan_emp_id);
        return "redirect:/kdw/productionPlanning";
	}
	
	// 생산계획수정
	@ResponseBody
	@PostMapping(value = "updateProdPlan")
	public String updateProdPlan(@RequestBody ProdPlanDataUpdate prodPlanDataUpdate, HttpServletRequest request) {
		System.out.println("KdwProductionPlanningController updateProdPlan Start...");
		String prodplan_emp_id_update = (String) request.getSession().getAttribute("user_id");
	    // 생산 계획 업데이트 (투입자재는 추가시 insert, 기존자재 수정시 delete)
	    kdwProdPlanService.updateProdPlan(prodPlanDataUpdate, prodplan_emp_id_update);

	    return "redirect:/kdw/productionPlanning";
	}
	// 생산계획삭제: prodPlan_delete_chk 값을 1로 설정
	@ResponseBody
	@PostMapping(value = "deleteProdPlan")
	public String deleteProdPlan(@RequestBody TB_PRODPLAN prodplan) {
		System.out.println("KdwProductionPlanningController deleteProdPlan Start...");
		String prodPlanNo = prodplan.getProdPlan_no();
	    kdwProdPlanService.markProdPlanAsDeleted(prodPlanNo);
	    return "redirect:/kdw/productionPlanning";
	}
	
}
