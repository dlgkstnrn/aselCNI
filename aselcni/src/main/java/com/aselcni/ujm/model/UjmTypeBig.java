package com.aselcni.ujm.model;

import lombok.Data;

@Data
public class UjmTypeBig { //품목대분류
	private int    big_no; //대분류번호, PK
	private String big_content; //대분류내용
}
