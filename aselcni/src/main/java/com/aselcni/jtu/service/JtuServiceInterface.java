package com.aselcni.jtu.service;

import java.util.List;

import com.aselcni.jtu.model.JtuProdItem;
import com.aselcni.jtu.model.JtuWH;
import com.aselcni.jtu.model.JtuWorkProd;

public interface JtuServiceInterface {

	List<JtuWorkProd> getWprList();

	void setPriOne(JtuProdItem jpri);

	List<JtuWH> getWhCode();

	List<JtuProdItem> getPriList(JtuProdItem jpri);

}
