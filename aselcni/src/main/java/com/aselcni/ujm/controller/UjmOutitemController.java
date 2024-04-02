package com.aselcni.ujm.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.aselcni.ujm.model.UjmOutitem;
import com.aselcni.ujm.service.UjmOutitemService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;


@Controller
@RequiredArgsConstructor
@Slf4j
public class UjmOutitemController {

	private final UjmOutitemService ujmOutitemService;
	
	@RequestMapping(value = "ujmExample") 
	public String ujmLoginForm(HttpServletRequest request) {
		return "ujm/example"; 
	}
	
	@RequestMapping(value = "outitem") 
	public String ujmOutitemForm(UjmOutitem outitem, HttpServletRequest request, Model model, HttpSession session) {
		System.out.println("출고페이지 접근");
		if(outitem.getCurrentPage()==null) {
			outitem.setCurrentPage("1");
		}
		
		int ujmTotalOutitemCnt=ujmOutitemService.ujmTotalOutitemCnt();
		System.out.println("가져온 출고 개수:"+ujmTotalOutitemCnt);
		
		//맨처음 리스트에 표시되는 outitemList
//		model.addAttribute("outitemList",outitemList); 
		
		return "ujm/ujmOutitem"; 
	}
	
	//출고 등록
	@RequestMapping(value = "insertOutitem") 
	public String ujmInsertOutitem(HttpServletRequest request, Model model, HttpSession session) {
		UjmOutitem outitem=new UjmOutitem();
		
		//맨처음 리스트에 표시되는 outitemList
//		model.addAttribute("outitemList",outitemList); 
		
		//outitemView
		
		return "ujm/ujmOutitem"; 
	}
	
	//출고 수정
	@RequestMapping(value = "updateOutitem") 
	public String ujmUpdateOutitem(HttpServletRequest request, Model model, HttpSession session) {
		UjmOutitem outitem=new UjmOutitem();
		
		//맨처음 리스트에 표시되는 outitemList
//		model.addAttribute("outitemList",outitemList); 
		
		return "ujm/ujmOutitem"; 
	}
	
	//출고 삭제
	@RequestMapping(value = "deleteOutitem") 
	public String ujmDeleteOutitem(HttpServletRequest request, Model model, HttpSession session) {
		UjmOutitem outitem=new UjmOutitem();
		
		//맨처음 리스트에 표시되는 outitemList
//		model.addAttribute("outitemList",outitemList); 
		
		return "ujm/ujmOutitem"; 
	}
}
