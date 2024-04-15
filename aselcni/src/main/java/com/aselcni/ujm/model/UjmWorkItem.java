package com.aselcni.ujm.model;

import lombok.Data;

@Data
public class UjmWorkItem { //생산지시투입품 (bom, 수율 관련)
	private String workprod_no; //생산지시번호, PK, fk
	private String item_cd; //품목CD, PK, fk
	private int    in_qty; //투입수량
	private int    cost; //단가(자재하나의총액)
}
