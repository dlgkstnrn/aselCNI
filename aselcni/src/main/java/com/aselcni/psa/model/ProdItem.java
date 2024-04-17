package com.aselcni.psa.model;

import lombok.Data;

@Data
public class ProdItem {
	

	// 생산계획 투입품 테이블
	// TB_ITEM_PROD
	
	private String prodplan_no;
	private String item_cd;
	
	// 투입수량
	private Integer in_qty;
		
	// 조회용
	// 투입품명
	private String item_nm;
	
}
