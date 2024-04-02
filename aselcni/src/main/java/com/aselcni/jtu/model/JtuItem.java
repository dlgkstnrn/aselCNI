package com.aselcni.jtu.model;

import lombok.Data;

@Data
// 품목 테이블
public class JtuItem {
	
	// 품목 테이블
	// TB_ITEMMST

	// 품목CD
	private String item_cd;
	// 품목명
	private String item_nm;
	// 대분류번호
	private Integer big_no;
	// 중분류번호
	private Integer mid_no;
	// 소분류번호
	private Integer sml_no;
	
}
