package com.aselcni.lhs.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.aselcni.lhs.model.CustMst;

import lombok.RequiredArgsConstructor;
@Repository
@RequiredArgsConstructor
public class CustMstDaoImpl implements CustMstDao {

	private final SqlSession session;
	
	@Override
	public int insertCust(CustMst custmst) {
		int result = session.insert("insertCust", custmst);
		return result;
	}
	
	@Override
	public int selectCntTodayCust(int biz_flag) {
		int todayCustCnt = session.selectOne("selectCntTodayCust",biz_flag);
		return todayCustCnt;
	}

}
