package com.aselcni.kdw.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.aselcni.kdw.dao.KdwProdPlanDao;
import com.aselcni.kdw.model.KDW_TB_ITEMMST;
import com.aselcni.kdw.model.KDW_TB_ORDER;
import com.aselcni.kdw.model.KDW_TB_ORDER_ITEM;
import com.aselcni.kdw.model.KDW_TB_TYPE_BIG;
import com.aselcni.kdw.model.KDW_TB_TYPE_MID;
import com.aselcni.kdw.model.KDW_TB_TYPE_SML;
import com.aselcni.kdw.model.ProdPlanData;
import com.aselcni.kdw.model.ProdPlanData.MaterialInfo;
import com.aselcni.kdw.model.TB_ITEM_PROD;
import com.aselcni.kdw.model.TB_PRODPLAN;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Transactional
@Slf4j
public class KdwProdPlanServiceImpl implements KdwProdPlanService {
	
	private final KdwProdPlanDao kdwProdPlanDao;
	
	@Override
	// 생산계획 제품리스트
	public List<TB_PRODPLAN> getProdPlanList() {
		System.out.println("KdwProdPlanServiceImpl getProdPlanList Start...");
		List<TB_PRODPLAN> prodPlanList = kdwProdPlanDao.getProdPlanList();
		System.out.println("KdwProdPlanServiceImpl getProdPlanList prodPlanList.size(): " + prodPlanList.size());
		return prodPlanList;
	}
	// 생산계획 자재리스트
	@Override
	public List<TB_ITEM_PROD> getProdItemList() {
		System.out.println("KdwProdPlanServiceImpl getProdItemList Start...");
		List<TB_ITEM_PROD> prodPlanItemList = kdwProdPlanDao.getProdPlanItemList();
		System.out.println("KdwProdPlanServiceImpl getProdItemList prodPlanItemList.size(): " + prodPlanItemList.size());
		return prodPlanItemList;
	}
	// 주문번호 리스트
	@Override
	public List<KDW_TB_ORDER> getProdOrderList() {
		System.out.println("KdwProdPlanServiceImpl getProdOrderList Start...");
		List<KDW_TB_ORDER> prodPlanOrderList = kdwProdPlanDao.getprodPlanOrderList();
		System.out.println("KdwProdPlanServiceImpl getProdOrderList prodPlanOrderList.size(): " + prodPlanOrderList.size());
		return prodPlanOrderList;
	}
	// 주문번호 제품 리스트
	@Override
	public List<KDW_TB_ORDER_ITEM> getProdOrderItemList() {
		System.out.println("KdwProdPlanServiceImpl getProdOrderItemList Start...");
		List<KDW_TB_ORDER_ITEM> prodPlanOrderItemList = kdwProdPlanDao.getprodPlanOrderItemList();
		System.out.println("KdwProdPlanServiceImpl getProdOrderItemList prodPlanOrderItemList.size(): " + prodPlanOrderItemList.size());
		return prodPlanOrderItemList;
	}
	// 제품, 자재 대중소 카테고리리스트
	@Override
	public List<KDW_TB_TYPE_BIG> getProdPlanItemTypeBigList() {
		System.out.println("KdwProdPlanServiceImpl getProdPlanItemTypeBigList Start...");
		List<KDW_TB_TYPE_BIG> prodPlanItemTypeBigList = kdwProdPlanDao.getProdPlanItemTypeBigList();
		System.out.println("KdwProdPlanServiceImpl getProdPlanItemTypeBigList prodPlanItemTypeBigList.size(): " + prodPlanItemTypeBigList.size());
		return prodPlanItemTypeBigList;
	}
	@Override
	public List<KDW_TB_TYPE_MID> getProdPlanItemTypeMidList() {
		System.out.println("KdwProdPlanServiceImpl getProdPlanItemTypeMidList Start...");
		List<KDW_TB_TYPE_MID> prodPlanItemTypeMidList = kdwProdPlanDao.getProdPlanItemTypeMidList();
		System.out.println("KdwProdPlanServiceImpl getProdPlanItemTypeMidList prodPlanItemTypeMidList.size(): " + prodPlanItemTypeMidList.size());
		return prodPlanItemTypeMidList;
	}
	@Override
	public List<KDW_TB_TYPE_SML> getProdPlanItemTypeSmlList() {
		System.out.println("KdwProdPlanServiceImpl getProdPlanItemTypeSmlList Start...");
		List<KDW_TB_TYPE_SML> prodPlanItemTypeSmlList = kdwProdPlanDao.getProdPlanItemTypeSmlList();
		System.out.println("KdwProdPlanServiceImpl getProdPlanItemTypeSmlList prodPlanItemTypeSmlList.size(): " + prodPlanItemTypeSmlList.size());
		return prodPlanItemTypeSmlList;
	}
	// 대중소 분류된 제품리스트 
	@Override
	public List<KDW_TB_ITEMMST> getItemCategoriesSearchList(int bigNo, int midNo, int smlNo) {
		System.out.println("KdwProdPlanServiceImpl getItemCategoriesSearchList Start...");
		List<KDW_TB_ITEMMST> prodItemCategoriesSearchList = kdwProdPlanDao.getItemCategoriesSearchList(bigNo, midNo, smlNo);
		System.out.println("KdwProdPlanServiceImpl getItemCategoriesSearchList prodItemCategoriesSearchList.size(): " + prodItemCategoriesSearchList.size());
		return prodItemCategoriesSearchList;
	}
	
	// 생산계획등록 제품
	@Override
	public void saveProdPlanAndItems(ProdPlanData prodPlanData, String prodplan_emp_id) {
	    // TB_PRODPLAN 객체 설정
	    TB_PRODPLAN tbProdPlan = new TB_PRODPLAN();
	    tbProdPlan.setOrder_no(prodPlanData.getOrderNo());
	    tbProdPlan.setWork_dt(prodPlanData.getWorkDays());
	    tbProdPlan.setProdPlan_dt(prodPlanData.getStartDate());
	    tbProdPlan.setProdPlan_end_dt(prodPlanData.getEndDate());
	    tbProdPlan.setItem_cd(prodPlanData.getProduct().getCode());
	    tbProdPlan.setQty(prodPlanData.getProductQty());
	    tbProdPlan.setRemark(prodPlanData.getRemark());
	    // prodplan_emp_id와 기타 필요한 정보를 포함시킵니다.

	    // TB_PRODPLAN 저장과 동시에 prodPlan_no 생성 및 반환
	    String prodPlanNo = kdwProdPlanDao.saveProdPlan(tbProdPlan, prodplan_emp_id);
	    System.out.println("Generated prodPlan_no for TB_PRODPLAN: " + prodPlanNo); // 생성된 prodPlan_no 확인

	    for (MaterialInfo material : prodPlanData.getMaterials()) {
	        TB_ITEM_PROD tbItemProd = new TB_ITEM_PROD();
	        tbItemProd.setProdPlan_no(prodPlanNo); // prodPlan_no 설정
	        tbItemProd.setItem_cd(material.getCode());
	        tbItemProd.setIn_qty(material.getQuantity());
	        
	        // 설정된 prodPlan_no 확인
	        System.out.println("셋팅된 ProdPlan_no  for TB_ITEM_PROD: " + tbItemProd.getProdPlan_no());

	        // TB_ITEM_PROD 삽입
	        kdwProdPlanDao.saveItemProd(tbItemProd);
	    }
	}

}
