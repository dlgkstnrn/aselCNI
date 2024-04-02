package com.aselcni.jtu.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.aselcni.jtu.dao.JtuDaoImple;
import com.aselcni.jtu.dao.JtuDaoInterface;
import com.aselcni.psa.model.WorkProd;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class JtuServiceImple implements JtuServiceInterface{
	private final JtuDaoInterface jd;

	@Override
	public List<WorkProd> getWprList() {
		System.out.println("JtuServiceImple getWprList Start... ");
		List<WorkProd> wprList =jd.getWprList();
		
		return wprList;
	}

	@Override
	public void setPriOne() {
		System.out.println("JtuServiceImple setPriOne Start... ");
		jd.setPriOne();
	}


	

}
