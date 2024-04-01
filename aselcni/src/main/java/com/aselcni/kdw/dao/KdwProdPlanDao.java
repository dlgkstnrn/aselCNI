package com.aselcni.kdw.dao;

import java.util.List;

import com.aselcni.kdw.model.TB_PRODPLAN;

public interface KdwProdPlanDao {
	// 생산계획 리스트
	List<TB_PRODPLAN> getProdPlanList();

}
