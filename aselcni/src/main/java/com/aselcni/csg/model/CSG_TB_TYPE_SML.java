package com.aselcni.csg.model;

import lombok.Data;

@Data
public class CSG_TB_TYPE_SML {
	
	private int sml_no; //소분류번호 pk - 복합키
	private int mid_no;	//중분류 번호 복합키
	private int big_no; //대분류 번호 복합키 
	private String sml_content; //소분류 내용
	
	//조회용
	private String cust_cd; //거래처 코드

}
