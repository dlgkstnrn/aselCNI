package com.aselcni.main.service;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.springframework.stereotype.Service;

import com.aselcni.main.dao.MainDao;
import com.aselcni.main.model.MenuMst;
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

	@Override
	public List<List<MenuMst>> menuListGroupByMenu(int user_comm_code) {
		System.out.println(user_comm_code);
		List<String> menuGroupList = mainDao.menuGroupListByUserCommCode(user_comm_code);
		Iterator<String> menuGroupListIt = menuGroupList.iterator();
		
		List<List<MenuMst>> menuListGroupByMenu = new ArrayList<>();
		while(menuGroupListIt.hasNext()) {
			String menuGroup = menuGroupListIt.next();
			List<MenuMst> menuList = mainDao.menuListByMenuId(menuGroup);
			menuListGroupByMenu.add(menuList);
		}
		
		return menuListGroupByMenu;
	}

}
