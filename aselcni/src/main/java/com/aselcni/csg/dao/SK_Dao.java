package com.aselcni.csg.dao;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.aselcni.csg.model.CSG_TB_CUSTMST;
import com.aselcni.csg.model.CSG_TB_ITEMMST;
import com.aselcni.csg.model.CSG_TB_PURCHASE;
import com.aselcni.csg.model.CSG_TB_PURCHASE_ITEM;
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
			System.out.println("왜 또 오류가 나는거야.. + e 나 먹어라"+e);
		}
		
		return purchaseList;
	}
	
	//paging작업을 위해 전체 발주 개수 가져오기 
	@Override
	public int totalPurchase(CSG_TB_PURCHASE csg_TB_PURCHASE) {
		System.out.println("DAO : 전체발주 개수 가져오기 paging 사전작업");
		int totalPurchase = 0;
		
		try {
		totalPurchase = session.selectOne("SK_PagingtotalPurchase", csg_TB_PURCHASE);
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
		System.out.println("2가 나오는게 너니?"+csgSml.getBig_no());
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

	
	//purch_no를 만들자. 
	@Override
	public String inserForPurchaseToPurcNo() {
	    String datePart = new SimpleDateFormat("yyMMdd").format(new Date());
	    String prefix = "PUR" + datePart;
	    String maxPurcNo = session.selectOne("SK_purchaseMaxForPurcNo", prefix + "%");
	    int nextNum = (maxPurcNo == null) ? 1 : Integer.parseInt(maxPurcNo.substring(maxPurcNo.length() - 4)) + 1;
	    return String.format("%s%04d", prefix, nextNum);
	}
	
	//2번째 ISNERT 트렌지션 ==> PURCHASE테이블에 넣어주자
	@Override
	public void insertPurchase(CSG_TB_PURCHASE purchaseAndItem) {
		System.out.println("inserForPurchaseToPurcNo에서 만들어진 purc_no로 purchase테이블에 먼저 넣어주자 트렌지션관리 2번");
		
		int result = 0;
		try {
			result = session.insert("SK_insertPurchaseTBl", purchaseAndItem);
			System.out.println("제발 1로 대답해주겠니 result ==> "+ result);
		} catch (Exception e) {
			System.out.println("insert가 잘 된거니?? e => "+e);
		}
		
		
	}
	
	//3번째 ISNERT 트렌지션 ==> PURCHASE_Item테이블에 넣어주자
	@Override
	public void insertPurchaseItem(CSG_TB_PURCHASE_ITEM item) {
	    int exists = session.selectOne("checkPurchaseItemExists", item);
	    if (exists == 0) {
	        int result = session.insert("SK_insertPurchaseItemTBl", item);
	        System.out.println("Insert result for PURCHASE_ITEM: " + result);
	    } else {
	        System.out.println("Skipping insert: Item already exists with PURC_NO: " + item.getPurc_no() + " and ITEM_CD: " + item.getItem_cd());
	    }
	}

	//update를 위한 select
	@Override
	public List<CSG_TB_PURCHASE> findById(String purc_no) {
		System.out.println("발주삭제를 위해서 id로 발주를 한번 찾아보자고 + id들"+purc_no);
		List<CSG_TB_PURCHASE> csg_TB_PURCHASE = null;
		try {
			csg_TB_PURCHASE = session.selectList("sk_findByupdate", purc_no);
		} catch (Exception e) {
			System.out.println(e);
		}
		return csg_TB_PURCHASE;
	}

	//select를 한 결과를 update purc_delete_chk
	@Override
	public void updateDeleteFlagById(String purc_no) {
		System.out.println("update로 deleteFlag를 바꿔주자고");
		try {
			session.update("sk_UpdateForDelete", purc_no);
			System.out.println("삭제가 완료되었습니다.");
		} catch(Exception e) {
			System.out.println("업데이트는 된거냐"+e);
		}		
	}






	

}
