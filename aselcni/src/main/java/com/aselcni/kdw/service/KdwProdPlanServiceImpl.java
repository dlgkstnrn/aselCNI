package com.aselcni.kdw.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.aselcni.kdw.dao.KdwProdPlanDao;
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
	
}
