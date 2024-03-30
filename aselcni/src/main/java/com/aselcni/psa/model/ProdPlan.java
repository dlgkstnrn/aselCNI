package com.aselcni.psa.model;

import lombok.Data;

@Data
// 생산계획 테이블
public class ProdPlan {
	
	//  생산계획 테이블
	// TB_PRODPLAN
	
	// 생산계획번호 (Foreign Key)
	private String prodplan_no;
	// 생산시작일자
	private String prodplan_dt;
	// 품목CD(제품코드) (Foreign Key)
	private String item_cd;
	// 생산수량
	private Integer qty;
	// 작업일수
	private Integer word_dt;

}