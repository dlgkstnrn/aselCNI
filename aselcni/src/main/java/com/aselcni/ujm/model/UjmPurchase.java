package com.aselcni.ujm.model;

import lombok.Data;

@Data
public class UjmPurchase { //발주
	private String purc_no; //발주번호, PK
	private String purc_dt; //발주일자
	private String cust_cd; //거래처CD(매입처), fk
	private String cust_emp; //담당자명(상대편)
	private String remark; //비고
	private String purc_emp_id; //발주담당자ID
	private String purc_update; //발주수정일
	private int    purc_delete_chk; //발주삭제여부
	private int    purc_status_chk; //발주상태
}
