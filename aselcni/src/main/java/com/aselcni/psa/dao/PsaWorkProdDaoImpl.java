package com.aselcni.psa.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
//import org.springframework.transaction.PlatformTransactionManager;

import com.aselcni.psa.model.ProdPlan;

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


}
