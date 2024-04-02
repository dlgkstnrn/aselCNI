package com.aselcni.csg.model;

import lombok.Data;

@Data
public class CSG_TB_TYPE_SML {
	
	private int SML_NO; //소분류번호 pk - 복합키
	private int MID_NO;	//중분류 번호 복합키
	private int BIG_NO; //대분류 번호 복합키 
	private String SML_CONTENT; //소분류 내용

}
