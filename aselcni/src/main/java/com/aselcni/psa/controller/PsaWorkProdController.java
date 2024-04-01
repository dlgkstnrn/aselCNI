package com.aselcni.psa.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.aselcni.psa.model.ProdPlan;
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
/*		
		// 오늘 날짜 얻기
		String today = 
		prodPlan.setProdplan_dt(null);
*/
		// form tag에서 얻어온 생산시작일자를 ProdPlan과 WorkProd의 생산시작일자로 세팅
		String prodplan_dt = request.getParameter("prodplan_dt");
		prodPlan.setProdplan_dt(prodplan_dt);
		workProd.setWorkprod_dt(prodplan_dt);
		
		// 셀렉트도 프로시저로 해야하는데 파라미터 없는 프로시저도 가능함
		
		// 지시 대기중인 생산계획 리스트 조회
		// 파라미터로 생산일자? 오늘날짜로?
		List<ProdPlan> planList = psaService.getPlanList(prodPlan);
		model.addAttribute("planList", planList);
		
		// 등록된 생산지시내역 리스트 조회
		// 파라미터로 뭘 넣어야함? 생산시작일자? 오늘날짜로?
		List<WorkProd> workList = psaService.getWorkList(workProd);
		model.addAttribute("workList", workList);
		
		return "psa/workprod";
		
	}
	
	// 생산지시 등록
	@RequestMapping(value = "workprodInsert")
	public void workprodInsert(@ModelAttribute WorkProd workProd) {
		
		// insert into TB_WORKPROD
		psaService.workProdInsert(workProd);
		System.out.println("생산지시 등록 완료");
		
	}
	
	// 투입품 등록
	@RequestMapping(value = "addItems")
	
	
}
