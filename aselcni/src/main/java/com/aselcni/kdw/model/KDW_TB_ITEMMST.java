package com.aselcni.kdw.model;

import lombok.Data;

@Data
public class KDW_TB_ITEMMST {

	private String item_cd; // 품목코드
	private String item_nm; // 품목명
	private    int item_flag; // 1-자재 / 2-제품
	private String cust_cd; // 거래처코드
	private    int big_no; // 대분류번호
	private    int mid_no; // 중분류번호
	private    int sml_no; // 소분류번호
	private String item_spec; // 규격
	private String item_unit; // 단위
	private    int item_cost; // 단가(가격)
	private String remark; // 비고
	private String item_regdate; // 품목등록일
	private String item_update; // 품목수정일
	private String item_emp_id; // 품목담당자 id
	private    int item_delete_chk; // 삭제상태 0: 정상 1: 삭제 
	
}