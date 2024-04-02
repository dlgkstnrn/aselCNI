package com.aselcni.lhs.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.aselcni.lhs.dao.CustMstDao;
import com.aselcni.lhs.model.CustMst;

import lombok.RequiredArgsConstructor;
@Service
@RequiredArgsConstructor
public class CustMstServiceImpl implements CustMstService {

	private final CustMstDao mstDao;
	
	@Override
	public int insertCust(CustMst custmst) {
		int result = mstDao.insertCust(custmst);
		return result;
	}
	
	@Override
	public int selectCntCust(CustMst custmst) {
		int custCnt = mstDao.selectCntCust(custmst);
		return custCnt;
	}
	
	@Override
	public List<CustMst> selectListCust(CustMst custMst) {
		return mstDao.selectListCust(custMst);
	}
	
	@Override
	public CustMst selectOneCust(CustMst custmst) {
		return mstDao.selectOneCust(custmst);
	}
	
	@Override
	public int deleteOneCust(CustMst custMst) {
		return mstDao.deleteOneCust(custMst);
	}
	
	@Override
	public int updateOneCust(CustMst custMst) {
		return mstDao.updateOneCust(custMst);
	}
	
	@Override
	public List<CustMst> selectListCustByFlag(int item_flag) {
		return mstDao.selectListCustByFlag(item_flag);
	}
	
	@Override
	public int selectCntCustAll(int biz_flag) {
		return mstDao.selectCntCustAll(biz_flag);
	}

}
