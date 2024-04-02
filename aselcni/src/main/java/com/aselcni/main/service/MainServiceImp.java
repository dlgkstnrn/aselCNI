package com.aselcni.main.service;

import org.springframework.stereotype.Service;

import com.aselcni.main.dao.MainDao;
import com.aselcni.main.model.UserMst;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MainServiceImp implements MainService {
	
	private final MainDao mainDao;

	@Override
	public UserMst getUser(UserMst user) {
		UserMst resultUser = mainDao.getUser(user);
		return resultUser;
	}

}
