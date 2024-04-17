package com.aselcni.psa.model;

import lombok.Data;

@Data
// 생산계획 테이블
public class ProdPlan {
	
	//  생산계획 테이블
	// TB_PRODPLAN
	
	// 생산계획번호 (Foreign Key)
	private String prodplan_no;
	// 순번
	private Integer seq_no;
	// 생산시작일자
	private String prodplan_dt;
	// 생산계획완료일자
	private String prodplan_end_dt;
	// 품목CD(제품코드) (Foreign Key)
	private String item_cd;
	// 생산수량
	private Integer qty;
	// 비고
	private String remark;
	// 작업일수
	private Integer work_dt;
	// 생산계획 담당자 코드
	private String prodplan_emp_id;
	
	// 조회용 (TB_ITEMMST)
	// 제품명
	private String item_nm;
	
	// 조회용 (TB_USERMST)
	// 생산계획 담당자명
	private String user_nm;
	
	// 조회용 (TB_WORKPROD)
	// 지시총량
	private int work_total_qty;

}
