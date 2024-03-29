package com.aselcni.main.service;

import java.util.List;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.aselcni.main.dao.AdminDao;
import com.aselcni.main.model.Common;
import com.aselcni.main.model.UserMst;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AdminServiceImp implements AdminService {

	private final AdminDao adminDao;
	private final BCryptPasswordEncoder bCryptPasswordEncoder;

	@Override
	public List<Common> getAuthorityList() {
		List<Common> userAuthorityList = adminDao.getAuthorityList();
		return userAuthorityList;
	}

	@Override
	public int userAdd(UserMst user) {
		user.setUser_pw(bCryptPasswordEncoder.encode(user.getUser_pw()));
		int result = adminDao.userAdd(user);
		return result;
	}
	
}
