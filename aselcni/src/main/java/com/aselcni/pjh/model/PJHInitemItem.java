package com.aselcni.pjh.model;

import lombok.Data;

@Data
public class PJHInitemItem {
	private String initem_no;
	private String purc_no;
	private String item_cd;
	private int qty;
	
	// 조회용
	private String item_nm;
	private String item_spec;
	private String item_unit;
	private Integer item_cost;
	private int required_stock;
	private int add_max;
}
