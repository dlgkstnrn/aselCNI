package com.aselcni.ujm.model;

import lombok.Data;

@Data
public class UjmOrderInfoToInsertDto { //출고 등록에서, 선택한 주문번호에 따른 정보들 가져오기용

	private String order_no; //주문번호
	private String order_dt; //주문일
	private String order_end_dt; //주문마감일
	private String cust_cd;
	private String cust_nm;
	
	//Outitem_item과 조인
	private String item_cd;
	private String item_nm;
	private String qty;
	
	private int    order_status_chk;
	
	private String user_nm;
	
}
