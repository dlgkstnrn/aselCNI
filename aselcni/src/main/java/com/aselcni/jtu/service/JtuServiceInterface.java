package com.aselcni.jtu.service;

import java.util.List;

import com.aselcni.jtu.model.JtuProdItem;
import com.aselcni.jtu.model.JtuWorkProd;

public interface JtuServiceInterface {

	List<JtuWorkProd> getWprList();

	void setPriOne(JtuProdItem jpri);

	JtuProdItem getWhCode();

}
