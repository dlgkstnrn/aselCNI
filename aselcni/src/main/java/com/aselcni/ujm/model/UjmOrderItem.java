package com.aselcni.ujm.model;

import lombok.Data;

@Data
public class UjmOrderItem { //주문품목
	private String order_no; //주문번호, PK, fk
	private String item_cd; //품목CD, PK, fk
	private int    qty; //수량
	private int	   cost; //단가(자재하나의총액)
	
	//조인용
	private String item_nm; //제품명, tb_itemmst와 조인
	private int    stock;  //재고, 프로시저 사용
	private int    remain_qty; //남은 주문량 (품목별)
}
