package com.aselcni.kph.dao;

import java.util.List;

import com.aselcni.kph.model.KphOutItem;
import com.aselcni.kph.model.KphOutItemItem;
import com.aselcni.kph.model.KphReturn;

public interface KphReturnDao {

	List<KphOutItem> outItemList(KphOutItem kphOutItem);

	List<KphOutItemItem> outItemItemList(KphOutItem outItem);

	void returnAdd(KphReturn kphReturn);

}
