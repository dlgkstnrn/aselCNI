package com.aselcni.jtu.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.aselcni.jtu.model.JtuBad;
import com.aselcni.jtu.model.JtuProdItem;
import com.aselcni.jtu.model.JtuProdItemBad;
import com.aselcni.jtu.model.JtuWH;
import com.aselcni.jtu.model.JtuWorkProd;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class JtuDaoImple implements JtuDaoInterface{
	private final SqlSession session;
	
	@Override
	public List<JtuProdItem> getPriList(JtuProdItem jpri) {
		System.out.println("JtuDaoImple getPriList Start... ");
		List<JtuProdItem> jpriList= null;
		
		System.out.println("JtuDaoImple getPriList before jpri --> " + jpri);
		try {
			jpriList =session.selectList("JtuGetPriList", jpri);
			System.out.println("JtuDaoImple getPriList after jpriList --> " + jpriList);
			System.out.println("JtuDaoImple getPriList jpriList.size() ... " + jpriList.size());
			
		} catch (Exception e) {
			System.out.println("getPriList exception->" + e.getMessage());
		}
		return jpriList;
	}


	@Override
	public List<JtuWorkProd> getWprList() {
		System.out.println("JtuDaoImple getWprList Start... ");
		List<JtuWorkProd> jwprList=null;
		try {
			jwprList =session.selectList("jtuGetWprList");
			System.out.println("JtuDaoImple getWprList jwprList.size() ... " + jwprList.size());
			
		} catch (Exception e) {
			System.out.println("getWprList exception->" + e.getMessage());
		}
		return jwprList;
	}

	@Override
	public void setPriOne(JtuProdItem jpri) {
		System.out.println("JtuDaoImple setPriOne Start... ");
		try {
			String proditem_no = session.selectOne("jtuCreatePriNo", jpri);
			jpri.setProditem_no(proditem_no);
			session.insert("jtuInsertPri",jpri);
			
			for (JtuProdItemBad jpriBad : jpri.getJpriBadList()) {
				jpriBad.setProditem_no(proditem_no);
				session.insert("jtuInsertPriBad",jpriBad);
			}
			
		} catch (Exception e) {
			System.out.println("setPriOne exception->" + e.getMessage());
		}
	}

	@Override
	public List<JtuWH> getWhCode() {
		System.out.println("JtuDaoImple getWhCode Start... ");
		List<JtuWH> jwhList = null;
		try {
			jwhList = session.selectList("jtuGetWHList");
			System.out.println("JtuDaoImple getWhCode jwhList.size() ... " + jwhList.size());
			
		} catch (Exception e) {
			System.out.println("getWhCode exception->" + e.getMessage());
		}
		
		return jwhList;
	}


	@Override
	public JtuProdItem getPriOneAjax(JtuProdItem paraJpri) {
		System.out.println("JtuDaoImple getPriOneAjax Start... ");
		JtuProdItem jpri = null;
		try {
			jpri = session.selectOne("jtuGetPriOne", paraJpri);
			
			List<JtuProdItemBad>  jpriBadList = session.selectList("JtuGetPriBadList", paraJpri);
			System.out.println("JtuDaoImple getPriOneAjax jpriBadList.size() ... " + jpriBadList.size());
		
			jpri.setJpriBadList(jpriBadList);
			System.out.println("JtuDaoImple getPriOneAjax jpri --> " + jpri);
			
		} catch (Exception e) {
			System.out.println("getPriOneAjax exception->" + e.getMessage());
		}
		return jpri;
	}


	@Override
	public void updatePriOne(JtuProdItem jpri) {
		System.out.println("JtuDaoImple updatePriOne Start... ");
		try {
			int rs =session.update("jtuUpdatePriOne",jpri);
			System.out.println("JtuDaoImple updatePriOne rs --> " + rs);
			
		} catch (Exception e) {
			System.out.println("updatePriOne exception->" + e.getMessage());
		}
	}


	@Override
	public void deletePriOne(JtuProdItem jpri) {
		System.out.println("JtuDaoImple deletePriOne Start... ");
		try {
			int rs =session.update("jtuDeletePriOne",jpri);
			System.out.println("JtuDaoImple deletePriOne rs --> " + rs);
			
			
			
		} catch (Exception e) {
			System.out.println("deletePriOne exception->" + e.getMessage());
		}
	}


	@Override
	public List<JtuBad> getJbadList(JtuBad jbad) {
		System.out.println("JtuDaoImple getJbadList Start... ");
		List<JtuBad> jbadList= null;
		try {
			jbadList=session.selectList("jtuGetBadList", jbad);
		} catch (Exception e) {
			System.out.println("getJbadList exception->" + e.getMessage());
		}
		
		return jbadList;
	}


	@Override
	public void setJbadOne(JtuBad jbad) {
		System.out.println("JtuDaoImple setJbadOne Start... ");
		try {
			int rs =session.insert("jtuInsertBadOne", jbad);
			System.out.println("JtuDaoImple setJbadOne jbad --> " + jbad);
		} catch (Exception e) {
			System.out.println("setJbadOne exception->" + e.getMessage());
		}
	}


	@Override
	public int getJpriTotalCnt(JtuProdItem jpri) {
		System.out.println("JtuDaoImple getJpriTotalCnt Start... ");
		System.out.println("JtuDaoImple getJpriTotalCnt jpri --> " + jpri);
		int jpriTotalCnt = 0;
		try {
			jpriTotalCnt =  session.selectOne("jtuGetJpriTotalCnt", jpri);
		} catch (Exception e) {
			System.out.println("getJpriTotalCnt exception->" + e.getMessage());
		}
		
		return jpriTotalCnt;
	}



}
