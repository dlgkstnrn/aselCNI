package com.aselcni.ujm.model;

import lombok.Data;

@Data
public class UjmOutitem { //출고
	private String outitem_no; //출고번호, PK
	private int    seq_no; //순번
	private String order_no; //주문번호, fk
	private String outitem_dt; //주문일자
	private String cust_cd; //거래처CD(고객사), fk
	private String cust_emp; //담당자명(거래처)
	private String item_cd; //품목CD, fk
	private int    outitem_qty; //출고수량
	private String remark; //비고
	private String outitem_emp_id; //출고담당자ID
	private String outitem_update; //출고수정일
	private int    outitem_delete_chk; //출고삭제여부
}
