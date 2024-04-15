package com.aselcni.csg.model;

import lombok.Data;

@Data
//품목 테이블
public class CSG_TB_ITEMMST {
	private String item_cd; //품목CD pk
	private String item_nm; //품목명
	private int item_flag;	//플래그 01이면 자재, 02면 제품
	private String cust_cd;	// 거래처 CD, FK
	private int big_no;	// 대분류번호 FK
	private int mid_no;	//중분류번호 FK 
	private int sml_no;	//소분류번호 FK
	private String item_spec; ///규격
	private String item_unit; //단위
	private String item_cost; //단가(가격)
	private String remark; //비고
	
	//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	private String item_regdate; //품목 등록일
	private String item_update;	//품목 수정일
	//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

	
	private String purc_emp_id; //품목담당자 ID
	private int item_delete_chk; //품목삭제여부
	
	private String purc_no; //발주번호, PK, fk
	private int    qty; //수량
	private int purc_cost;// 공급가액(수량*단가)
	
}
