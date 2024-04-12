package com.aselcni.ujm.dao;

import java.util.List;

import com.aselcni.ujm.model.UjmOrderInfoToInsertDto;
import com.aselcni.ujm.model.UjmOrderNoDto;
import com.aselcni.ujm.model.UjmOutitem;
import com.aselcni.ujm.model.UjmOutitemItem;

public interface UjmOutitemDao {

	int ujmTotalOutitemCnt();

	List<UjmOutitem> ujmListOutiem(UjmOutitem outitem);

	String ujmSetOutitemNo(String outitem_no);

	int ujmGetSeqNo(String order_no);

	int ujmInsertOutitem(UjmOutitem outitem);

	void ujmInsertOutitemItem(UjmOutitemItem item);

	int ujmOutitemItemCnt(UjmOutitem outitemData);

}
