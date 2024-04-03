package com.aselcni.psa.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.aselcni.psa.dao.PsaWorkProdDao;
import com.aselcni.psa.model.ProdPlan;
import com.aselcni.psa.model.WorkItem;
import com.aselcni.psa.model.WorkProc;
import com.aselcni.psa.model.WorkProd;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class PsaWorkProdServiceImpl implements PsaWorkProdService {
	
	private final PsaWorkProdDao psaDao;

	//	지시 대기중인 생산계획 리스트 조회
	@Override
	public List<ProdPlan> getPlanList(ProdPlan prodPlan) {
		
		List<ProdPlan> planList = null;
		System.out.println("psaService getPlanList Start!");
		
		try {
			
			planList = psaDao.getPlanList(prodPlan);
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("psa getPlanList error: "+e.getMessage());
		}
		
		return planList;
	}

	// 등록된 생산지시내역 리스트 조회
	@Override
	public List<WorkProd> getWorkList(WorkProd workProd) {
		
		List<WorkProd> workList = null;
		System.out.println("psaService getWorkList Start!");
		
		try {
			
			workList = psaDao.getWorkList(workProd);
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("psa getWorkList error: "+e.getMessage());
		}
		
		return workList;
	}

	// ajax 1
	// 등록된 지시내역의 생산지시번호별 상세내용 조회
	@Override
	public WorkProd selectWorkProd(WorkProd insertedWorkProd) {

		WorkProd selectedWorkProd = null;
//		System.out.println("psaService selectWorkProd Start!");
		
		try {
			
			selectedWorkProd = psaDao.selectWorkProd(insertedWorkProd);
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("psa selectWorkProd error: "+e.getMessage());
		}
		
		return selectedWorkProd;
	}

	// ajax 2
	// 등록된 지시내역의 생산지시번호별 공정 리스트 조회
	@Override
	public List<WorkProc> getWorkProcList(WorkProd workProd) {

		List<WorkProc> workProcList = psaDao.getWorkProcList(workProd);
		return workProcList;
	}

	// ajax 3
	// 등록된 지시내역의 생산지시번호별 투입품 리스트 조회
	@Override
	public List<WorkItem> getWorkItemList(WorkProd workProd) {
		
		List<WorkItem> workItemList = psaDao.getWorkItemList(workProd);
		return workItemList;
	}

}
