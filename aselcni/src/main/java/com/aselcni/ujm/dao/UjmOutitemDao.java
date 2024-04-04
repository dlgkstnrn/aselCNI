package com.aselcni.ujm.dao;

import java.util.List;

import com.aselcni.ujm.model.UjmOutitem;

public interface UjmOutitemDao {

	int ujmTotalOutitemCnt();

	List<UjmOutitem> ujmListOutiem(UjmOutitem outitem);
}
