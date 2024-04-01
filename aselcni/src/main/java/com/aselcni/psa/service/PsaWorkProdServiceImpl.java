package com.aselcni.psa.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.aselcni.psa.dao.PsaWorkProdDao;
import com.aselcni.psa.model.ProdPlan;
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
			System.out.println("psa service error: "+e.getMessage());
		}
		
		return planList;
	}

}
