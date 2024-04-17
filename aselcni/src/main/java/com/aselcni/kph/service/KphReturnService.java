package com.aselcni.kph.service;

import java.util.List;

import com.aselcni.kph.model.KphOutItem;
import com.aselcni.kph.model.KphOutItemItem;
import com.aselcni.kph.model.KphReturn;

public interface KphReturnService {

	List<KphOutItem> outItemList(KphOutItem kphOutItem);

	List<KphOutItemItem> outItemItemList(KphOutItem outItem);

	void returnAdd(KphReturn kphReturn);

	int totalReturnCount(KphReturn kphReturn);

	List<KphReturn> returnList(KphReturn kphReturn);

	KphReturn getReturn(KphReturn kphReturn);

	void returnDelete(KphReturn kphReturn);

	void returnUpdate(KphReturn kphReturn);

}