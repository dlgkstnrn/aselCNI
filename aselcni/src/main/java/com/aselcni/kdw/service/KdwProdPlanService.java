package com.aselcni.kdw.service;

import java.util.List;

import com.aselcni.kdw.model.KDW_TB_ORDER;
import com.aselcni.kdw.model.KDW_TB_ORDER_ITEM;
import com.aselcni.kdw.model.TB_ITEM_PROD;
import com.aselcni.kdw.model.TB_PRODPLAN;

public interface KdwProdPlanService {
	// 생산계획 제품리스트
	List<TB_PRODPLAN> getProdPlanList();
	// 생산계획 자재리스트
	List<TB_ITEM_PROD> getProdItemList();
	// 주문번호 리스트 
	List<KDW_TB_ORDER> getProdOrderList();
	// 주문번호 제품 리스트
	List<KDW_TB_ORDER_ITEM> getProdOrderItemList();

}
