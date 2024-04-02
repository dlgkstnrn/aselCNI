package com.aselcni.lhs.dao;

import java.util.List;

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
	public int selectCntCust(CustMst custmst) {
		int custCnt = session.selectOne("selectCntCust",custmst);
		return custCnt;
	}
	
	@Override
	public List<CustMst> selectListCust(CustMst custMst) {
		return session.selectList("selectListCust", custMst);
	}
	
	@Override
	public CustMst selectOneCust(CustMst custmst) {
		return session.selectOne("selectOneCust", custmst);
	}
	
	@Override
	public int deleteOneCust(CustMst custMst) {
		return session.update("deleteOneCust", custMst);
	}
	
	@Override
	public int updateOneCust(CustMst custMst) {
		return session.update("updateOneCust", custMst);
	}
	
	@Override
	public List<CustMst> selectListCustByFlag(int item_flag) {
		return session.selectList("selectListCustByFlag", item_flag);
	}
	
	@Override
	public int selectCntCustAll(int biz_flag) {
		return session.selectOne("selectCntCustAll", biz_flag);
	}

}
