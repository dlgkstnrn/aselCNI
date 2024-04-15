package com.aselcni.kdw.model;

import lombok.Data;

@Data
public class TB_PRODPLAN {
    private  String prodPlan_no; 		 // 생산계획번호
    private  String prodPlan_dt; 		 // 생산시작일자
    private     int seq_no;		 		 // 순번
    private  String item_cd;	 		 // 제품코드
    private     int qty;		 		 // 제품수량
    private  String remark;		 		 // 비고
    private  String order_no;			 // 주문번호
    private  String prodplan_emp_id;	 // 생산계획담당자ID
    private     int work_dt;	 		 // 작업일수
    private  String prodPlan_end_dt;	 // 생산계획완료일자
    private  String prodPlan_update;	 // 생산계획수정일자
    private Boolean prodPlan_delete_chk; // 생산계획삭제체크
    
    // 저장용
    private String prodplan_emp_name;	 // 생산계획담당자이름
	private String item_nm;		// 제품자재명
	private    int item_cost;   // 제품가격
	private String cust_nm;		// 고객사
}
