package com.aselcni.jdj.model;

import lombok.Data;

@Data
public class OrderItem {
	
	private String order_no;
	private String item_cd;	// 제품코드
	private int qty;		// 수량
	private int cost;		// 가격
	
	// itemMst 일부 -> for 주문상세
	private String item_nm;
	private String item_unit;
	private int item_cost; 
	
}
