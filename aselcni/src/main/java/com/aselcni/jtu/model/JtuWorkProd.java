package com.aselcni.jtu.model;

import lombok.Data;

@Data
// 1. 생산지시 테이블
// 2. 생산지시 투입품 테이블
// 3. 생산지시 공정 테이블
// 4. 공정관리 테이블
public class JtuWorkProd {
	

	// 1. 생산지시 테이블
	// TB_WORKPROD
	
	// 생산지시번호 (Primary Key)
	// PK 규칙 : WPR + 날짜 6글자 + 날짜 기준 count 4글자
	private String workprod_no;
	// 품목CD(제품코드) (Foreign Key)
	private String item_cd;
	// 생산계획번호 (Foreign Key)
	private String prodplan_no;
	// 생산지시 담당자ID
	private String workprod_emp_id;
	// 생산시작일자
	private String workprod_dt;
	// 순번
	private Integer seq_no;
	// 생산수량
	private Integer qty;
	// 작업일수
	private Integer work_dt;
	// 작업시 주의사항
	private String work_cmd;
	// 비고
	private String remark;
	// 생산지시 수정일
	private String workprod_update;
	// 생산지시 삭제여부
	private Integer workprod_delete_chk;
	
	
	// 조회용 (TB_ITEMMST)
	// 품목명
	private String item_nm;
	
	
	// 2. 생산지시 투입품 테이블
	// TB_WORK_ITEM
	
	// 투입수량
	private Integer in_qty;
	
	
	// 3. 생산지시 공정 테이블
	// TB_WORK_PROC
	
	// 공정CD
	private String proc_cd;
	
	
	
	// 4. 공정관리 테이블
	// TB_PROCMST
	
	// 공정명
	private String proc_nm;
	
}
