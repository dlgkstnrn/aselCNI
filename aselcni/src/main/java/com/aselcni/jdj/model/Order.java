package com.aselcni.jdj.model;

import java.util.HashMap;
import java.util.List;

import lombok.Data;

@Data
public class Order {
//	order 테이블
	private String order_no;			// 주문번호, 주문코드
	private String order_dt;			// 주문날짜
	private String cust_cd;				// 고객처 번호, 코드
	private String cust_emp;			// 고객처 담당 직원명
	private String remark;				// 비고
	private String order_emp_id; 		// 담당 사원 ID
	private String order_update;		// 주문 수정일
	private int order_delete_chk;	// 주문 삭제 여부
	private int order_status_chk;	// 주문 상태,
								// 0(주문등록), 
								// 1(주문진행, 1개이상 출고 되었을때), 
								// 2(출고 완료)
	
	private String order_end_dt; 		// 주문마감일, 출고를 맞춰야하는 기간
	private String order_sec_no; 	// 변환한 주문 번호
	
	
//  custMst 일부
	private String cust_nm; 			// 고객처 상호명

//	userMst 일부
	private String user_nm;		// 담당 직원명
	
//  클라이언트한테 받을때 한 주문에 해당하는 아이들의 정보
	private List<HashMap<String, OrderItem>> order_items;


}
