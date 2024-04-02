package com.aselcni.kph.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.aselcni.kph.model.KphCustMst;
import com.aselcni.kph.model.KphTypeBig;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class KphReturnDaoImp implements KphReturnDao {

	private final SqlSession session;

	@Override
	public int countOutItemByOutItemNo(String outitem_no) {
		return session.selectOne("KphCountOutItemByOutItemNo", outitem_no);
	}

	@Override
	public List<KphCustMst> getCustList(KphCustMst cust) {
		return session.selectList("KphGetCustList", cust);
	}

	@Override
	public List<KphTypeBig> getTypeBigList() {
		return session.selectList("KphGetTypeBigList");
	}
	
}
