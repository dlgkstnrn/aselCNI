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

}
