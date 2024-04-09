package com.aselcni.csg.model;

import java.util.List;

import lombok.Data;

@Data
public class CSG_TB_PURCHASE { //발주테이블
	private String purc_no; //발주번호, PK
	private String purc_dt; //발주일자
	private String cust_cd; //거래처CD(매입처), fk
	private String cust_emp; //담당자명(상대편)
	private String remark; //비고
	private String purc_emp_id; //발주담당자ID
	private String purc_update; //발주수정일
	private int    purc_delete_chk; //발주삭제여부
	private int    purc_status_chk; //발주상태 0:발주 1:1개라도 입고 2: 입고모두완료
	
	
	//조회용
	private int purc_cost;// 공급가액(수량*단가)
	private int item_flag;	//플래그 01이면 자재, 02면 제품
	private String item_nm; //품목명
	private String cust_nm;
	private int    qty; //수량
	private int item_cost; //단가
	private String start_date; //날짜계산을 할때만 data가 좋고 Date는 String이 좋음
	private String end_date;	//날짜계산을 하려면 String으로 넣고 그냥 형변환을 하는게 좋음
	private String item_cd; //품목CD, PK, fk

	//page 정보
	private int start;
	private int end;
	private String currentPage;
	
	private List<CSG_TB_PURCHASE_ITEM> csgPurItemList;



}
