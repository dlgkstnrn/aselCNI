package com.aselcni.ujm.model;

import lombok.Data;

@Data
public class UjmPurchaseItem { //발주품목
	private String purc_no; //발주번호, PK, fk
	private String item_cd; //품목CD, PK, fk
	private int    qty; //수량
}
