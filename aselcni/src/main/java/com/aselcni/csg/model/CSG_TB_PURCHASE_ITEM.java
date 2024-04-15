package com.aselcni.csg.model;

import java.util.List;

import lombok.Data;

@Data
public class CSG_TB_PURCHASE_ITEM {//발주품목
	private String purc_no; //발주번호, PK, fk
	private String item_cd; //품목CD, PK, fk
	private int    qty; //수량
	private int purc_cost;// 공급가액(수량*단가)

	//발주품목에는 자재들이 여러개가 존재함
	private List<CSG_TB_ITEMMST> itemList;
}
