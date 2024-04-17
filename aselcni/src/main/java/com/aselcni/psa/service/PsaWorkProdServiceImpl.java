package com.aselcni.psa.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.aselcni.psa.dao.PsaWorkProdDao;
import com.aselcni.psa.model.Item;
import com.aselcni.psa.model.ProdItem;
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
	
	// 지시 등록 시 사용 가능한 공정리스트 조회
	@Override
	public List<WorkProc> getProcList() {

		List<WorkProc> procList = psaDao.getProcList();
		return procList;
	
	}

	// 품목 대분류 
	@Override
	public List<Item> getBigList() {

		List<Item> bigList = psaDao.getBigList();
		return bigList;
	}
	
	// 품목 중분류 ajax
	@Override
	public List<Item> getMidList(Item item) {
		
		List<Item> midList = psaDao.getMidList(item);
		return midList;
	}
	
	// 품목 소분류 ajax
	@Override
	public List<Item> getSmlList(Item item) {
		
		List<Item> smlList = psaDao.getSmlList(item);
		return smlList;
	}
	
	// 품목 리스트 ajax
	// select box 에서 선택한 대/중/소 분류에 맞는 리스트
	@Override
	public List<Item> getItemList(Item item) {
		
		List<Item> itemList = psaDao.getItemList(item);
		return itemList;
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

	// 생산지시 등록 (페이지 이동 버전)
	// 지시 등록할 생산계획 조회
	@Override
	public ProdPlan getPlan(ProdPlan prodPlan) {
		
		ProdPlan getPlan = psaDao.getPlan(prodPlan);
		return getPlan;
	}

	// ajax 1 - 생산계획
	// 생산계획번호별 상세내용 조회 (공정, 투입품 제외)
	@Override
	public ProdPlan selectProdPlan(ProdPlan insertedProdPlan) {
		
		ProdPlan selectProdPlan = psaDao.selectProdPlan(insertedProdPlan);
		return selectProdPlan;
	}

	// ajax 2 - 생산계획 - 투입품 리스트
	// 생산계획번호별 투입품 리스트 조회
	@Override
	public List<ProdItem> getPlanItemList(ProdPlan prodPlan) {
		
		List<ProdItem> planItemList = psaDao.getPlanItemList(prodPlan);
		return planItemList;
	}

	// workprod PK 생성
	@Override
	public String getPK() {

		String workprodNo = psaDao.getPK();
		return workprodNo;
	}

	// ajax 1 -  생산지시 등록 (Modal version)
	// 공정, 투입품 제외
	// insert into TB_WORKPROD
	@Override
	public int workProdInsert(WorkProd workProd) {
		
		int result = psaDao.workProdInsert(workProd);
		return result;
	}

	// ajax 2 -  생산지시 등록 (Modal version)
	// 공정 - proc_cd []
	// insert into TB_WORK_PROC
	@Override
	public int workprocInsert(WorkProc workproc) {

		int result = psaDao.workprocInsert(workproc);
		return result;
	}

	// ajax 3 -  생산지시 등록 (Modal version)
	// 투입품 등록
	// INSERT INTO TB_WORK_ITEM
	@Override
	public int workItemInsert(WorkItem workItem) {
		
		int result = psaDao.workItemInsert(workItem);
		return result;
	}

	// 생산지시 수정 ajax
	@Override
	public int updateWork(WorkProd workProd) {

		int result = psaDao.updateWork(workProd);
		return result;
	}


}
