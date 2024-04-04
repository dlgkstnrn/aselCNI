package com.aselcni.kdw.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

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
			System.out.println("KdwProdPlanDaoImpl getProdPlanItemList prodPlanItemList.size(): " + prodPlanItemList.size());
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("KdwProdPlanDaoImpl getProdPlanItemList e.getMessage(): " + e.getMessage());
		}
		return prodPlanItemList;
	}

}
