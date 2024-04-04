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
	private String cust_nm;
	private String order_dt;
	private String order_end_dt;
	private int    order_status_chk;
	private String item_nm;
	private int    qty;
	private String user_nm;
}
