package com.aselcni.main.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.aselcni.main.model.Common;
import com.aselcni.main.model.UserMst;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class AdminDaoImp implements AdminDao {

	private final SqlSession session;

	@Override
	public List<Common> getAuthorityList() {
		List<Common> userAuthorityList = session.selectList("KphGetAuthorityList");
		return userAuthorityList;
	}

	@Override
	public int userAdd(UserMst user) {
		int result = session.insert("KphUserAdd", user);
		return result;
	}
	
}
