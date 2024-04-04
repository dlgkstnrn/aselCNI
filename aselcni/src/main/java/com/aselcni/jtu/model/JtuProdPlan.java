package com.aselcni.jtu.model;

import lombok.Data;

@Data
// 생산계획 테이블
public class JtuProdPlan {
	
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
	private Integer work_dt;
	
	// 조회용 (TB_ITEMMST)
	// 품목명
	private String item_nm;

}
