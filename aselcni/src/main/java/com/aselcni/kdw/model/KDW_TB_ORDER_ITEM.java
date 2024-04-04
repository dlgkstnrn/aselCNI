package com.aselcni.kdw.model;

import lombok.Data;

@Data
public class KDW_TB_ORDER_ITEM {

	private String order_no; 		 // 주문코드
	private String item_cd; 		 // 제품코드
	private	   int qty;				 // 제품수량
	private    int cost;			 // 제품가격
	
	// 저장용
	private String item_nm; //아이템이름저장용
}