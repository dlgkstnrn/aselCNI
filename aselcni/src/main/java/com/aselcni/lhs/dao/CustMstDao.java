package com.aselcni.lhs.dao;

import com.aselcni.lhs.model.CustMst;

public interface CustMstDao {

	int insertCust(CustMst custmst);

	int selectCntTodayCust(int biz_flag);

}
