package com.aselcni.jtu.controller;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import lombok.RequiredArgsConstructor;

import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aselcni.jtu.model.JtuBad;
import com.aselcni.jtu.model.JtuProdItem;
import com.aselcni.jtu.model.JtuWH;
import com.aselcni.jtu.model.JtuWorkProd;
import com.aselcni.jtu.service.JtuServiceInterface;

@Controller
@RequiredArgsConstructor
public class JtuController {
	private final JtuServiceInterface js;

	@RequestMapping("proditem")
	public String proditem(Model model) {
		System.out.println("JtuController getMethodName Start... ");
		String todayStr=LocalDate.now().toString();
		String afterDayStr=LocalDate.now().plusDays(7).toString();
		
		JtuProdItem jpri = new JtuProdItem();
		jpri.setStartDate(todayStr);
		jpri.setEndDate(afterDayStr);

//		List<JtuProdItem> jpriList = js.getPriList(jpri);
//		System.out.println("JtuController proditem jpriList --> " + jpriList);
//
//		model.addAttribute("jpriList", jpriList);
		return "jtu/jtuProdItemView";
	}

	@ResponseBody
	@RequestMapping("getPriListAjax")
	// 생산 실적 리스트 불러오기
	public List<JtuProdItem> getPriListAjax(Model model, JtuProdItem jpri) {
		System.out.println("JtuController getPriListAjax Start... ");
		System.out.println("JtuController getPriListAjax jpri --> " + jpri);
		List<JtuProdItem> jpriListAjax = js.getPriList(jpri);

		return jpriListAjax;
	}

	
	@ResponseBody
	@RequestMapping("getPriOneAjax")
	// 생산 실적 상세 불러오기
	public JtuProdItem getPriOneAjax(Model model, JtuProdItem paraJpri) {
		System.out.println("JtuController getWHListListAjax Start... ");
		System.out.println("JtuController getPriOneAjax paraJpri --> " + paraJpri);
		
		JtuProdItem jpri = js.getPriOneAjax(paraJpri);
		
		return jpri;
	}

	@ResponseBody
	@RequestMapping("getWorkProdNoRegiModalList")
	// 생산 지시 리스트 불러오기
	public List<JtuWorkProd> getWprListAjax(Model model) {
		System.out.println("JtuController getWprListAjax Start... ");
		List<JtuWorkProd> jwprList = js.getWprList();
		System.out.println("JtuController getWprListAjax wpdList --> " + jwprList);

		return jwprList;
	}
	
	
	@ResponseBody
	@RequestMapping("getWHListModal")
	// 창고 리스트 불러오기
	public List<JtuWH> getWHListAjax(Model model) {
		System.out.println("JtuController getWHListListAjax Start... ");

		List<JtuWH> jwhList = js.getWhCode();
		System.out.println("JtuController getWHListListAjax jwhList --> " + jwhList);

		return jwhList;
	}
	
	@ResponseBody
	@RequestMapping("getBadListModal")
	// 불량 코드 리스트 불러오기
	public List<JtuBad> getBadListAjax(Model model, JtuBad jbad) {
		System.out.println("JtuController getBadListAjax Start... ");
		
		List<JtuBad> jbadList = js.getJbadList(jbad);
		System.out.println("JtuController getBadListAjax jbadList --> " + jbadList);
		
		return jbadList;
	}
	
	@ResponseBody
	@RequestMapping("submitBadModal")
	// 불량 코드 등록
	public String setJabadOne(Model model, JtuBad jbad) {
		System.out.println("JtuController setJabadOne Start... ");
		System.out.println("JtuController setJabadOne jbad --> " + jbad);
		js.setJbadOne(jbad);
		
		return "";
	}
	

	
	@RequestMapping("submitWorkProdRegiModal")
	// 생산 실적 등록
	public String setPriOne(Model model, JtuProdItem jpri) {
		System.out.println("JtuController setPriOne Start... ");
		System.out.println("JtuController setPriOne jpri --> " + jpri);

		js.setPriOne(jpri);
		return "redirect:/proditem";
	}
	
	@RequestMapping("submitProdItemEditModal")
	// 생산 실적 수정 업데이트
	public String updatePriOne(Model model, JtuProdItem jpri) {
		System.out.println("JtuController updatePriOne Start... ");
		System.out.println("JtuController updatePriOne jpri --> " + jpri);
		
		js.updatePriOne(jpri);
		return "redirect:/proditem";
	}
	
	@RequestMapping("deleteProdItemEditModal")
	// 생산 실적 삭제 업데이트
	public String deletePriOne(Model model, JtuProdItem jpri) {
		System.out.println("JtuController deletePriOne Start... ");
		System.out.println("JtuController deletePriOne jpri --> " + jpri);
		
		js.deletePriOne(jpri);
		
		return "redirect:/proditem";
	}

}
