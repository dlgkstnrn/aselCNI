package com.aselcni.csg.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aselcni.csg.model.CSG_TB_CUSTMST;
import com.aselcni.csg.model.CSG_TB_ITEMMST;
import com.aselcni.csg.model.CSG_TB_PURCHASE;
import com.aselcni.csg.model.CSG_TB_PURCHASE_ITEM;
import com.aselcni.csg.model.CSG_TB_TYPE_BIG;
import com.aselcni.csg.model.CSG_TB_TYPE_MID;
import com.aselcni.csg.model.CSG_TB_TYPE_SML;
import com.aselcni.csg.service.SK_Service_Interface;
import com.aselcni.csg.service.csg_Paging;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class SK_Controller {
	
	private final SK_Service_Interface sk_ServicInterface;
	
	//네비바에서 메인페이지로 이동 ==> 발주관리 메인페이지 
	//발주현황 나오는곳 + 신규등록, 삭제, 검색하는곳 + 페이징  수정도 할 수 있으면 해보자고
	@RequestMapping(value="purchase")
	public String Sk_Purchase(Model model, CSG_TB_PURCHASE csg_TB_PURCHASE) {
		System.out.println("사이드에서 발주폼에 연결이 드디어 되었습니다");
		
		//전체발주 개수 가져오기
		int totalPurchase = sk_ServicInterface.totalPurchase(csg_TB_PURCHASE);
		System.out.println("컨트롤러 : paing을 위한 totalPurchas는 잘 가져왔니? = >"+totalPurchase);
		
		//Paging
		csg_Paging paging = new csg_Paging(totalPurchase, csg_TB_PURCHASE.getCurrentPage());
		System.out.println("test : " + paging);
		csg_TB_PURCHASE.setStart(paging.getStart()); //시작 1
		csg_TB_PURCHASE.setEnd(paging.getEnd());	 //끝 5
		
		//발주테이블에서 데이터 조회 + 페이징처리
		List<CSG_TB_PURCHASE> purchaseList = sk_ServicInterface.findAllPurchase(csg_TB_PURCHASE);
		System.out.println("발주화면에 처음 나올떄 발주 리스트를 가져오자구 purchaseList + Paging@@@@@@@@@@@@@@@@@@@@@@@@@ ==>" + purchaseList);
		
		
		model.addAttribute("purchaseList", purchaseList);	//페이징 처리한 발주리스트(10개씩)
		model.addAttribute("totalPUrchase", totalPurchase); //전체 페이지수 12개(발주애들 리스트 개수들 보여주기
		model.addAttribute("page", paging);	//paging 하기전에 CurrentPage가 나온거니?? ==> null
		
		return "csg/CSG_purchase";
	}
	
	//발주관리 ==> ajax용 다시 도전
    @ResponseBody
    @GetMapping("/searchPurchases")
    public Map<String, Object> searchPurchases(CSG_TB_PURCHASE csg_TB_PURCHASE) {
        Map<String, Object> response = new HashMap<String, Object>();
        System.out.println("무슨값이 넘어오니 ㅎㅎ? ==> " + csg_TB_PURCHASE);
        
        // 전체 발주 개수 계산
		int fiterPurchase = sk_ServicInterface.totalPurchase(csg_TB_PURCHASE);
		System.out.println("토탈페이지를 넘기고 있쪄? ==> " + fiterPurchase);
		
        // 페이징 객체 생성
        csg_Paging paging = new csg_Paging(fiterPurchase, csg_TB_PURCHASE.getCurrentPage());
        System.out.println(paging);
        
        csg_TB_PURCHASE.setStart(paging.getStart());//1
        csg_TB_PURCHASE.setEnd(paging.getEnd());//5
        
        System.out.println(" 너 지금 몇개야 12개 있어야 : "+csg_TB_PURCHASE);

        // 검색 조건에 맞는 발주 목록 조회
        List<CSG_TB_PURCHASE> purchaseList = sk_ServicInterface.findAllPurchase(csg_TB_PURCHASE);
        System.out.println("purchaseList.size() =>>"+purchaseList.size());
        // 응답 객체에 페이징 정보와 검색 결과 목록 추가
        response.put("page", paging);
        response.put("items", purchaseList);
        System.out.println("너 지금 몇개니 ? : "+csg_TB_PURCHASE);

        System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@page에 들어가는  paging: "+ paging);
        System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@items에 들어가는  purchaseList: "+ purchaseList);
        System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@response  : "+ response);
        return response;
        
    }

	//CSG_purchase에서 신규등록을 누르면 a태그로 옮기게 되는 발주등록 및 자재목록 나오게 되는 폼 + 업체들 불러오기
	@RequestMapping(value="purchaseItemForm")
	public String Sk_PurchasList(Model model) {
		
		System.out.println("대분류 불러오자");

		// 업체들을 불러오자 
		List<CSG_TB_CUSTMST> cusList = sk_ServicInterface.findCustlist();
		System.out.println("컨트롤러 : 업체들을 잘 불러왔니 ? => "+cusList);
		model.addAttribute("custList", cusList);
		
		return "csg/CSG_purchaseItem2";
	}
	
	//발주업체를 불러오게 되면 ==> 거래처 발주담당자를 불러오기 purchaseItemForm
	@GetMapping("/getPurchaseManager")
	@ResponseBody
	public CSG_TB_PURCHASE getPurchaseManager(@RequestParam("cust_cd") String custCd) {
	    //발주테이블에서 거래처 발주담당자를 가져오자
		System.out.println("발주담당자를 가져오깅 위해서 cust_cd를 잘 받아 왔니?? ==>"+custCd);
		CSG_TB_PURCHASE custEmployee = sk_ServicInterface.findCustEmployeeByCustCd(custCd);
	    return custEmployee;
	}

	
	
	//발주 등록 폼에서 거래처를 불러온 다음에 cust_cd를 통해서 대분류 불러오기
	@ResponseBody
	@GetMapping("modalBig")
	public List<CSG_TB_TYPE_BIG> CSG_BigType(@RequestParam("cust_cd") String custCd,
											 Model model) {
		System.out.println("컨트롤러 : cust_cd를 가져온뒤에 bigType불러오자 custCd : " + custCd);
		//모달 대분류 디비에서 불러오는거 
		List<CSG_TB_TYPE_BIG> bigTypeList = sk_ServicInterface.findBigTypelist(custCd);
		System.out.println("컨트롤러 DB에서 받아온 bigTypeList.size() ==>"+bigTypeList.size());
		//model.addAttribute("bigTypeList", bigTypeList);
		return bigTypeList;
		
	}
	
	//모달 중분류 ajax로 modalCategory.js로 불러오기
	@ResponseBody
	@GetMapping("modalMid")
	public List<CSG_TB_TYPE_MID> CSG_MidType(CSG_TB_TYPE_MID csgMid){
		System.out.println("컨트롤러 ==> 대분류애들 값 가지고 중분류애들 분류해보자");
		System.out.println("컨트롤러 : 야 cust_cd받아왔냐?? csgMid.get.getCust_cd() ====> "+csgMid.getCust_cd());
		System.out.println("컨트롤러 : 야 cust_cd받아왔냐?? csgMid.get.getCust_cd() ====> "+csgMid.getCust_cd());
		List<CSG_TB_TYPE_MID> midTypeList = sk_ServicInterface.CSG_MidType(csgMid);
		System.out.println("컨트롤러에서 받아온 중분류 것 들 midTypeList ===> " + midTypeList);

		return midTypeList;
	}
	
	//모달 소분류 ajax로 modalCategory.js로 불러오기
	@ResponseBody
	@GetMapping("modalSml")
	public List<CSG_TB_TYPE_SML> CSG_SmlType(CSG_TB_TYPE_SML csgSml){
		System.out.println("컨트롤러 ==> 중분류애들 값 가지고 소분류애들 분류해보자");
		System.out.println("컨트롤러 ==> csgSml ==>"+csgSml);
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
	
	//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	//@@@@@@@@@@@@@@@@@@@@@ajax로 바꿔주고 CSG_purchaseItem2.jsp에서 모달을 form으로 감싼 부분을 바꿔서 처리할것 !
	//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	//모달에서 값을 다 불러온다음에 그 모달의 저장을 누르면 여기로 오는건가??
	//purchaseItem2.jsp에서 모달 => 저장버튼 후 => purchaseItem2.jsp로 다시 돌아오는 로직
	/*@RequestMapping(value="modalSaveToTable")
	public String SK_modalSave(/*@RequestBody 객체로 받아주자고 여기는 이제 DB select하면됨) {
		System.out.println("모달에서 자재 선택후에 CSG_purchaseItem2.jsp뷰로 돌아오기");
		return null;
	}*/
	//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

	
	
	//모달까지 완료한 뒤 발주등록 화면에서 저장! ==> 저장한뒤에 발주화면으로 이동
	@PostMapping("/submitOrderDetails")
	public String PurchaseSave(@RequestBody CSG_TB_PURCHASE purchaseAndItem, Model model/*, HttpServletRequest request*/) {
		System.out.println("값 잘 받았냐 purchaseAndItem : purchaseAndItem" + purchaseAndItem);
		System.out.println("발주가 등록되었습니다");
		
		sk_ServicInterface.insertBalju(purchaseAndItem);
		
		return "csg/CSG_purchase"; //ajax라서 이건 없어도 됨 ..
	}

	//발주조회 폼에서 선택한 항목 삭제하기
	@RequestMapping("/deleteSelectedPurchases")
	public String purchaseDelete(@RequestParam("selectedIds") String selectedIds, Model model, CSG_TB_PURCHASE csg_TB_PURCHASE) {
	    System.out.println("선택된 ID들: " + selectedIds);
	    // 선택된 ID를 사용하여 삭제 로직을 수행합니다.
	    sk_ServicInterface.purchaseDelete(selectedIds);

	    return "redirect:/purchase"; // 발주리스트를 보여주는 뷰로 리턴합니다.
	}


}