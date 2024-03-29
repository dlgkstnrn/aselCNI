package com.aselcni.main.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.aselcni.main.model.MenuMst;
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

	@Override
	public List<String> menuGroupListByUserCommCode(int user_comm_code) {
		return session.selectList("KphMenuGroupListByUserCommCode", user_comm_code);
	}
	
	@Override
	public List<MenuMst> menuListByMenuId(String menuGroup) {
		return session.selectList("KphMenuListByMenuId", menuGroup);
	}

}
