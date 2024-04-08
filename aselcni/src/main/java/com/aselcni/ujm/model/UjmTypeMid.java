package com.aselcni.ujm.model;

import lombok.Data;

@Data
public class UjmTypeMid { //품목중분류
	private int    mid_no; //중분류번호, PK
	private int    big_no; //대분류번호, PK, fk
	private String mid_content; //중분류내용
}
