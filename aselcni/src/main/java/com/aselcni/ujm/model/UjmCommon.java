package com.aselcni.ujm.model;

import lombok.Data;

@Data
public class UjmCommon { //공통테이블
	private int    comm_code; //공통코드, PK
	private int    comm_bcd; //대분류
	private int    comm_mcd; //중분류
	private String comm_content; //컨텐츠
}
