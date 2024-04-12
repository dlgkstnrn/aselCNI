package com.aselcni.jtu.model;

import lombok.Data;

@Data
// 생산실적_불량 테이블
public class JtuProdItemBad {
	
	// 생산실적_불량 테이블
	// TB_PRODITEM_BAD
	
	// 생산 실적 번호 (Primary Key, Foreign)
	private String proditem_no;
	
	// 불량 코드 (Primary Key, Foreign)
	private String bad_cd;
	
	// 불량 코드 내역
	private String bad_res;

}
