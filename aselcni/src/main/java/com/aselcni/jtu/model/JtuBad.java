package com.aselcni.jtu.model;

import lombok.Data;

@Data
// 불량 테이블
public class JtuBad {
	
	// 불량 테이블
	// TB_BAD
	
	// 불량 코드 (Primary Key)
	private String bad_cd;
	// 불량 내역
	private String bad_res;
	
	//조회용
	private String badCdKeyword;
	
	private String badResKeyword;
	
}
