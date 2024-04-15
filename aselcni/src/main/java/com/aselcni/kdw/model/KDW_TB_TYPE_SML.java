package com.aselcni.kdw.model;

import lombok.Data;

@Data
public class KDW_TB_TYPE_SML {

	private    int big_no;		// 대분류 넘버
	private    int mid_no;		// 중분류 넘버
	private    int sml_no;		// 소분류 넘버
	private String sml_content; // 소분류 옵션
	
}