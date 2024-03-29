package com.aselcni.ujm.model;

import lombok.Data;

@Data
public class UjmMenuAuthority { //메뉴권한
	private int    comm_code; //유저권한공통코드, PK, fk
	private String menu_id; //메뉴ID, PK, fk
}
