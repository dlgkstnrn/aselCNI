package com.aselcni.csg.model;

import java.util.List;

import lombok.Data;

@Data
public class CSG_TB_TYPE_MID {
	
	private int mid_no; //중분류번호  복합키
	private int big_no;	//대분류번호  복합키
	private String mid_content;
	
	//조회용
	private String cust_cd; //거래처 코드

}
