package com.aselcni.kdw.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.aselcni.kdw.model.KDW_TB_ITEMMST;
import com.aselcni.kdw.model.KDW_TB_ORDER;
import com.aselcni.kdw.model.KDW_TB_ORDER_ITEM;
import com.aselcni.kdw.model.KDW_TB_TYPE_BIG;
import com.aselcni.kdw.model.KDW_TB_TYPE_MID;
import com.aselcni.kdw.model.KDW_TB_TYPE_SML;
import com.aselcni.kdw.model.ProdPlanDataUpdate.Material;
import com.aselcni.kdw.model.TB_ITEM_PROD;
import com.aselcni.kdw.model.TB_PRODPLAN;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Repository
@RequiredArgsConstructor
@Slf4j
public class KdwProdPlanDaoImpl implements KdwProdPlanDao {

	private final SqlSession session;

	// 생산계획 제품리스트
	@Override
	public List<TB_PRODPLAN> getProdPlanList() {
		System.out.println("KdwProdPlanDaoImpl getProdPlanList Start...");
		List<TB_PRODPLAN> prodPlanList = null;
		try {
			prodPlanList = session.selectList("kdwProdPlanList");
			System.out.println("KdwProdPlanDaoImpl getProdPlanList prodPlanList.size(): " + prodPlanList.size());
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("KdwProdPlanDaoImpl getProdPlanList e.getMessage(): " + e.getMessage());
		}
		return prodPlanList;
	}
	// 생산계획 투입자재리스트
	@Override
	public List<TB_ITEM_PROD> getProdPlanItemList() {
		System.out.println("KdwProdPlanDaoImpl getProdPlanItemList Start...");
		List<TB_ITEM_PROD> prodPlanItemList = null;
		try {
			prodPlanItemList = session.selectList("kdwProdPlanItemList");
			System.out.println(
					"KdwProdPlanDaoImpl getProdPlanItemList prodPlanItemList.size(): " + prodPlanItemList.size());
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("KdwProdPlanDaoImpl getProdPlanItemList e.getMessage(): " + e.getMessage());
		}
		return prodPlanItemList;
	}

	// 주문번호 리스트
	@Override
	public List<KDW_TB_ORDER> getprodPlanOrderList() {
		System.out.println("KdwProdPlanDaoImpl getprodPlanOrderList Start...");
		List<KDW_TB_ORDER> prodPlanOrderList = null;
		try {
			prodPlanOrderList = session.selectList("kdwProdPlanOrderList");
			System.out.println(
					"KdwProdPlanDaoImpl getprodPlanOrderList prodPlanOrderList.size(): " + prodPlanOrderList.size());
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("KdwProdPlanDaoImpl getprodPlanOrderList e.getMessage(): " + e.getMessage());
		}
		return prodPlanOrderList;
	}
	// 주문번호 제품 리스트
	@Override
	public List<KDW_TB_ORDER_ITEM> getprodPlanOrderItemList() {
		System.out.println("KdwProdPlanDaoImpl getprodPlanOrderItemList Start...");
		List<KDW_TB_ORDER_ITEM> prodPlanOrderItemList = null;
		try {
			prodPlanOrderItemList = session.selectList("kdwProdPlanOrderItemList");
			System.out.println(
					"KdwProdPlanDaoImpl getprodPlanOrderItemList prodPlanOrderItemList.size(): " + prodPlanOrderItemList.size());
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("KdwProdPlanDaoImpl getprodPlanOrderItemList e.getMessage(): " + e.getMessage());
		}
		return prodPlanOrderItemList;
	}
	
