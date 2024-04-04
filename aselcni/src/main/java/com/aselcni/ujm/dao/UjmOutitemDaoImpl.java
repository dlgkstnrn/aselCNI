package com.aselcni.ujm.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.aselcni.ujm.model.UjmOutitem;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class UjmOutitemDaoImpl implements UjmOutitemDao {

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

	@Override
	public List<UjmOutitem> ujmListOutiem(UjmOutitem outitem) {
		List<UjmOutitem> ujmListOutitems = null;
		System.out.println("UjmOutitemDaoImpl ujmListOutiem 시작 ..." );
		try {
			//
			ujmListOutitems = session.selectList("ujmListOutitemAll", outitem);
			if(ujmListOutitems!=null) {
				System.out.println("UjmOutitemDaoImpl ujmListOutitems ujmListOutitems.size()->"+ujmListOutitems.size());
				}
		} catch (Exception e) {
			System.out.println("UjmOutitemDaoImpl ujmListOutitems 오류:"+e.getMessage());
		}
		return ujmListOutitems;
	}

}
