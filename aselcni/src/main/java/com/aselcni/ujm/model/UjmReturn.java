package com.aselcni.ujm.model;

import lombok.Data;

@Data
public class UjmReturn { //반품
	private String return_no; //반품번호, PK
	private String outitem_no; //출고번호, PK, fk
	private int    return_seq_no; //순서
	private String return_dt; //반품일자
	private String cust_cd; //거래처CD(매입처), fk
	private String cust_emp; //담당자명(거래처)
	private String item_cd; //품목CD, fk
	private String res_rtn; //반품사유
	private String remark; //비고
	private String return_emp_id; //반품담당자ID
	private int    qty; //수량
	private String return_update; //반품수정일
	private int    return_delete_chk; //반품삭제여부
	private String cust_emp_phone; //거래처연락처
}