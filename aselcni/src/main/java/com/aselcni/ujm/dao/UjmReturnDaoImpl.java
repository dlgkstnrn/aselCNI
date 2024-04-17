package com.aselcni.ujm.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class UjmReturnDaoImpl implements UjmReturnDao {
	
	private final SqlSession session;

	@Override
	public int ujmReturnChk(String outitem_no) {
		System.out.println("UjmReturnDaoImpl outitem_no start..");
		System.out.println(outitem_no);
		int ujmReturnChk= 0;
		try {
			ujmReturnChk=session.selectOne("ujmReturnChk",outitem_no);
		} catch (Exception e) {
			System.out.println("UjmReturnDaoImpl outitem_no Exception->"+e.getMessage());
		}
		return ujmReturnChk;
	}
	

}
