package com.aselcni.ujm.model;

import lombok.Data;

@Data
public class UjmOrderItem { //주문품목
	private String order_no; //주문번호, PK, fk
	private String item_cd; //품목CD, PK, fk
	private int    qty; //수량
	private int	   cost; //단가(자재하나의총액)
}
