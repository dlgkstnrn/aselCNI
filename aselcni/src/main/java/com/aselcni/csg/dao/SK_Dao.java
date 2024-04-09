package com.aselcni.csg.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.aselcni.csg.model.CSG_TB_CUSTMST;
import com.aselcni.csg.model.CSG_TB_ITEMMST;
import com.aselcni.csg.model.CSG_TB_PURCHASE;
import com.aselcni.csg.model.CSG_TB_TYPE_BIG;
import com.aselcni.csg.model.CSG_TB_TYPE_MID;
import com.aselcni.csg.model.CSG_TB_TYPE_SML;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class SK_Dao implements SK_Dao_Interface {
	
	private final SqlSession session;
	
	//첫 발주화면이 나타날때 발주리스트를 불러와보자고 + 조건 검색할때도 여기로 오게 됨
	@Override
	public List<CSG_TB_PURCHASE> findAllPurchase(CSG_TB_PURCHASE csg_TB_PURCHASE) {
		List<CSG_TB_PURCHASE> purchaseList = null;
		System.out.println("@!@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"+csg_TB_PURCHASE);
		try {
		//발주리스트 불러오기 + pageing작업까지
		purchaseList = session.selectList("SK_findAllPurchase",csg_TB_PURCHASE);
		System.out.println("DAO + DB : 확실히 purchaseList를 잘 가져온거니??==>"+purchaseList);
		} catch (Exception e) {
			System.out.println("왜 또 오류가 쳐 나는거야.. + e 나 먹어라"+e);
		}
		
		return purchaseList;
	}
	
	//paging작업을 위해 전체 발주 개수 가져오기 
	@Override
	public int totalPurchase() {
		System.out.println("DAO : 전체발주 개수 가져오기 paging 사전작업");
		int totalPurchase = 0;
		
		try {
		totalPurchase = session.selectOne("SK_PagingtotalPurchase");
		System.out.println("전체 페이징 개수는 잘 가져왔니? totalPurchase => "+ totalPurchase);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return totalPurchase;
	}


	

	//모달의 대분류 카테고리들 만들기
	@Override
	public List<CSG_TB_TYPE_BIG> findBigTypelist(String custCd) {
		System.out.println("dao에서 bigType을 불러오자고");
		
		List<CSG_TB_TYPE_BIG> bigTypeList = session.selectList("SK_bigTypeList", custCd);
		System.out.println("DB에서 불러오게 된 bigTypeList ==>"+bigTypeList);
		
		return bigTypeList;
	}

	//모달의 중분류 카테고리들 만들기
	@Override
	public List<CSG_TB_TYPE_MID> CSG_MidType(CSG_TB_TYPE_MID csgMid) {
		
		List<CSG_TB_TYPE_MID> midTypeList = null;
		System.out.println(csgMid.getBig_no());
		try {
			midTypeList = session.selectList("SK_MidTypeList", csgMid);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return midTypeList;
	}
	
	//모달의 소분류 카테고리들 만들기
	@Override
	public List<CSG_TB_TYPE_SML> CSG_SmlType(CSG_TB_TYPE_SML csgSml) {
		
		List<CSG_TB_TYPE_SML> smlTypeList = null;
		System.out.println("2가 나오는게 너냐?"+csgSml.getBig_no());
		try {
			smlTypeList = session.selectList("SK_smlTypeList", csgSml);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return smlTypeList;
	}

	//모달에서 대중소분류 선택 후에 선택된 아이템리스트들 가져오기
	@Override
	public List<CSG_TB_ITEMMST> CSG_SelectedItems(CSG_TB_TYPE_SML items) {
		System.out.println("dao에서 모달에서 선택된 아이템 리스트 DB로 보내기전 items @@@@@====>"+items);
		
		List<CSG_TB_ITEMMST> selectedItemList = null;
		try {
			selectedItemList = session.selectList("SK_selectedItemsList", items);
			System.out.println("아이템리스트들을 잘 불러왔니?? selectedItemList==>"+selectedItemList);
		}catch (Exception e) {
			System.out.println(selectedItemList);
		}
		
		System.out.println("dao에서 모달에서 선택된 아이템 리스트 DB에서 가져왔니?? ----->");

		return selectedItemList;
	}

	//발주등록폼에서 업체리스트 가져오기
	@Override
	public List<CSG_TB_CUSTMST> findCustlist() {
		System.out.println("발주 등록폼에서 처음에 업체들 미리 불러오기..");
		
		List<CSG_TB_CUSTMST> csgCustlist = null;
		try {
			csgCustlist = session.selectList("SK_custList");
			System.out.println("csgCustlist를 잘 불러온거니 ??"+csgCustlist);
		}catch (Exception e) {
			System.out.println(e);
		}
		
		return csgCustlist;
	}
	
	//선택된 발주업체 ==> 발주담당자(거래처) 가져오기 위한 ajax마지막 다오
	@Override
	public CSG_TB_PURCHASE findCustEmployeeByCustCd(String custCd) {
		System.out.println("Dao : ajax를 통해서 선택된 발주업체에서 발주담당자를 가져오자 custCd ==> "+custCd);
		CSG_TB_PURCHASE custEmployee = null;
		try {
		custEmployee = session.selectOne("SK_findCustEmpByCustCd",custCd);
	    System.out.println("DB에서 거래처 발주담당자 잘 가져왔냐 @@@@@@@@@@@@@@@@@@@@@@@@ ==> "+ custEmployee);
		}catch (Exception e) {
			System.out.println("오류가 발생하였습니다 ==> " + e);
		}
		
		return custEmployee;
		
	}



	

}
