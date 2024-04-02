package com.aselcni.psa.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
//import org.springframework.transaction.PlatformTransactionManager;

import com.aselcni.psa.model.ProdPlan;
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

	// 등록된 지시내역의 생산지시번호별 상세내용
	@Override
	public WorkProd selectWorkProd(WorkProd insertedWorkProd) {
		
		WorkProd selectedWorkProd = null;
		System.out.println("psaService selectWorkProd Start!");
		
		try {
			
			selectedWorkProd = session.selectOne("psaGetWorkProd", insertedWorkProd);
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("psa selectWorkProd error: "+e.getMessage());
		}
		
		return selectedWorkProd;
	}


}
