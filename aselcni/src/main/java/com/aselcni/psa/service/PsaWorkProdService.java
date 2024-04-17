package com.aselcni.psa.service;

import java.util.List;

import com.aselcni.psa.model.Item;
import com.aselcni.psa.model.ProdItem;
import com.aselcni.psa.model.ProdPlan;
import com.aselcni.psa.model.WorkItem;
import com.aselcni.psa.model.WorkProc;
import com.aselcni.psa.model.WorkProd;

public interface PsaWorkProdService {

	List<ProdPlan> getPlanList(ProdPlan prodPlan);

	List<WorkProd> getWorkList(WorkProd workProd);
	
	List<WorkProc> getProcList();
	
	List<Item> getBigList();
	
	List<Item> getMidList(Item item);
	
	List<Item> getSmlList(Item item);
	
	List<Item> getItemList(Item item);

	WorkProd selectWorkProd(WorkProd insertedWorkProd);

	List<WorkProc> getWorkProcList(WorkProd workProd);

	List<WorkItem> getWorkItemList(WorkProd workProd);

	ProdPlan getPlan(ProdPlan prodPlan);

	ProdPlan selectProdPlan(ProdPlan insertedProdPlan);

	List<ProdItem> getPlanItemList(ProdPlan prodPlan);

	String getPK();

	int workProdInsert(WorkProd workProd);

	int workprocInsert(WorkProc workproc);

	int workItemInsert(WorkItem workItem);

	int updateWork(WorkProd workProd);

}
