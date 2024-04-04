package com.aselcni.lhs.dao;

import java.util.List;

import com.aselcni.lhs.model.CustMst;

public interface CustMstDao {

	int insertCust(CustMst custmst);

	int selectCntCust(CustMst custmst);

	List<CustMst> selectListCust(CustMst custMst);

	CustMst selectOneCust(CustMst custmst);

	int deleteOneCust(CustMst custMst);

	int updateOneCust(CustMst custMst);

	List<CustMst> selectListCustByFlag(int item_flag);

	int selectCntCustAll(int biz_flag);

}
