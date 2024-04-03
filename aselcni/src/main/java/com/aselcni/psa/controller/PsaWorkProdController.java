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
	public String workprod(HttpServletRequest request, ProdPlan prodPlan, WorkProd workProd, Model model) {
		
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
		
		
		
		// 로그인 유저아이디(담당자) 억지로 세팅
//		String user_id = "psa";
//		prodPlan.setProdplan_emp_id(user_id);
		

		
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
		
		
		// 생산지시 등록 모달 내용
		// 해당 생산계획번호에 맞는 정보 조회
//		ProdPlan prodPlan2 = new ProdPlan();
//		prodPlan2.setProdplan_no(prodPlan.getProdplan_no());
		
		
		return "psa/workprod";
		
	}
	
	// ajax 1
	// 등록된 지시내역의 생산지시번호별 상세내용 조회 (공정, 투입품 제외)
	@RequestMapping(value ="wprInfoModal")
	@ResponseBody
	public WorkProd wprInfoModal(@RequestBody WorkProd insertedWorkProd) {
		
		System.out.println("wprInfoModal 내용 조회");
		System.out.println("param workprod_no: " + insertedWorkProd.getWorkprod_no());
		System.out.println("param: "+insertedWorkProd);	
		
		WorkProd wprInfoModal = psaService.selectWorkProd(insertedWorkProd);
		System.out.println("returned WorkProd: "+wprInfoModal);
		
		return wprInfoModal;
	}
	
	// ajax 2
	// 등록된 지시내역의 생산지시번호별 공정 리스트 조회
	@RequestMapping("workProcList")
	@ResponseBody
	public List<WorkProc> workProcList(@RequestBody WorkProd workProd, Model model) {
		
		System.out.println("공정리스트 조회");
		
		List<WorkProc> workProcList = psaService.getWorkProcList(workProd);
		System.out.println("returned workProcList: "+workProcList);
		System.out.println("size:"+workProcList.size());
		return workProcList;
		
	}
	
	// ajax 3
	// 등록된 지시내역의 생산지시번호별 투입품 리스트 조회
	@RequestMapping("workItemList")
	@ResponseBody
	public List<WorkItem> workItemList(@RequestBody WorkProd workProd) {
		
		System.out.println("투입품리스트 조회");
		
		List<WorkItem> workItemList = psaService.getWorkItemList(workProd);
		System.out.println("returned workItemList: "+workItemList);
		System.out.println("size:"+workItemList.size());
		return workItemList;
	}
	
	
	
	
	
	
	
	
	// 생산지시 등록
	@RequestMapping(value = "workprodInsert")
	public void workprodInsert(@ModelAttribute WorkProd workProd) {
		
		// insert into TB_WORKPROD
//		psaService.workProdInsert(workProd);
		System.out.println("생산지시 등록 완료");
		
	}
	
	// 투입품 등록
//	@RequestMapping(value = "addItems")
}
