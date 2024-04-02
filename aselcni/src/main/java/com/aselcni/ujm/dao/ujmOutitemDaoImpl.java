package com.aselcni.ujm.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class ujmOutitemDaoImpl implements ujmOutitemDao {

	private final SqlSession session;
	
	@Override
	public int ujmTotalOutitemCnt() {
		int ujmTotalOutitemCnt=0;
		System.out.println("ujmOutitemDaoImpl에서 ujmTotalOutitemCnt");
		try {
			ujmTotalOutitemCnt=session.selectOne("ujmTotalOutitemCnt");
			System.out.println("ujmOutitemDaoImpl에서 ujmTotalOutitemCnt한 값:"+ujmTotalOutitemCnt);
		} catch (Exception e) {
			System.out.println("ujmOutitemDaoImpl에서 ujmTotalOutitemCnt 도중 실패:"+e.getMessage());
		}
		
		return ujmTotalOutitemCnt;
	}

}
