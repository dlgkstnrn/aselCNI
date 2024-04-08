package com.aselcni.lhs.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.aselcni.lhs.model.Compmst;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class CompmstDaoImpl implements CompmstDao {

	private final SqlSession session;
	
	@Override
	public int compmstUpdate(Compmst compmst) {
		return session.update("compmstUpdate", compmst);
	}
	
	@Override
	public Compmst compmstSelect() {
		return session.selectOne("compmstSelect");
	}

}
