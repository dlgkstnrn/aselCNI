package com.aselcni.jtu.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.aselcni.jtu.dao.JtuDaoInterface;
import com.aselcni.jtu.model.JtuBad;
import com.aselcni.jtu.model.JtuProdItem;
import com.aselcni.jtu.model.JtuProdItemBad;
import com.aselcni.jtu.model.JtuWH;
import com.aselcni.jtu.model.JtuWorkProd;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
@Transactional
public class JtuServiceImple implements JtuServiceInterface {
	private final JtuDaoInterface jd;

	@Override
	public List<JtuProdItem> getPriList(JtuProdItem jpri, JtuPaging jPaging) {
		System.out.println("JtuServiceImple getPriList Start... ");

		jpri.setStartPage(jPaging.getStartPage());
		jpri.setEndPage(jPaging.getEndPage());
		jpri.setStart(jPaging.getStart());
		jpri.setEnd(jPaging.getEnd());
		jpri.setRowPage(jPaging.getRowPage());
		jpri.setCurrentPage(jPaging.getCurrentPage());

//		System.out.println("JtuServiceImple jPaging --> " + jpri.getStartPage()+", "
//				+jpri.getEndPage()+", "+jpri.getStart()+", "+jpri.getEnd()+", "+jPaging.getCurrentPage());

		List<JtuProdItem> jpriList = jd.getPriList(jpri);

		return jpriList;
	}

	@Override
	public List<JtuWorkProd> getWprList() {
		System.out.println("JtuServiceImple getWprList Start... ");
		List<JtuWorkProd> wprList = jd.getWprList();

		return wprList;
	}

	@Override
	public List<JtuWH> getWhCode() {
		System.out.println("JtuServiceImple getWhCode Start... ");
		List<JtuWH> jwhList = jd.getWhCode();
		return jwhList;
	}

	@Override
	public JtuProdItem getPriOneAjax(JtuProdItem paraJpri) {
		System.out.println("JtuServiceImple getPriOneAjax Start... ");
		JtuProdItem jpri = jd.getPriOneAjax(paraJpri);
		return jpri;
	}

	@Override
	public void setPriOne(JtuProdItem jpri) {
		System.out.println("JtuServiceImple setPriOne Start... ");

		jd.setPriOne(jpri);
	}

	@Override
	public void updatePriOne(JtuProdItem jpri) {
		System.out.println("JtuServiceImple updatePriOne Start... ");
		List<JtuProdItemBad> jpriBadList = new ArrayList<>();

		if (jpri.getJpriBadList() != null) {
			for (JtuProdItemBad jpriBad : jpri.getJpriBadList()) {
				jpriBad.setProditem_no(jpri.getProditem_no());
				jpriBadList.add(jpriBad);
			}
		}
		jpri.setJpriBadList(jpriBadList);

		jd.updatePriOne(jpri);
	}

	@Override
	public void deletePriOne(JtuProdItem jpri) {
		System.out.println("JtuServiceImple deletePriOne Start... ");
		jd.deletePriOne(jpri);
	}

	@Override
	public List<JtuBad> getJbadList(JtuBad jbad) {
		System.out.println("JtuServiceImple getJbadList Start... ");
		if (jbad.getBadCdKeyword() == null) {
			jbad.setBadCdKeyword("");
		}
		if (jbad.getBadResKeyword() == null) {
			jbad.setBadResKeyword("");
		}
		List<JtuBad> jbadList = jd.getJbadList(jbad);

		return jbadList;
	}

	@Override
	public void setJbadOne(JtuBad jbad) {
		System.out.println("JtuServiceImple setJbadOne Start... ");
		if (jbad.getBadCdKeyword() == null) {
			jbad.setBadCdKeyword("");
		}
		if (jbad.getBadResKeyword() == null) {
			jbad.setBadResKeyword("");
		}
		jd.setJbadOne(jbad);
	}

	@Override
	public int getJpriTotalCnt(JtuProdItem jpri) {
		System.out.println("JtuServiceImple getJpriTotalCnt Start... ");
		int jpriTotalCnt = jd.getJpriTotalCnt(jpri);

		return jpriTotalCnt;
	}

}
