package com.aselcni.kdw.model;

import lombok.Data;

@Data
public class TB_ITEM_PROD {

	private String prodPlan_no; // 생산계획번호
	private String item_cd;		// 투입자재명
	private    int in_qty;		// 투입자재수량
}
