package com.aselcni.csg.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aselcni.csg.model.CSG_CategoryData;
import com.aselcni.csg.model.CSG_TB_ITEMMST;
import com.aselcni.csg.model.CSG_TB_PURCHASE_ITEM;
import com.aselcni.csg.model.CSG_TB_TYPE_BIG;
import com.aselcni.csg.model.CSG_TB_TYPE_MID;
import com.aselcni.csg.model.CSG_TB_TYPE_SML;
import com.aselcni.csg.service.SK_Service_Interface;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class SK_Controller {
	
	private final SK_Service_Interface sk_ServicInterface;
	
	//네비바에서 메인페이지로 이동 ==> 발주관리 메인페이지 => 발주현황 나오는곳 + 신규등록, 삭제, 검색하는곳 + 페이징
	@RequestMapping(value="purchase")
	public String Sk_Purchase() {
		System.out.println("사이드에서 발주폼에 연결이 드디어 되었습니다요");
		return "csg/CSG_purchase";
	}
	
	//발주관리 에서 테이블에 발주된 애들 불러오는 쿼리
	
	
	//CSG_purchase에서 신규등록을 누르면 a태그로 옮기게 되는 발주등록 및 자재목록 나오게 되는 폼
	@RequestMapping(value="purchaseItemForm")
	public String Sk_PurchasList(Model model) {
		System.out.println("자재 입력해보자구");
		
		System.out.println("대분류 불러오자");
		
		//모달 대분류 디비에서 불러오는거 
		List<CSG_TB_TYPE_BIG> bigTypeList = sk_ServicInterface.findBigTypelist();
		System.out.println("컨트롤러 DB에서 받아온 bigTypeList.size() ==>"+bigTypeList.size());
		model.addAttribute("bigTypeList", bigTypeList);
		
		
		return "csg/CSG_purchaseItem2";
	}
	
	//모달 중분류 ajax로 modalCategory.js로 불러오기
	@ResponseBody
	@GetMapping("modalMid")
	public List<CSG_TB_TYPE_MID> CSG_MidType(CSG_TB_TYPE_MID csgMid){
		System.out.println("컨트롤러 ==> 대분류애들 값 가지고 중분류애들 분류해보자");
		List<CSG_TB_TYPE_MID> midTypeList = sk_ServicInterface.CSG_MidType(csgMid);
		System.out.println("컨트롤러에서 받아온 중분류 것 들 midTypeList ===> " + midTypeList);

		return midTypeList;
	}
	
	//모달 소분류 ajax로 modalCategory.js로 불러오기
	@ResponseBody
	@GetMapping("modalSml")
	public List<CSG_TB_TYPE_SML> CSG_SmlType(CSG_TB_TYPE_SML csgSml){
		System.out.println("컨트롤러 ==> 중분류애들 값 가지고 소분류애들 분류해보자");
		List<CSG_TB_TYPE_SML> smlTypeList = sk_ServicInterface.CSG_SmlType(csgSml);
		
		System.out.println("컨트롤러에서 받아온 소분류 것 들 smlTypeList ===> " + smlTypeList);
		
		return smlTypeList;
	}
	
	//모달안에 테이블 리스트를 뿌려주자
	@ResponseBody
	@RequestMapping(value = "/getItemsBySmlType")
	public List<CSG_TB_ITEMMST> CSG_modalList(@ModelAttribute CSG_TB_TYPE_SML items) {
		//밑에는 대, 중, 소분류 id를 가져오게 된 코드임
		System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"+items); //여긴 대중소분류 id만 있어야됨
		System.out.println("컨트롤러 : 소분류 아이디를 잘 가져왔냐??????????????????????????????"+items.getBig_no());
		
		List<CSG_TB_ITEMMST> selectedItemList = sk_ServicInterface.CSG_SelectedItems(items);
		System.out.println("컨트롤러 : 대중소번호로 아이템리스트들을 잘 가져왔냐??????????????????????????????"+selectedItemList);

		return selectedItemList;
	}
	
	/*//purchaseItem2Form ==> 자재선택(모달) => 대분류 불러오기  => 불러와보장!!!!!!!!!!!!!!!
	@ResponseBody
	@RequestMapping(value="modalMid")
	//public String CSG_BigType (CSG_TB_TYPE_BIG bigType, Model model) {
	public List<CSG_TB_TYPE_BIG> CSG_BigType (Model model) {
		System.out.println("대분류 불러오자");
		
		List<CSG_TB_TYPE_BIG> bigTypeList = sk_ServicInterface.findBigTypelist();
		System.out.println("컨트롤러 DB에서 받아온 bigTypeList.size() ==>"+bigTypeList.size());
		model.addAttribute("bigTypeList", bigTypeList);
		
		return bigTypeList;
	}*/
	
	/*
	//중분류 불러오기
	public String CSG_BigType (CSG_TB_TYPE_MID midType, Model model) {
		System.out.println("대분류 불러오자");
		List<CSG_TB_TYPE_MID> bigTypeList = sk_ServicInterface.findMidTypelist(midType);
		System.out.println("컨트롤러에서 midTypeTypeList");
		model.addAttribute("midTypeList", midTypeTypeList);
		
		return "csg/CSG_purchaseItem2";
	}	
	//소분류 불러오기
	public String CSG_BigType (CSG_TB_TYPE_SML bigType, Model model) {
		System.out.println("대분류 불러오자");
		List<CSG_TB_TYPE_SML> smlTypeList = sk_ServicInterface.findSmlTypelist(bigType);
		System.out.println("컨트롤러에서 smlTypeList");
		model.addAttribute("smlTypeList", smlTypeList);
		
		return "csg/CSG_purchaseItem2";
	}	*/
	
	
	//모달에서 값을 다 불러온다음에 그 모달의 저장을 누르면 여기로 오는건가??
	//purchaseItem2.jsp에서 모달 => 저장버튼 후 => purchaseItem2.jsp로 다시 돌아오는 로직
	@RequestMapping(value="CSG_purchaseItem2Form")
	public String SK_modalSave(/*@RequestBody 객체로 받아주자고 여기는 이제 DB select하면됨*/) {
		System.out.println("모달에서 자재 선택후에 CSG_purchaseItem2.jsp뷰로 돌아오기");
		return "csg/CSG_purchaseItem2";
	}
	
	
	//모달까지 완료한 뒤 발쥬등록 화면에서 저장 ==> 저장한뒤에 발주화면으로 이동
	@PostMapping("/purchaseSave")
	public String PurchaseSave(@ModelAttribute CSG_TB_PURCHASE_ITEM purchaseItem, Model model) {
	    // 폼에서 전송된 데이터를 처리
	    // 예를 들어, 데이터베이스에 저장하는 로직 구현
	    // ...
		
		System.out.println("발주가 등록되었습니다");

	    // 처리 완료 후 리다이렉트할 페이지 지정
		return "csg/CSG_purchase";
	}

	
	

}