package com.aselcni.jtu.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.aselcni.jtu.dao.JtuDaoInterface;
import com.aselcni.jtu.model.JtuProdItem;
import com.aselcni.jtu.model.JtuWorkProd;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class JtuServiceImple implements JtuServiceInterface{
	private final JtuDaoInterface jd;

	@Override
	public List<JtuWorkProd> getWprList() {
		System.out.println("JtuServiceImple getWprList Start... ");
		List<JtuWorkProd> wprList =jd.getWprList();
		
		return wprList;
	}

	@Override
	public void setPriOne(JtuProdItem jpri) {
		System.out.println("JtuServiceImple setPriOne Start... ");
		
		jd.setPriOne(jpri);
	}

	@Override
	public JtuProdItem getWhCode() {
		System.out.println("JtuServiceImple getWhCode Start... ");
		JtuProdItem jpri = jd.getWhCode();
		
		return jpri;
	}


	

}
