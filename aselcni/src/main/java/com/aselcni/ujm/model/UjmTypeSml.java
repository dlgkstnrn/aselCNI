package com.aselcni.ujm.model;

import lombok.Data;

@Data
public class UjmTypeSml { //품목소분류
	private int    sml_no; //소분류번호, PK
	private int    mid_no; //중분류번호, PK, fk
	private int    big_no; //대분류번호, PK, fk
	private String sml_content; //소분류내용
}
