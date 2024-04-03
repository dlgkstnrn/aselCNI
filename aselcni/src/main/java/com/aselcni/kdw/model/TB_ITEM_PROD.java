package com.aselcni.kdw.model;

import lombok.Data;

@Data
public class TB_ITEM_PROD {

	private String prodPlan_no; // 생산계획번호
	private String item_cd;		// 투입자재코드
	private    int in_qty;		// 투입자재수량
	private	   int cost;		// 투입자재가격(아이템테이블에서 가져와서 할것)
	// 저장용
	private String item_nm;		// 투입자재명
	private    int item_cost;   // 투입자재가격
}
