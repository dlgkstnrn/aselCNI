package com.aselcni.psa.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
//import org.springframework.transaction.PlatformTransactionManager;

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


}
