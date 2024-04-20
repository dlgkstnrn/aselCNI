package com.aselcni.ujm.dao;

import java.util.List;

import com.aselcni.ujm.model.UjmOrderInfoToInsertDto;
import com.aselcni.ujm.model.UjmOrderNoDto;
import com.aselcni.ujm.model.UjmOutitem;
import com.aselcni.ujm.model.UjmOutitemItem;

public interface UjmOutitemDao {

	int ujmTotalOutitemCnt(UjmOutitem outitem);

	List<UjmOutitem> ujmListOutiem(UjmOutitem outitem);

	String ujmSetOutitemNo(String outitem_no);

	int ujmGetSeqNo(String order_no);

	int ujmInsertOutitem(UjmOutitem outitem);

	void ujmInsertOutitemItem(UjmOutitemItem item);

	int ujmOutitemItemCnt(UjmOutitem outitemData);

	List<UjmOutitem> ujmGetOutitemDetail(String outitem_no, String order_no);

	List<UjmOutitem> ujmGetOutitemToUpdate(String order_no, String outitem_no);

	int ujmUpdateOutitem(UjmOutitem outitem);

	int ujmitemNotNullCheck(UjmOutitemItem item);

	int ujmUpdateOutitemItem(UjmOutitemItem item);

	int ujmDeleteOutitemItem(UjmOutitemItem item);

	String ujmFindOutitemRemark(String outitem_no);

	int ujmDeleteOutitem(String outitem_no);

}
