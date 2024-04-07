package com.aselcni.kdw.dao;

import java.util.List;

import com.aselcni.kdw.model.KDW_TB_ITEMMST;
import com.aselcni.kdw.model.KDW_TB_ORDER;
import com.aselcni.kdw.model.KDW_TB_ORDER_ITEM;
import com.aselcni.kdw.model.KDW_TB_TYPE_BIG;
import com.aselcni.kdw.model.KDW_TB_TYPE_MID;
import com.aselcni.kdw.model.KDW_TB_TYPE_SML;
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

}
