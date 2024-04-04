package com.aselcni.kdw.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.aselcni.kdw.model.KDW_TB_ORDER;
import com.aselcni.kdw.model.KDW_TB_ORDER_ITEM;
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

}
