package com.aselcni.kdw.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.aselcni.kdw.dao.KdwProdPlanDao;
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
	// 생산계획 리스트
	public List<TB_PRODPLAN> getProdPlanList() {
		System.out.println("KdwProdPlanServiceImpl getProdPlanList Start...");
		List<TB_PRODPLAN> prodPlanList = kdwProdPlanDao.getProdPlanList();
		System.out.println("KdwProdPlanServiceImpl prodPlanList.size()" + prodPlanList.size());
		return prodPlanList;
	}
	
}
