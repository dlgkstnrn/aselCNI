package com.aselcni.ujm.model;

import lombok.Data;

@Data
public class UjmMenu { //메뉴테이블
	private String menu_id; //메뉴ID, PK
	private String menu_nm; //메뉴명
	private int    seq_no; //순서
	private String parent_id; //모메뉴ID
	private String url; //매핑URL
	private String icon; //아이콘
}
