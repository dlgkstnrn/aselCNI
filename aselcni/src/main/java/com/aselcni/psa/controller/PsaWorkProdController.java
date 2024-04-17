package com.aselcni.psa.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
	
	// 생산지시 메인 페이지 조회
	@RequestMapping(value = "workprod")
	public String workprod(ProdPlan prodPlan, WorkProd workProd, Model model) {
		
		System.out.println();
		System.out.println("psa 생산지시 메인 페이지 시작!");

		// 생산지시일을 오늘날짜로 세팅
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		String today = dateFormat.format(new Date());
		System.out.println("today Format: " + today);
		
		workProd.setWorkprod_dt(today);

		// model setting
		// private method call
		commonWorkProd(prodPlan, workProd, model);
		
		return "psa/workprod";
		
	}
	
	// 달력 날짜 변경 후 조회 ajax
	@RequestMapping("workprod/workprodTB")
	@ResponseBody
	public List<WorkProd> inputDate(@RequestBody ProdPlan paramPR, ProdPlan prodPlan, WorkProd workProd, Model model) {
		
		System.out.println("달력 날짜 변경!");
		
		String workprod_dt = paramPR.getProdplan_dt();
		System.out.println("param date: " + paramPR.getProdplan_dt());
		
		workProd.setWorkprod_dt(workprod_dt);
		
		// ajax 성공 시 workProd List 를 바꿔줌
		List<WorkProd> workList = psaService.getWorkList(workProd);
		model.addAttribute("workList", workList);
		
		System.out.println("workList.size(): " + workList.size());
		System.out.println("리턴된 workList: " + workList);
		
		return workList;
		
	}
	
	private void commonWorkProd(ProdPlan prodPlan, WorkProd workProd, Model model) {
		
		// 지시 대기중인 생산계획 리스트 조회
		// (생산지시에 등록되지 않았고, 계획수량이 지시총량보다 크고, 삭제 안 된 것들)
		List<ProdPlan> planList = psaService.getPlanList(prodPlan);
		model.addAttribute("planList", planList);
				
				
		// 지시 등록된 지시리스트 조회
		// (생산일자가 오늘날짜이고, 삭제 안 된 것들)
		List<WorkProd> workList = psaService.getWorkList(workProd);
		model.addAttribute("workList", workList);
				
				
		// 지시 등록 시 사용 가능한 공정리스트 조회
		// select box
		System.out.println("사용가능한 공정리스트 조회");
				
		List<WorkProc> procList = psaService.getProcList();
		model.addAttribute("procList", procList);
				
				
		// 품목 대분류 리스트 조회
		// select box
		List<Item> bigList = psaService.getBigList();
		model.addAttribute("bigList", bigList);
		
	}
	
	// 품목 중분류 ajax
	@RequestMapping("getMidNo")
	@ResponseBody
	public List<Item> getMidNo(@RequestBody Item item) {
		
		System.out.println("중분류 리스트 조회");
		System.out.println("대분류 param: " + item.getBig_no());
		
		List<Item> midList = psaService.getMidList(item);
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
		return smlList;
	}
	
	// 구분된 품목 리스트 ajax
	// select box 에서 선택한 대/중/소 분류에 맞는 리스트
	@RequestMapping("addItemList")
	@ResponseBody
	public List<Item> getItemList(@RequestBody Item item) {
		
		System.out.println("대중소 분류된 품목 리스트 조회");
		System.out.println("대분류 param: " + item.getBig_no());
		System.out.println("중분류 param: " + item.getMid_no());
		System.out.println("소분류 param: " + item.getSml_no());
		
		List<Item> itemList = psaService.getItemList(item);
		return itemList;
	}
	
	// ajax 1 - 생산지시
	// 등록된 지시내역의 생산지시번호별 상세내용 조회 (공정, 투입품 제외)
	@RequestMapping(value ="wprInfoModal")
	@ResponseBody
	public WorkProd wprInfoModal(@RequestBody WorkProd insertedWorkProd) {
		
		System.out.println("등록된 생산지시 내용 조회");
		
		WorkProd wprInfoModal = psaService.selectWorkProd(insertedWorkProd);
		return wprInfoModal;
	}
	
	// ajax 2 - 생산지시 내역 - 공정 리스트
	// 등록된 지시내역의 생산지시번호별 공정 리스트 조회
	@RequestMapping("workProcList")
	@ResponseBody
	public List<WorkProc> workProcList(@RequestBody WorkProd workProd, Model model) {
		
		System.out.println("생산지시 공정리스트 조회");
		
		List<WorkProc> workProcList = psaService.getWorkProcList(workProd);
		return workProcList;
	}
	
	// ajax 3 - 생산지시 내역 - 투입품 리스트
	// 등록된 지시내역의 생산지시번호별 투입품 리스트 조회
	@RequestMapping("workItemList")
	@ResponseBody
	public List<WorkItem> workItemList(@RequestBody WorkProd workProd) {
		
		System.out.println("생산지시 투입품리스트 조회");
		
		List<WorkItem> workItemList = psaService.getWorkItemList(workProd);
		return workItemList;
	}
	
	// ajax 1 - 생산계획 내역
	// 생산계획번호별 상세내용 조회 (공정, 투입품 제외)
	@RequestMapping("prpInfoModal")
	@ResponseBody
	public ProdPlan prpInfoModal(@RequestBody ProdPlan insertedProdPlan) {
		
		System.out.println("등록된 생산계획 내용 조회");
		
		ProdPlan prpInfoModal = psaService.selectProdPlan(insertedProdPlan);
		return prpInfoModal;
	}
	
	// ajax 2 - 생산계획 내역 - 투입품 리스트
	// 생산계획번호별 투입품 리스트 조회
	@RequestMapping("planItemList")
	@ResponseBody
	public List<ProdItem> planItemList(@RequestBody ProdPlan prodPlan) {
		
		System.out.println("생산계획 투입품리스트 조회");
		
		List<ProdItem> planItemList = psaService.getPlanItemList(prodPlan);
		return planItemList;
		
	}
	
	// ajax 1 -  생산지시 등록 (Modal version)
	// 공정, 투입품 제외
	// INSERT INTO TB_WORKPROD
	// <form>
	@ResponseBody
	@RequestMapping(value = "workprodInsert")
	public WorkProd workprodInsert(@RequestBody WorkProd workProd, HttpServletRequest request) {
		
		System.out.println();
		System.out.println("생산지시 등록 시작");
		int result = 0;
		
		// 1. workprod_emp_id setting
		String user_id = (String) request.getSession().getAttribute("user_id");
		System.out.println("로그인 아이디: "+user_id);
		
		workProd.setWorkprod_emp_id(user_id);
		
		// 2. workprod_no setting
		String workprodNo = psaService.getPK();
		System.out.println("PK workprodNo: " + workprodNo);
		
		workProd.setWorkprod_no(workprodNo);
		
		// 3. if (workprod_delete_chk=null) set 0
		workProd.setWorkprod_delete_chk(0);
		
		// insert into TB_WORKPROD
		result = psaService.workProdInsert(workProd);
		System.out.println("생산지시 등록 완료");
		
		return workProd;
		
	}
	
	// ajax 2 -  생산지시 등록 (Modal version)
	// 공정 - proc_cd []
	// INSERT INTO TB_WORK_PROC
	@ResponseBody
	@RequestMapping(value = "workprocInsert")
	public WorkProc workprocInsert(@RequestParam("workprod_no") String workprod_no, HttpServletRequest request, WorkProc workproc) {
		
		System.out.println();
		System.out.println("공정 등록 시작");
		int result = 0;
		
		workproc.setWorkprod_no(workprod_no);
		
		// ajax를 통해 넘어온 배열 데이터 선언
		String[] procArr = request.getParameterValues("procArr");
		
		if (procArr != null && procArr.length > 0) {
			
			for (int i=0; i < procArr.length; i++) {
				
				workproc.setProc_cd(procArr[i]);
				System.out.println("세팅된 workproc : " + workproc);
				
				// insert into TB_WORK_PROC
				// parameter를 반복해서 전달
				result = psaService.workprocInsert(workproc);
				
				result += result;
				
			}
			
			System.out.println("공정 등록 성공");
			System.out.println("공정 등록 result : " + result);
			
		}
		
		return workproc;
	}
	
	// ajax 3 -  생산지시 등록 (Modal version)
	// 투입품 등록
	// INSERT INTO TB_WORK_ITEM
	@ResponseBody
	@RequestMapping(value = "workItemInsert")
	public String workItemInsert(@RequestParam("workprod_no") String workprod_no, HttpServletRequest request, WorkItem workItem) {
		
		System.out.println();
		System.out.println("투입품 등록 시작");
		int result = 0;
		
		workItem.setWorkprod_no(workprod_no);
		
		// ajax를 통해 넘어온 배열 데이터 선언
		String[] itemCdArr = request.getParameterValues("itemCdArr");
		String[] inQtyArr = request.getParameterValues("inQtyArr");
		
		if (itemCdArr != null && itemCdArr.length > 0) {
			
			for (int i=0; i < itemCdArr.length; i++) {
				
				workItem.setItem_cd(itemCdArr[i]);
				workItem.setIn_qty(Integer.parseInt(inQtyArr[i]));
				System.out.println("세팅된 workItem: " + workItem);
				
				// INSERT INTO TB_WORK_ITEM
				// parameter를 반복해서 전달
				result = psaService.workItemInsert(workItem);
				
				result += result;
				
			}
			
			System.out.println("투입품 등록 성공");
			System.out.println("투입품 등록 result : " + result);
			
		}
		
		// 클라이언트 요청으로 서버 DB 변경 시 redirect
		return "redirect:psa/workprod";
	}
	
	// 생산지시 수정 ajax
	// UPDATE TB_WORKPROD SET REMARK=' ' , WORKPROD_UPDATE = ' '
	// WHERE WORKPROD_NO = ' '
	@ResponseBody
	@RequestMapping("updateWork")
	public String updateWork(@RequestBody WorkProd workProd) {
		
		System.out.println();
		System.out.println("수정해보자");
		System.out.println("param workProd: "+workProd);
		
		// 업데이트일을 오늘 날짜로
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		String today = dateFormat.format(new Date());
		System.out.println("오늘날짜: " + today);
		
		workProd.setWorkprod_update(today);
		
		int result = psaService.updateWork(workProd);
		System.out.println("int result: " + result);
		
		// 클라이언트 요청으로 서버 DB 변경 시 redirect
		return "redirect:psa/workprod";
	}
}
