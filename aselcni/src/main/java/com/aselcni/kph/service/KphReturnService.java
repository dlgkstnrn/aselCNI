package com.aselcni.kph.service;

import java.util.List;

import com.aselcni.kph.model.KphCustMst;
import com.aselcni.kph.model.KphTypeBig;

public interface KphReturnService {

	boolean isOutItem(String outitem_no);

	List<KphCustMst> getCustList(KphCustMst cust);

	List<KphTypeBig> getTypeBigList();

}
