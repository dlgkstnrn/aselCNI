package com.aselcni.ujm.model;

import lombok.Data;

@Data
public class UjmItemProd { //생산계획투입품, proditem과의 혼동으로 prodItem을 itemProd로 변경
	private String prodplan_no; //생산계획번호, PK, fk
	private String item_cd; //품목CD, fk
	private int    in_qty; //투입수량
	private int    cost; //단가(자재하나의총액)
}
