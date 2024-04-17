package com.aselcni.ujm.model;

import lombok.Data;

@Data
public class UjmOutitem { //출고
	private String outitem_no; //출고번호, PK
	private int    seq_no; //순번
	private String order_no; //주문번호, fk
	private String outitem_dt; //출고일자
	private String cust_cd; //거래처CD(고객사), fk
	private String cust_emp; //담당자명(거래처)
	private String remark; //비고
	private String outitem_emp_id; //출고담당자ID
	private String outitem_update; //출고수정일
	private int    outitem_delete_chk; //출고삭제여부
	
	
	// 조회용
	private String 	search;
	private String 	keyword;
	private String 	pageNum;
	private int 	start;
	private int 	end;
	
	// Page 정보
	private String 	currentPage; //유일하게 Page 객체에도
	
	//조인
	private String cust_nm; //고객사이름
	private String order_dt; //주문일자
	private String order_end_dt; //주문만료일
	private int    order_status_chk; //주문상태
	private String item_nm; //품목명 (출고품목)
	private int    qty; //출고하는 상품별 수량
	private String user_nm; //출고담당자(입력)
	
	//상품명과 주문개수 중복표시
	private String items; //출고제품
	
	//상세(조회)에서 사용
	private String outitem_qty; //출고수량(품목별)
	private String remain_qty; //주문수량-출고수량
	private int    stock; //재고
	private String order_qty; //주문에서 출고된 수량
	
	//수정버튼 눌렀을 때 가져오는 것 : 혼동 피하기 위해 기존의 것들과 다르게 이름 변경
	private int old_order_qty; //주문수량
	private int old_qty; //기존에 출고했던 수량, 상세에서의 outitem_qty와 같음
	private int outitem_sum_qty; //같은 주문번호의 품목에서 출고되었던 수량의 합, 상세에서의 order_qty와 같음
}
