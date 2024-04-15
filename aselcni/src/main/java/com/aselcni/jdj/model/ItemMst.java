package com.aselcni.jdj.model;

import lombok.Data;

@Data
public class ItemMst {
	private String item_cd;			// 제품 코드
	private String item_nm;			// 제품명
	private int item_flag;			// 1_자재 2_제품
	private String cust_cd;			// 거래처 코드 
	private int big_no;				// 대분류
	private int mid_no;				// 중분류
	private int sml_no;				// 소분류
	private String 	item_spec;		// 규격
	private String item_unit;		//	단위
	private int item_cost; 			//	단가, 가격
	private String remark;			//	비고
	private String item_regdate;	//	등록일
	private String item_update;		//	수정일
	private String item_emp_id;		//	품목 담당자
	int item_delete_chk;	// 삭제상태
}
