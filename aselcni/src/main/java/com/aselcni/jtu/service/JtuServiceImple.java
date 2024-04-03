package com.aselcni.jtu.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.aselcni.jtu.dao.JtuDaoInterface;
import com.aselcni.jtu.model.JtuProdItem;
import com.aselcni.jtu.model.JtuWH;
import com.aselcni.jtu.model.JtuWorkProd;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class JtuServiceImple implements JtuServiceInterface{
	private final JtuDaoInterface jd;
	
	@Override
	public List<JtuProdItem> getPriList(JtuProdItem jpri) {
		System.out.println("JtuServiceImple getPriList Start... ");
		List<JtuProdItem> jpriList = jd.getPriList(jpri);
		
		return jpriList;
	}

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
	public List<JtuWH> getWhCode() {
		System.out.println("JtuServiceImple getWhCode Start... ");
		List<JtuWH> jwhList = jd.getWhCode();
		
		return jwhList;
	}


	

}
