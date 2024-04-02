package com.aselcni.lhs.service;

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
	public int selectCntTodayCust(int biz_flag) {
		int todayCustCnt = mstDao.selectCntTodayCust(biz_flag);
		return todayCustCnt;
	}

}
