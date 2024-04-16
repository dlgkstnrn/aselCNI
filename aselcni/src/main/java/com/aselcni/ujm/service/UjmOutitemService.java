package com.aselcni.ujm.service;

import java.util.List;

import com.aselcni.ujm.model.UjmOrderInfoToInsertDto;
import com.aselcni.ujm.model.UjmOrderItem;
import com.aselcni.ujm.model.UjmOrderNoDto;
import com.aselcni.ujm.model.UjmOutitem;
import com.aselcni.ujm.model.UjmOutitemParent;

public interface UjmOutitemService {

	int ujmTotalOutitemCnt();

	List<UjmOutitem> ujmListOutitem(UjmOutitem outitem);

	int ujmInsertOutitem(UjmOutitemParent insertData, String userId);

	int ujmInsertOutitemItem(UjmOutitemParent insertData);

	String ujmSetOutitemNo(String outitem_no);

	List<UjmOutitem> ujmGetOutitemDetail(String outitem_no, String order_no);

	List<UjmOutitem> ujmGetOutitemToUpdate(String order_no, String outitem_no);

}
