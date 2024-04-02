package com.aselcni.kph.dao;

import java.util.List;

import com.aselcni.kph.model.KphCustMst;
import com.aselcni.kph.model.KphTypeBig;

public interface KphReturnDao {

	int countOutItemByOutItemNo(String outitem_no);

	List<KphCustMst> getCustList(KphCustMst cust);

	List<KphTypeBig> getTypeBigList();

}
