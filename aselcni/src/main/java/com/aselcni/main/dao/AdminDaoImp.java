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
	public int isUserExist(UserMst user) {
		return session.selectOne("KphIsUserExist", user);
	}

	@Override
	public int userAdd(UserMst user) {
		int result = session.insert("KphUserAdd", user);
		return result;
	}

	@Override
	public int totalUserCountByKeyword(UserMst user) {
		return session.selectOne("KphTotalUserCountByKeyword", user);
	}
	
	@Override
	public List<UserMst> userListByKeyword(UserMst user) {
		return session.selectList("KphUserListByKeyword", user);
	}

	@Override
	public void userDelete(UserMst user) {
		session.update("KphUserDelete", user);
	}

	@Override
	public void userUpdate(UserMst user) {
		session.update("KphUserUpdate", user);
	}
	
}
