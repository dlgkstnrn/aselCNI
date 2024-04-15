package com.aselcni.kdw.model;

import lombok.Data;

@Data
public class KDW_TB_ORDER {

	private String order_no; 		 // 주문코드
	private String order_dt; 		 // 주문일자
	private String cust_cd;	 		 // 고객사 코드
	private String cust_emp; 		 // 고객사 담당자명
	private String remark;	 		 // 비고
	private String order_emp_id; 	 // 주문 담당자 코드
	private String order_update; 	 // 주문 수정일
	private    int order_delete_chk; // 주문 삭제 여부
	private    int order_status_chk; // 주문 상태
	private String order_end_dt; 	 // 주문 종료일자
	private String order_sec_no; 	 // 주문 순서
	
	// 저장용
	private String cust_nm; // 고객사
}