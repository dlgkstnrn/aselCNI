package com.aselcni.psa.service;

import java.util.List;

import com.aselcni.psa.model.ProdPlan;
import com.aselcni.psa.model.WorkProd;

public interface PsaWorkProdService {

	List<ProdPlan> getPlanList(ProdPlan prodPlan);

	List<WorkProd> getWorkList(WorkProd workProd);

	WorkProd selectWorkProd(WorkProd insertedWorkProd);

}