	// 제품, 자재 대중소 카테고리리스트
	@Override
	public List<KDW_TB_TYPE_BIG> getProdPlanItemTypeBigList() {
		System.out.println("KdwProdPlanDaoImpl getProdPlanItemTypeBigList Start...");
		List<KDW_TB_TYPE_BIG> prodPlanItemTypeBigList = null;
		try {
			prodPlanItemTypeBigList = session.selectList("kdwProdPlanItemTypeBigList");
			System.out.println("KdwProdPlanDaoImpl getProdPlanItemTypeBigList prodPlanItemTypeBigList.size(): " + prodPlanItemTypeBigList.size());
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("KdwProdPlanDaoImpl getProdPlanItemTypeBigList e.getMessage(): " + e.getMessage());
		}
		return prodPlanItemTypeBigList;
	}
	@Override
	public List<KDW_TB_TYPE_MID> getProdPlanItemTypeMidList() {
		System.out.println("KdwProdPlanDaoImpl getProdPlanItemTypeMidList Start...");
		List<KDW_TB_TYPE_MID> prodPlanItemTypeMidList = null;
		try {
			prodPlanItemTypeMidList = session.selectList("kdwProdPlanItemTypeMidList");
			System.out.println("KdwProdPlanDaoImpl getprodPlanOrderItemList prodPlanItemTypeMidList.size(): " + prodPlanItemTypeMidList.size());
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("KdwProdPlanDaoImpl getprodPlanOrderItemList e.getMessage(): " + e.getMessage());
		}
		return prodPlanItemTypeMidList;
	}
	@Override
	public List<KDW_TB_TYPE_SML> getProdPlanItemTypeSmlList() {
		System.out.println("KdwProdPlanDaoImpl getProdPlanItemTypeSmlList Start...");
		List<KDW_TB_TYPE_SML> prodPlanItemTypeSmlList = null;
		try {
			prodPlanItemTypeSmlList = session.selectList("kdwProdPlanItemTypeSmlList");
			System.out.println("KdwProdPlanDaoImpl getProdPlanItemTypeSmlList prodPlanItemTypeSmlList.size(): " + prodPlanItemTypeSmlList.size());
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("KdwProdPlanDaoImpl getProdPlanItemTypeSmlList e.getMessage(): " + e.getMessage());
		}
		return prodPlanItemTypeSmlList;
	}
	// 대중소 분류된 제품리스트
	@Override
	public List<KDW_TB_ITEMMST> getItemCategoriesSearchList(int bigNo, int midNo, int smlNo) {
	    System.out.println("KdwProdPlanDaoImpl getItemCategoriesSearchList Start...");
	    List<KDW_TB_ITEMMST> prodItemCategoriesSearchList = null;
	    try {
	        Map<String, Object> params = new HashMap<>();
	        params.put("bigNo", bigNo);
	        params.put("midNo", midNo);
	        params.put("smlNo", smlNo);
	        prodItemCategoriesSearchList = session.selectList("kdwProdItemCategoriesSearchList", params);
	        System.out.println("KdwProdPlanDaoImpl getItemCategoriesSearchList prodItemCategoriesSearchList.size(): " + prodItemCategoriesSearchList.size());
	    } catch (Exception e) {
	        e.printStackTrace();
	        System.out.println("KdwProdPlanDaoImpl getItemCategoriesSearchList e.getMessage(): " + e.getMessage());
	    }
	    return prodItemCategoriesSearchList;
	}
	// 생산계획등록 제품
	@Override
	public String saveProdPlan(TB_PRODPLAN tbProdPlan, String prodplan_emp_id) {
	    System.out.println("KdwProdPlanDaoImpl saveProdPlan Start...");
	    String prodPlanNo = null; // prodPlan_no를 저장할 변수 (투입자재, 주문상태에 사용)
	    Integer seqNo = null; // seq_no를 저장할 변수(등록할 때 seq_no가 1인걸 가져와서 주문상태 수정해야함)
	    try {
	        Map<String, Object> params = new HashMap<>();
	        params.put("order_no", tbProdPlan.getOrder_no());
	        // SEQ_NO 생성
	        seqNo = session.selectOne("kdwGenerateSeqNo", params);
	        tbProdPlan.setSeq_no(seqNo);
	        // PRODPLAN_NO 생성
	        prodPlanNo = session.selectOne("kdwGenerateProdPlanNo", params);
	        tbProdPlan.setProdPlan_no(prodPlanNo);

	        // 기타 필요한 매개변수 설정
	        params.put("prodplan_emp_id", prodplan_emp_id);
	        params.put("tbProdPlan", tbProdPlan);

	        // 생산계획 등록
	        session.insert("kdwSaveProdPlan", params);
	        
	        // SEQ_NO가 1인 경우 주문 상태 업데이트
	        if (seqNo == 1) {
	            session.update("kdwUpdateOrderStatus", params);
	        }
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	        System.out.println("Error during saving production plan: " + e.getMessage());
	    }
	    return prodPlanNo; // 생성된 prodPlan_no를 반환
	}
	
	// 생산계획등록 자재
	@Override
	public void saveItemProd(TB_ITEM_PROD tbItemProd) {
		System.out.println("KdwProdPlanDaoImpl saveItemProd Start...");
		System.out.println("KdwProdPlanDaoImpl saveItemProd 등록 투입자재: " + tbItemProd.toString());
	    try {
	        session.insert("kdwSaveItemProd", tbItemProd);
	        System.out.println("KdwProdPlanDaoImpl tbItemProd: " + tbItemProd);
	    } catch (Exception e) {
	        e.printStackTrace();
	        System.out.println("KdwProdPlanDaoImpl saveItemProd Error: " + e.getMessage());
	    }
	}
	
	
	// 생산계획수정
	@Override
	public void updateProdPlan(TB_PRODPLAN updatedProdPlan) {
	    System.out.println("KdwProdPlanDaoImpl updateProdPlan Start...");
	    System.out.println("Updating with: " + updatedProdPlan.toString());
	    try {
	        int updateCount = session.update("kdwUpdateProdPlan", updatedProdPlan);
	        System.out.println("KdwProdPlanDaoImpl updateProdPlan 생산계획 수정 수: " + updateCount);
	    } catch (Exception e) {
	        e.printStackTrace();
	        System.out.println("KdwProdPlanDaoImpl updateProdPlan 수정중 오류 발생: " + e.getMessage());
	    }
	}
	
