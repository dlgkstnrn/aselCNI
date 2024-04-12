package com.aselcni.jtu.dao;

import java.util.List;

import com.aselcni.jtu.model.JtuBad;
import com.aselcni.jtu.model.JtuProdItem;
import com.aselcni.jtu.model.JtuWH;
import com.aselcni.jtu.model.JtuWorkProd;

public interface JtuDaoInterface {

	List<JtuWorkProd> getWprList();

	void setPriOne(JtuProdItem jpri);

	List<JtuWH> getWhCode();

	List<JtuProdItem> getPriList(JtuProdItem jpri);

	JtuProdItem getPriOneAjax(JtuProdItem paraJpri);

	void updatePriOne(JtuProdItem jpri);

	void deletePriOne(JtuProdItem jpri);

	List<JtuBad> getJbadList(JtuBad jbad);

	void setJbadOne(JtuBad jbad);

	int getJpriTotalCnt(JtuProdItem jpri);

}
