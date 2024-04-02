package com.aselcni.main.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.aselcni.main.model.UserMst;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class MainDaoImp implements MainDao {
	
	private final SqlSession session;
	
	@Override
	public UserMst getUser(UserMst user) {
		return session.selectOne("KphGetUser", user);
	}

}