	// 생산계획수정(새 투입자재추가(insert))
	@Override
	public void updateItemProd(TB_ITEM_PROD updateItemProd) {
	    System.out.println("KdwProdPlanDaoImpl updateItemProd Start...");
	    System.out.println("Updating with: " + updateItemProd.toString());
	    try {
	        session.insert("kdwSaveItemProd", updateItemProd);
	        System.out.println("KdwProdPlanDaoImpl updateItemProd 신규 투입자재 추가: " + updateItemProd);
	    } catch (Exception e) {
	        e.printStackTrace();
	        System.out.println("KdwProdPlanDaoImpl updateItemProd 신규 투입자재 추가 오류: " + e.getMessage());
	    }
	}
	
	// 생산계획수정(기존 투입자재 개수 수정시(update))
	@Override
	public void updateItemProdQuantity(TB_ITEM_PROD updateItemProd) {
	    System.out.println("KdwProdPlanDaoImpl updateItemProdQuantity Start...");
	    System.out.println("Updating with updateItemProdQuantity: " + updateItemProd.toString());
	    try {
	    	session.update("kdwUpdateItemProdQuantity", updateItemProd);
	        // 자재 업데이트 후 생산계획의 prodPlan_update 필드를 현재 날짜로 업데이트
	        session.update("kdwUpdateProdPlanUpdateDate", updateItemProd.getProdPlan_no());
	        System.out.println("KdwProdPlanDaoImpl updateItemProdQuantity 기존 투입자재 개수 수정: " + updateItemProd);
	    } catch (Exception e) {
	        e.printStackTrace();
	        System.out.println("KdwProdPlanDaoImpl updateItemProdQuantity 기존 투입자재 개수 수정 오류: " + e.getMessage());
	    }
	}
	
	// 생산계획수정(기존 투입자재수정시(delete))
	@Override
	public void deleteItemProd(TB_ITEM_PROD deleteItemProd) {
	    System.out.println("KdwProdPlanDaoImpl deleteItemProd Start...");
	    System.out.println("Updating with: " + deleteItemProd.toString());
	    try {
	        int deleteCount = session.delete("kdwDeleteItemProd", deleteItemProd);
	        System.out.println("KdwProdPlanDaoImpl deleteItemProd 기존 투입자재 삭제 수: " + deleteCount);
	    } catch (Exception e) {
	        e.printStackTrace();
	        System.out.println("KdwProdPlanDaoImpl deleteItemProd 기존 투입자재 오류: " + e.getMessage());
	    }
	}
	// 투입자재 기존자재인지 신규인지 판단
	@Override
	public boolean checkMaterialExists(String prodPlanNo, String itemCd) {
		System.out.println("KdwProdPlanDaoImpl checkMaterialExists Start...");
	    Map<String, Object> params = new HashMap<>();
	    params.put("prodPlan_no", prodPlanNo);
	    params.put("item_cd", itemCd);
	    int count = session.selectOne("checkMaterialExists", params);
	    System.out.println("KdwProdPlanDaoImpl checkMaterialExists 기존자재 개수: " + count);
	    return count > 0;
	}
	
	// 생산계획삭제: prodPlan_delete_chk 값을 1로 설정
	@Override
	public void updateProdPlanDeleteChk(String prodPlanNo) {
	    System.out.println("KdwProdPlanDaoImpl updateProdPlanDeleteChk Start...");
	    System.out.println("KdwProdPlanDaoImpl updateProdPlanDeleteChk prodPlanNo: " + prodPlanNo);
	    try {
	        int updateDeleteChkCount = session.update("kdwUpdateProdPlanDeleteChk", prodPlanNo);
	        System.out.println("KdwProdPlanDaoImpl updateProdPlanDeleteChk 생산계획 삭제 수: " + updateDeleteChkCount);
	    } catch (Exception e) {
	        e.printStackTrace();
	        System.out.println("KdwProdPlanDaoImpl updateProdPlanDeleteChk 생산계획 삭제중 오류: " + e.getMessage());
	    }
	}
}
