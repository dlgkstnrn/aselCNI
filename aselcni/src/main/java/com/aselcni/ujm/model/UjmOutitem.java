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
	
	//조회에서 사용
	private String outitem_qty;
	private String remain_qty;
	private int    stock;
}
