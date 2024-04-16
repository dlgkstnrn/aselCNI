package com.aselcni.psa.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
//import org.springframework.transaction.PlatformTransactionManager;

import com.aselcni.psa.model.Item;
import com.aselcni.psa.model.ProdItem;
import com.aselcni.psa.model.ProdPlan;
import com.aselcni.psa.model.WorkItem;
import com.aselcni.psa.model.WorkProc;
import com.aselcni.psa.model.WorkProd;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class PsaWorkProdDaoImpl implements PsaWorkProdDao {
	
	private final SqlSession session;
//	private final PlatformTransactionManager tm;

	//	지시 대기중인 생산계획 리스트 조회
	@Override
	public List<ProdPlan> getPlanList(ProdPlan prodPlan) {
		
		List<ProdPlan> planList = null;
		System.out.println("psaDao getPlanList Start!");
		
		try {
			
			planList = session.selectList("psaGetPlanList", prodPlan);
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("psa dao error: "+e.getMessage());
		}
		
		return planList;
	}

	// 등록된 생산지시내역 리스트 조회
	@Override
	public List<WorkProd> getWorkList(WorkProd workProd) {
		
		List<WorkProd> workList = null;
		System.out.println("psaDao getWorkList Start!");
		
		try {
			
			workList = session.selectList("psaGetWorkList", workProd);
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("psa dao error: "+e.getMessage());
		}
		
		return workList;
	}
	
	// 지시 등록 시 사용 가능한 공정리스트 조회
	@Override
	public List<WorkProc> getProcList() {

		List<WorkProc> procList = session.selectList("psaGetProcList");
		return procList;
	
	}

	// 품목 대분류
	@Override
	public List<Item> getBigList() {
		
		List<Item> bigList = session.selectList("psaGetBigList");
		return bigList;
	}

	// 품목 중분류 ajax
	@Override
	public List<Item> getMidList(Item item) {

		List<Item> midList = session.selectList("psaGetMidList", item);
		return midList;
	}

	// 품목 소분류 ajax
	@Override
	public List<Item> getSmlList(Item item) {
		
		List<Item> smlList = session.selectList("psaGetSmlList", item);
		return smlList;
	}

	// 품목 리스트 ajax
	// select box 에서 선택한 대/중/소 분류에 맞는 리스트
	@Override
	public List<Item> getItemList(Item item) {
		
		List<Item> itemList = session.selectList("psaGetItemList", item);
		return itemList;
	}

	// ajax 1
	// 등록된 지시내역의 생산지시번호별 상세내용 조회
	@Override
	public WorkProd selectWorkProd(WorkProd insertedWorkProd) {
		
		WorkProd selectedWorkProd = null;
//		System.out.println("psaDao selectWorkProd Start!");
		
		try {
			
			// 결과 Expected one result (or null) to be returned by selectOne(), but found: 6
			selectedWorkProd = session.selectOne("psaGetWorkProd", insertedWorkProd);
			
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

		List<WorkProc> workProcList = session.selectList("psaGetWorkProcList", workProd);
		return workProcList;
	}

	// ajax 3
	// 등록된 지시내역의 생산지시번호별 투입품 리스트 조회
	@Override
	public List<WorkItem> getWorkItemList(WorkProd workProd) {
		
		List<WorkItem> workItemList = session.selectList("psaGetWorkItemList", workProd);
		return workItemList;
	}

	// 생산지시 등록 (페이지 이동 버전)
	// 지시 등록할 생산계획 조회
	@Override
	public ProdPlan getPlan(ProdPlan prodPlan) {
		
		ProdPlan getPlan = session.selectOne("psaGetPlan", prodPlan);
		return getPlan;
	}

	// ajax 1 - 생산계획
	// 생산계획번호별 상세내용 조회 (공정, 투입품 제외)
	@Override
	public ProdPlan selectProdPlan(ProdPlan insertedProdPlan) {
		
		ProdPlan selectProdPlan = session.selectOne("psaGetPlan", insertedProdPlan);
		return selectProdPlan;
	}

	// ajax 2 - 생산계획 - 투입품 리스트
	// 생산계획번호별 투입품 리스트 조회
	@Override
	public List<ProdItem> getPlanItemList(ProdPlan prodPlan) {
		
		List<ProdItem> planItemList = session.selectList("psaGetPlanItemList", prodPlan);
		return planItemList;
	}

	// workprod PK 생성
	@Override
	public String getPK() {
		
		String workprodNo = session.selectOne("psaGetPK");
		return workprodNo;
	}

	// ajax 1 -  생산지시 등록 (Modal version)
	// 공정, 투입품 제외
	// insert into TB_WORKPROD
	@Override
	public int workProdInsert(WorkProd workProd) {
		
		int result = session.insert("psaInsertWorkProd", workProd);
		return result;
	}

	// ajax 2 -  생산지시 등록 (Modal version)
	// 공정 - proc_cd []
	// insert into TB_WORK_PROC
	@Override
	public int workprocInsert(WorkProc workproc) {

		int result = session.insert("psaInsertWorkProc", workproc);
		return result;
	}

	// ajax 3 -  생산지시 등록 (Modal version)
	// 투입품 등록
	// INSERT INTO TB_WORK_ITEM
	@Override
	public int workItemInsert(WorkItem workItem) {
		
		int result = session.insert("psaInsertWorkItem", workItem);
		return result;
	}

	// 생산지시 수정 ajax
	@Override
	public int updateWork(WorkProd workProd) {

		int result = session.insert("psaUpdateWork", workProd);
		return result;
	}


}
