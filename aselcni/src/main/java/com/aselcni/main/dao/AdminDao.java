package com.aselcni.main.dao;

import java.util.List;

import com.aselcni.main.model.Common;
import com.aselcni.main.model.UserMst;

public interface AdminDao {

	List<Common> getAuthorityList();

	int userAdd(UserMst user);

}
