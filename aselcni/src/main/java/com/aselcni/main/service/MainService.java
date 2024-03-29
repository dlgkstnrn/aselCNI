package com.aselcni.main.service;

import java.util.List;

import com.aselcni.main.model.MenuMst;
import com.aselcni.main.model.UserMst;

public interface MainService {

	UserMst getUser(UserMst user);

	List<List<MenuMst>> menuListGroupByMenu(int user_comm_code);

}
