package com.aselcni.main.dao;

import java.util.List;

import com.aselcni.main.model.MenuMst;
import com.aselcni.main.model.UserMst;

public interface MainDao {

	UserMst getUser(UserMst user);

	List<String> menuGroupListByUserCommCode(int user_comm_code);

	List<MenuMst> menuListByMenuId(String menuGroup);

}
