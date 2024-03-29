package com.aselcni.main.model;

import lombok.Data;

@Data
public class MenuMst {

	private String menu_id;
	private String menu_nm;
	private int seq_no;
	private String parent_id;
	private String url;
	private String icon;
	
}
