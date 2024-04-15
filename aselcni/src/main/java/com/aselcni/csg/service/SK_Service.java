package com.aselcni.csg.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.aselcni.csg.dao.SK_Dao_Interface;
import com.aselcni.csg.model.CSG_TB_CUSTMST;
import com.aselcni.csg.model.CSG_TB_ITEMMST;
import com.aselcni.csg.model.CSG_TB_PURCHASE;
import com.aselcni.csg.model.CSG_TB_PURCHASE_ITEM;
import com.aselcni.csg.model.CSG_TB_TYPE_BIG;
import com.aselcni.csg.model.CSG_TB_TYPE_MID;
import com.aselcni.csg.model.CSG_TB_TYPE_SML;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class SK_Service implements SK_Service_Interface {
	
	private final SK_Dao_Interface sk_Dao_Interface;

	//네비바 => 발주화면 클릭
	//첫 발주화면에서 발주리스트를 가져오자 //+ 조건 검색할때도 여기로 오게됨
	@Override
	public List<CSG_TB_PURCHASE> findAllPurchase(CSG_TB_PURCHASE csg_TB_PURCHASE) {
		List<CSG_TB_PURCHASE> purchaseList = sk_Dao_Interface.findAllPurchase(csg_TB_PURCHASE);
		System.out.println("Service : 발주리스트 잘 가져왔냐 ?? + paging 된거니?? + purchaseList ==>"+purchaseList);
		
		return purchaseList;
	}
	

	//발주관리 화면 페이징 하기위해서 전체 발주 개수 가져오기
	@Override
	public int totalPurchase(CSG_TB_PURCHASE csg_TB_PURCHASE) {
		System.out.println("service : 전체발주 개수 가져오기 paging 사전작업");
		int totalPurchase = 0;
		totalPurchase = sk_Dao_Interface.totalPurchase(csg_TB_PURCHASE);
		System.out.println("service : 전체 페이징 개수는 잘 가져왔니? totalPurchase => "+ totalPurchase);
		
		return totalPurchase;
	}


	
	
	//첫 발주등록 폼에서 보이는 대분류 불러오기(모달안에 미리 불러오는거)
	@Override
	public List<CSG_TB_TYPE_BIG> findBigTypelist(String custCd) {
		System.out.println("Service에서 bigType을 불러오자고");
		List<CSG_TB_TYPE_BIG> bigTypeList = sk_Dao_Interface.findBigTypelist(custCd);
		return bigTypeList;
	}

	//발주 등록 폼에서 업체들 드랍다운박스에 불러오기
	@Override
	public List<CSG_TB_CUSTMST> findCustlist() {
		List<CSG_TB_CUSTMST> custList = sk_Dao_Interface.findCustlist();
		return custList;
	}
	
	
	//ajax(modalCategory) 대분류-> 중분류 불러오기
	@Override
	public List<CSG_TB_TYPE_MID> CSG_MidType(CSG_TB_TYPE_MID csgMid) {
		System.out.println("service에서 대분류 선택하고 중분류 애들 골라보자");
		List<CSG_TB_TYPE_MID> midTypeList = sk_Dao_Interface.CSG_MidType(csgMid);
		
		return midTypeList;
	}
	

	//ajax로 받아온 (대분류-중분류) -> 소분류 불러오기
	@Override
	public List<CSG_TB_TYPE_SML> CSG_SmlType(CSG_TB_TYPE_SML csgSml) {
		System.out.println("service에서 중분류 선택하고 소분류 애들 골라보자");
		List<CSG_TB_TYPE_SML> smlTypeList = sk_Dao_Interface.CSG_SmlType(csgSml);

		return smlTypeList;
	}

	//대중소분류 선택된 아이템들 가져오기
	@Override
	public List<CSG_TB_ITEMMST> CSG_SelectedItems(CSG_TB_TYPE_SML items) {
		System.out.println("서비스에서 모달에서 대중소분류 선택된 아이템테이블 가져와보자");
		List<CSG_TB_ITEMMST> selectedItemList = sk_Dao_Interface.CSG_SelectedItems(items);
		
		//System.out.println("서비스에서 모달에서 대중소분류 선택된 itemsList DB에서 가져온것들===>"+selectedItemList);

		return selectedItemList;
	}

	//발주업체가 선택된 다음에 발주 담당자를 가져오자
	@Override
	public CSG_TB_PURCHASE findCustEmployeeByCustCd(String custCd) {
		System.out.println("service : 발주담당자를 가져오자고");
		CSG_TB_PURCHASE custEmployee = sk_Dao_Interface.findCustEmployeeByCustCd(custCd);
	    return custEmployee;
	}

	
	//발주등록 =>  분리 및 트렌지션관리
	@Override
	@Transactional
	public void insertBalju(CSG_TB_PURCHASE purchaseAndItem) {
	    if (purchaseAndItem == null) return;
	    
	    String purc_no = sk_Dao_Interface.inserForPurchaseToPurcNo();  // 발주번호 생성
	    purchaseAndItem.setPurc_no(purc_no);

	    sk_Dao_Interface.insertPurchase(purchaseAndItem);  // 발주 정보 삽입

	    if (purchaseAndItem.getCsgPurItemList() != null) {
	        for (CSG_TB_PURCHASE_ITEM item : purchaseAndItem.getCsgPurItemList()) {
	            item.setPurc_no(purc_no);  // 각 아이템에 발주번호 설정
	            sk_Dao_Interface.insertPurchaseItem(item);  // 아이템 정보 삽입
	        }
	    }
	}

	//deletefalg를 update해보자 
	
    public void updatePurchaseDeleteFlags(String selectedIds) {

    }


	@Override
	@Transactional
	//발주관리 체크박스 선택 => 삭제 
	public void purchaseDelete(String selectedIds) {
        // 선택된 ID들을 ','를 기준으로 분할하여 배열로 저장합니다.
        String[] idArray = selectedIds.split(",");
        
      //update => id로 purchase_tbl에서 조회. 있는 경우에만 update로 바꿔주자.
        for (String id : idArray) {
            // 발주 항목을 조회하는 메서드 호출
        	List<CSG_TB_PURCHASE> purchase = sk_Dao_Interface.findById(id);
            
            // 조회된 발주 항목의 삭제 플래그를 설정하는 메서드 호출
            if (purchase != null) {
                sk_Dao_Interface.updateDeleteFlagById(id);
            }
        }
	}








}
