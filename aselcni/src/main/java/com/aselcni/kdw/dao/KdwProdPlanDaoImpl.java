package com.aselcni.kdw.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.aselcni.kdw.model.TB_PRODPLAN;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Repository
@RequiredArgsConstructor
@Slf4j
public class KdwProdPlanDaoImpl implements KdwProdPlanDao {
	
	private final SqlSession session;
	
	// 생산계획 리스트
	@Override
	public List<TB_PRODPLAN> getProdPlanList() {
		System.out.println("KdwProdPlanDaoImpl getProdPlanList Start...");
		List<TB_PRODPLAN> prodPlanList = null;
		try {
			prodPlanList = session.selectList("kdwProdPlanList");
			System.out.println("KdwProdPlanDaoImpl getProdPlanList prodPlanList.size()" + prodPlanList.size());
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("KdwProdPlanDaoImpl getProdPlanList e.getMessage(): " + e.getMessage());
		}
		return prodPlanList;
	}

}
