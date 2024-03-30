package com.aselcni.psa.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.aselcni.psa.model.ProdPlan;
import com.aselcni.psa.model.WorkProd;
import com.aselcni.psa.service.PsaWorkProdService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class PsaWorkProdController {

	private final PsaWorkProdService psaService;
	
	// 생산지시 메인 페이지
	@RequestMapping(value = "workprod")
	public String workprod(ProdPlan prodPlan, Model model) {
		
		System.out.println("psa 생산지시 메인 페이지 시작!");
/*		
		// 오늘 날짜 얻기
		String today = 
		prodPlan.setProdplan_dt(null);
		
		// 생산시작일자별로 생산계획 정보 불러와서 리스트로 뿌려주기
		List<WorkProd> planList = psaService.getPlanList();
		model.addAttribute("planList", planList);
*/		
		return "psa/workprod";
		
	}
	
}
