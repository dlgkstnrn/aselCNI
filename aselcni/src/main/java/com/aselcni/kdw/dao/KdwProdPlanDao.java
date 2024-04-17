package com.aselcni.kdw.dao;

import java.util.List;

import com.aselcni.kdw.model.KDW_TB_ITEMMST;
import com.aselcni.kdw.model.KDW_TB_ORDER;
import com.aselcni.kdw.model.KDW_TB_ORDER_ITEM;
import com.aselcni.kdw.model.KDW_TB_TYPE_BIG;
import com.aselcni.kdw.model.KDW_TB_TYPE_MID;
import com.aselcni.kdw.model.KDW_TB_TYPE_SML;
import com.aselcni.kdw.model.ProdPlanDataUpdate.Material;
import com.aselcni.kdw.model.TB_ITEM_PROD;
import com.aselcni.kdw.model.TB_PRODPLAN;

public interface KdwProdPlanDao {
	// 생산계획 제품리스트
	List<TB_PRODPLAN> getProdPlanList();
	// 생산계획 자재리스트
	List<TB_ITEM_PROD> getProdPlanItemList();
	// 주문번호 리스트
	List<KDW_TB_ORDER> getprodPlanOrderList();
	// 주문번호 제품 리스트
	List<KDW_TB_ORDER_ITEM> getprodPlanOrderItemList();
	
	// 제품, 자재 대중소 카테고리리스트
	List<KDW_TB_TYPE_BIG> getProdPlanItemTypeBigList();
	List<KDW_TB_TYPE_MID> getProdPlanItemTypeMidList();
	List<KDW_TB_TYPE_SML> getProdPlanItemTypeSmlList();
	// 대중소 분류된 제품리스트
	List<KDW_TB_ITEMMST> getItemCategoriesSearchList(int bigNo, int midNo, int smlNo);
	// 생산계획등록 제품
	String saveProdPlan(TB_PRODPLAN tbProdPlan, String prodplan_emp_id);
	// 생산계획등록 자재
	void saveItemProd(TB_ITEM_PROD tbItemProd);
	
	// 생산계획수정(투입자재 수량도 추가)
	void updateProdPlan(TB_PRODPLAN updatedProdPlan);
	// 생산계획수정(새 투입자재추가(insert))
	void updateItemProd(TB_ITEM_PROD updateItemProd);
	// 생산계획수정(기존 투입자재 개수 수정시(update))
	void updateItemProdQuantity(TB_ITEM_PROD updateItemProd);
	// 생산계획수정(기존 투입자재수정시(delete))
	void deleteItemProd(TB_ITEM_PROD deleteItemProd);
	// 생산계획삭제: prodPlan_delete_chk 값을 1로 설정
	void updateProdPlanDeleteChk(String prodPlanNo);
	
	// 투입자재 기존자재인지 신규인지 판단
	boolean checkMaterialExists(String prodPlanNo, String itemCd);
	

}
