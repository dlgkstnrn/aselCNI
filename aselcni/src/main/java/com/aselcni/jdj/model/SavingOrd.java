package com.aselcni.jdj.model;

import java.util.HashMap;
import java.util.List;

import lombok.Data;

@Data
public class SavingOrd {
	private String order_dt;			// 주문날짜
	private String order_end_dt; 		// 주문마감일, 출고를 맞춰야하는 기간
	private String order_emp_id; 		// 담당 사원 ID
	private String cust_emp;			// 고객처 담당 직원명
	private String cust_cd;				// 고객처 코드
	private String remark;
	
	
	//saveOrd로 post요청 받았을때 order_items가 담겨있음
//	private List<HashMap<String, SavingOrdItem>> order_items;
	private List<HashMap<String, OrderItem>> order_items;
//	private List<SavingOrdItem> order_items;
}
