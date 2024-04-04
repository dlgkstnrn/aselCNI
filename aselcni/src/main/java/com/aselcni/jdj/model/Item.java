package com.aselcni.jdj.model;

public class Item {
	String item_cd;			// 제품 코드
	String item_nm;			// 제품명
	int item_flag;			// 1_자재 2_제품
	String cust_cd;			// 거래처 코드 
	int big_no;				// 대분류
	int mid_no;				// 중분류
	int sml_no;				// 소분류
	String 	item_spec;		// 규격
	String item_unit;		//	단위
	int item_cost; 			//	단가, 가격
	String remark;			//	비고
	String item_regdate;	//	등록일
	String item_update;		//	수정일
	String item_emp_id;		//	품목 담당자
	int item_delete_chk;	// 삭제상태
}
