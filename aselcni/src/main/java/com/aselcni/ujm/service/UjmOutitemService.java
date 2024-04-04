package com.aselcni.ujm.service;

import java.util.List;

import com.aselcni.ujm.model.UjmOutitem;

public interface UjmOutitemService {

	int ujmTotalOutitemCnt();

	List<UjmOutitem> ujmListOutitem(UjmOutitem outitem);

}
