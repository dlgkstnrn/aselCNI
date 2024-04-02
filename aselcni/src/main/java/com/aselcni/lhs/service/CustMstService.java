package com.aselcni.lhs.service;

import com.aselcni.lhs.model.CustMst;

public interface CustMstService {

	int insertCust(CustMst custmst);

	int selectCntTodayCust(int biz_flag);
	
}
