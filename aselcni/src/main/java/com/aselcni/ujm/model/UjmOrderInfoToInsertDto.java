package com.aselcni.ujm.model;

import lombok.Data;

@Data
public class UjmOrderInfoToInsertDto { //출고 등록에서, 선택한 주문번호에 따른 정보들 가져오기용

	private String order_no; //주문번호
	private String order_dt; //주문일
	private String order_end_dt; //주문마감일
	private String cust_cd; //거래처코드
	private String cust_nm; //거래처이름
	
	//Outitem_item과 조인
	private String item_cd; //품목코드 (주문품목)
	private String item_nm; //품목이름
	private String qty; //품목량(주문품목, 주문한 품목량)
	
	private int    order_status_chk; //주문상태. 0또는 2만 가능
	
}
