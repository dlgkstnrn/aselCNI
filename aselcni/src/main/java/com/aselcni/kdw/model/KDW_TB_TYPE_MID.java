package com.aselcni.kdw.model;

import lombok.Data;

@Data
public class KDW_TB_TYPE_MID {

	private    int big_no; 		// 대분류 넘버
	private    int mid_no; 		// 중분류 넘버
	private String mid_content; // 중분류 옵션
	
}