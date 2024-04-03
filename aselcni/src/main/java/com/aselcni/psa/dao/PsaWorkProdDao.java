package com.aselcni.psa.dao;

import java.util.List;

import com.aselcni.psa.model.ProdPlan;
import com.aselcni.psa.model.WorkItem;
import com.aselcni.psa.model.WorkProc;
import com.aselcni.psa.model.WorkProd;

public interface PsaWorkProdDao {

	List<ProdPlan> getPlanList(ProdPlan prodPlan);

	List<WorkProd> getWorkList(WorkProd workProd);

	WorkProd selectWorkProd(WorkProd insertedWorkProd);

	List<WorkProc> getWorkProcList(WorkProd workProd);

	List<WorkItem> getWorkItemList(WorkProd workProd);

}
