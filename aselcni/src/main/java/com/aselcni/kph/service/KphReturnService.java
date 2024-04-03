package com.aselcni.kph.service;

import java.util.List;

import com.aselcni.kph.model.KphCustMst;
import com.aselcni.kph.model.KphItemMst;
import com.aselcni.kph.model.KphOutItem;
import com.aselcni.kph.model.KphTypeBig;
import com.aselcni.kph.model.KphTypeMid;
import com.aselcni.kph.model.KphTypeSml;

public interface KphReturnService {

	List<KphOutItem> outItemList(KphOutItem kphOutItem);

}
