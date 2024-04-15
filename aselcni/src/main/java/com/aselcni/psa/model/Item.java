package com.aselcni.psa.model;

import lombok.Data;

@Data
// 품목 테이블
public class Item {
	
	// 품목 테이블
	// TB_ITEMMST

	// 품목CD
	private String item_cd;
	// 품목명
	private String item_nm;
	
	// 대분류번호
	private Integer big_no;
	// 대분류내용
	private String big_content;

	// 중분류번호
	private Integer mid_no;
	// 중분류내용
	private String mid_content;
	
	// 소분류번호
	private Integer sml_no;
	// 소분류내용
	private String sml_content;
	
}
