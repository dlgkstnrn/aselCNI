package com.aselcni.ujm.model;

import lombok.Data;

@Data
public class UjmItem { //품목
	private String  item_cd; //품목CD, PK
	private String  item_nm; //품목명
	private int 	item_flag; //01자재 02제품
	private String 	cust_cd; //거래처CD, fk
	private int 	big_no; //대분류번호, fk
	private int 	mid_no; //중분류번호, fk
	private int 	sml_no; //소분류번호, fk
	private String  item_spec; //규격
	private String  item_unit; //단위
	private int     item_cost; //단가(가격)
	private String  remark; //비고
	private String  item_regdate; //품목등록일
	private String  item_update; //품목수정일
	private String  item_emp_id; //품목담당자ID
	private int 	item_delete_chk; //품목삭제여부
}
