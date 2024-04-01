package com.aselcni.psa.dao;

import java.util.List;

import com.aselcni.psa.model.ProdPlan;

public interface PsaWorkProdDao {

	List<ProdPlan> getPlanList(ProdPlan prodPlan);

}
