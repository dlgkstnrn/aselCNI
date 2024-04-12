package com.aselcni.jtu.model;

import java.util.List;

import lombok.Data;

@Data
// 1. 생산지시 테이블
// 2. 생산지시 투입품 테이블
// 3. 생산지시 공정 테이블
// 4. 공정관리 테이블
public class JtuProdItem {
	

	// 1. 생산지시 테이블
	// TB_PRODITEM
	
	
	// PK 규칙 : WPR + 날짜 6글자 + 날짜 기준 count 4글자
	
	// 생산지시번호 (Primary Key)
	private String proditem_no;
	
	// 생산 지시 번호CD(Foreign Key)
	private String workprod_no;
	
	// 생산완료일자
	private String proditem_end_dt;
	
	// 품목코드-제품코드 (Foreign Key)
	private String item_cd;
	
	// 예정생산수량
	private Integer pln_qty;
	
	// 실제생산수량
	private Integer prod_qty;
	
	// 불량생산수량
	private Integer bad_qty;

	// 비고
	private String remark;
	
	// 창고 코드 (Foreign Key)
	private String wh_cd;
	
	// 생산실적 담당자ID
	private String proditem_emp_id;
	
	// 생산실적 수정일
	private String proditem_update;
	
	// 생산지시 삭제여부
	private Integer proditem_delete_chk;
	
	
	// 조회용
	// 불량 코드
	private String bad_cd;
	// 불량 내역
	private String bad_res;

	// 창고명
	private String wh_nm;
	// 창고 리스트
	private List<JtuWH> whList;
	
	// 품목명
	private String item_nm;
	// 01자재02제품
	private Integer item_flag;
//	// 대분류번호
//	private Integer big_no;
//	// 대분류내용
//	private String big_content;
//	// 중분류번호
//	private Integer mid_no;
//	// 중분류내용
//	private String mid_content;
//	// 소분류번호
//	private Integer sml_no;
//	// 소분류내용
//	private String sml_content;

	
	//검색용
	private String startDate;
	private String endDate;
	private String whNoAndNameKeyword;
	private String itemNoAndNameKeyword;
	
	//paging
	private Integer currentPage;
	private Integer startPage;
	private Integer endPage;
	private Integer start;
	private Integer end;
	private Integer rowPage;
	
	//다대다
	private List<JtuProdItemBad> jpriBadList;
	

	
}
