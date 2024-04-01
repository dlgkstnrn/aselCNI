package com.aselcni.main.model;

import lombok.Data;

@Data
public class UserMst {

	private String user_id;
	private String user_nm;
	private String user_pw;
	private String user_phone;
	private String user_tel;
	private String user_email;
	private String user_regdate;
	private String user_update;
	private int user_comm_code;
	private int user_delete_check;
	
	// 조회용
	private String comm_content; 
	private String currentPage;
	private int start;
	private int end;
	private String keyword;
	private String searchFilter;
	
}
