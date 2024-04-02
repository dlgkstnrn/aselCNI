package com.aselcni.jtu.dao;

import java.util.List;

import com.aselcni.jtu.model.JtuProdItem;
import com.aselcni.jtu.model.JtuWorkProd;

public interface JtuDaoInterface {

	List<JtuWorkProd> getWprList();

	void setPriOne(JtuProdItem jpri);

	JtuProdItem getWhCode();

}
