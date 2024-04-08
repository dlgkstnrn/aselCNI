package com.aselcni.psa.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aselcni.psa.model.Item;
import com.aselcni.psa.model.ProdItem;
import com.aselcni.psa.model.ProdPlan;
import com.aselcni.psa.model.WorkItem;
import com.aselcni.psa.model.WorkProc;
import com.aselcni.psa.model.WorkProd;
import com.aselcni.psa.service.PsaWorkProdService;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class PsaWorkProdController {

	private final PsaWorkProdService psaService;
	
	// 생산지시 메인 페이지
	@RequestMapping(value = "workprod")
	public String workprod(ProdPlan prodPlan, WorkProd workProd, Model model) {
		
		System.out.println("psa 생산지시 메인 페이지 시작!");

		// 생산지시일을 오늘날짜로 세팅
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		String today = dateFormat.format(new Date());
		System.out.println("today Format: " + today);
		
		workProd.setWorkprod_dt(today);
		
//		Integer parse = Integer.parseInt(prodPlan.getProdplan_end_dt());
//		System.out.println("par:"+parse);
		
		
		// form tag에서 얻어온 생산시작일자를 ProdPlan과 WorkProd의 생산시작일자로 세팅
//		String prodplan_dt = request.getParameter("prodplan_dt");
//		System.out.println("prodplan_dt: " + prodplan_dt);
//		prodPlan.setProdplan_dt(prodplan_dt);
//		workProd.setWorkprod_dt(prodplan_dt);
		
		
		// 지시 대기중인 생산계획 리스트 조회
		// (생산지시에 등록되지 않았고, 삭제 안 된 것들)
		List<ProdPlan> planList = psaService.getPlanList(prodPlan);
		System.out.println("ProdPlan List: " + planList);
		System.out.println("ProdPlan List size: " + planList.size());
		model.addAttribute("planList", planList);
		
		// 지시 등록된 지시리스트 조회
		// (생산일자가 오늘날짜 이후고, 삭제 안 된 것들)
		List<WorkProd> workList = psaService.getWorkList(workProd);
		System.out.println("WorkProd List: " + workList);
		System.out.println("WorkProd List size: " + workList.size());
		model.addAttribute("workList", workList);
		
		// 지시 등록 시 사용 가능한 공정리스트 조회
		// select box
		System.out.println("사용가능한 공정리스트 조회");
		
		List<WorkProc> procList = psaService.getProcList();
		System.out.println("공정리스트: " + procList);
		System.out.println("공정리스트 사이즈: " + procList.size());
		model.addAttribute("procList", procList);
		
		// 품목 대분류
		// select box
		List<Item> bigList = psaService.getBigList();
		System.out.println("대분류 리스트: " + bigList);
		System.out.println("대분류 리스트 사이즈: " + bigList.size());
		model.addAttribute("bigList", bigList);
		
		return "psa/workprod";
		
	}
	
	// 품목 중분류 ajax
	@RequestMapping("getMidNo")
	@ResponseBody
	public List<Item> getMidNo(@RequestBody Item item) {
		
		System.out.println("중분류 리스트 조회");
		System.out.println("대분류 param: " + item.getBig_no());
		
		List<Item> midList = psaService.getMidList(item);
		System.out.println("중분류 리스트 사이즈: " + midList.size());
		System.out.println("returned 중분류 리스트: " + midList);
		
		return midList;
	}
	
	// 품목 소분류 ajax
	@RequestMapping("getSmlNo")
	@ResponseBody
	public List<Item> getSmlNo(@RequestBody Item item) {
		
		System.out.println("소분류 리스트 조회");
		System.out.println("대분류 param: " + item.getBig_no());
		System.out.println("중분류 param: " + item.getMid_no());
		
		List<Item> smlList = psaService.getSmlList(item);
		System.out.println("소분류 리스트 사이즈: " + smlList.size());
		System.out.println("returned 소분류 리스트: " + smlList);
		
		return smlList;
	}
	
	// 품목 리스트 ajax
	// select box 에서 선택한 대/중/소 분류에 맞는 리스트
	@RequestMapping("addItemList")
	@ResponseBody
	public List<Item> getItemList(@RequestBody Item item) {
		
		System.out.println("대중소 분류된 품목 리스트 조회");
		System.out.println("대분류 param: " + item.getBig_no());
		System.out.println("중분류 param: " + item.getMid_no());
		System.out.println("소분류 param: " + item.getSml_no());
		
		List<Item> itemList = psaService.getItemList(item);
		System.out.println("필터링된 품목리스트 사이즈: " + itemList.size());
		System.out.println("returned 품목 리스트: " + itemList);
		
		return itemList;
	}
	
	// ajax 1 - 생산지시
	// 등록된 지시내역의 생산지시번호별 상세내용 조회 (공정, 투입품 제외)
	@RequestMapping(value ="wprInfoModal")
	@ResponseBody
	public WorkProd wprInfoModal(@RequestBody WorkProd insertedWorkProd) {
		
		System.out.println("등록된 생산지시 내용 조회");
		System.out.println("param workprod_no: " + insertedWorkProd.getWorkprod_no());
		System.out.println("param: "+insertedWorkProd);	
		
		WorkProd wprInfoModal = psaService.selectWorkProd(insertedWorkProd);
		System.out.println("returned WorkProd: "+wprInfoModal);
		
		return wprInfoModal;
	}
	
	// ajax 2 - 생산지시 - 공정 리스트
	// 등록된 지시내역의 생산지시번호별 공정 리스트 조회
	@RequestMapping("workProcList")
	@ResponseBody
	public List<WorkProc> workProcList(@RequestBody WorkProd workProd, Model model) {
		
		System.out.println("생산지시 공정리스트 조회");
		
		List<WorkProc> workProcList = psaService.getWorkProcList(workProd);
		System.out.println("returned workProcList: "+workProcList);
		System.out.println("size:"+workProcList.size());
		return workProcList;
		
	}
	
	// ajax 3 - 생산지시 - 투입품 리스트
	// 등록된 지시내역의 생산지시번호별 투입품 리스트 조회
	@RequestMapping("workItemList")
	@ResponseBody
	public List<WorkItem> workItemList(@RequestBody WorkProd workProd) {
		
		System.out.println("생산지시 투입품리스트 조회");
		
		List<WorkItem> workItemList = psaService.getWorkItemList(workProd);
		System.out.println("returned workItemList: "+workItemList);
		System.out.println("size:"+workItemList.size());
		return workItemList;
	}
	
	// ajax 1 - 생산계획
	// 생산계획번호별 상세내용 조회 (공정, 투입품 제외)
	@RequestMapping("prpInfoModal")
	@ResponseBody
	public ProdPlan prpInfoModal(@RequestBody ProdPlan insertedProdPlan) {
		
		System.out.println("등록된 생산계획 내용 조회");
		System.out.println("param prodplan_no: " + insertedProdPlan.getProdplan_no());
		System.out.println("param Obj: " + insertedProdPlan);
		
		ProdPlan prpInfoModal = psaService.selectProdPlan(insertedProdPlan);
		System.out.println("returned ProdPlan: " + prpInfoModal);
		
		return prpInfoModal;
	}
	
	// ajax 2 - 생산계획 - 투입품 리스트
	// 생산계획번호별 투입품 리스트 조회
	@RequestMapping("planItemList")
	@ResponseBody
	public List<ProdItem> planItemList(@RequestBody ProdPlan prodPlan) {
		
		System.out.println("생산계획 투입품리스트 조회");
		
		List<ProdItem> planItemList = psaService.getPlanItemList(prodPlan);
		System.out.println("returned planItemList: "+planItemList);
		System.out.println("투입품리스트 size:"+planItemList.size());
		return planItemList;
		
	}
	
	
	
	
	// 생산지시 등록 (페이지 이동 버전)
	@RequestMapping("insertWPR")
	public String insertWPR(@RequestParam("prodplan_no") String prodplan_no, ProdPlan prodPlan, Model model) {
		
		System.out.println("생산지시 등록하기");
		System.out.println("param prodplan_no: " + prodplan_no);
		
		// 지시 등록할 생산계획 조회
		prodPlan.setProdplan_no(prodplan_no);
//		ProdPlan getPlan = psaService.getPlan(prodPlan);
//		System.out.println("returned getPlan: " + getPlan);
		
//		model.addAttribute("getPlan", getPlan);
		
		// 생산계획에 등록된 투입품 리스트 조회
		
		
		
		return "psa/insertWPR";
	}
	
	
	
	
	
	
	// 생산지시 등록 (Modal version)
	@RequestMapping(value = "workprodInsert")
	public void workprodInsert(@ModelAttribute WorkProd workProd) {
		
		// insert into TB_WORKPROD
//		psaService.workProdInsert(workProd);
		System.out.println("생산지시 등록 완료");
		
	}
	
	// 투입품 등록
//	@RequestMapping(value = "addItems")
}
