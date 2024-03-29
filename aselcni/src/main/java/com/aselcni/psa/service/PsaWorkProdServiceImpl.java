package com.aselcni.psa.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.aselcni.psa.dao.PsaWorkProdDao;
import com.aselcni.psa.model.WorkProd;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class PsaWorkProdServiceImpl implements PsaWorkProdService {
	
	private final PsaWorkProdDao psaDao;

	// 생산지시 메인 페이지
	@Override
	public List<WorkProd> getPlanList() {

		List<WorkProd> planList = null;
		System.out.println("psaService getPlanList Start!");
		
		try {
			
//			planList = psaDao.getPlanList();
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("psa service error: "+e.getMessage());
		}
		
		return planList;
	}

}
