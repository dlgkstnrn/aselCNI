package com.aselcni.kph.model;

import lombok.Data;

@Data
public class KphOutItemItem {

	private String order_no;
	private String item_cd;
	private String outitem_no;
	private int qty;
	
	// 조회용
	private String item_nm;
	private int usable_qty;
	
}
