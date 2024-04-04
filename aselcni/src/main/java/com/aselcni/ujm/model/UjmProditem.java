package com.aselcni.ujm.model;

import lombok.Data;

@Data
public class UjmProditem { //생산실적
	private String workprod_no; //생산지시번호, PK, fk
	private String proditem_end_dt; //생산종료일자
	private String item_cd; //품목CD, fk
	private int    pln_qty; //생산예졍수량
	private int    prod_qty; //생산수량
	private int    bad_qty; //불량수량
	private String bad_res; //불량내역
	private String remark; //비고
	private String wh_cd; //창고CD, fk
	private String proditem_emp_id; //생산실적담당자ID
	private String proditem_update; //생산실적수정일
	private int    proditem_delte_chk; //생산실적삭제여부
}
