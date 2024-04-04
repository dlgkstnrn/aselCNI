package com.aselcni.pjh.model;

import lombok.Data;

@Data
public class PJHPurchaseItem {
	private String purc_no;
	private String item_cd;
	private int qty;
	private int purc_cost;
	
	//정보전달용
	private String item_nm;
	private String item_spec;
	private String item_unit;
}
