package com.aselcni.csg.model;

import java.util.List;

import lombok.Data;

@Data
public class CSG_TB_TYPE_MID {
	
	private int MID_NO; //중분류번호  복합키
	private int BIG_NO;	//대분류번호  복합키
	private String MID_CONTENT;

}
