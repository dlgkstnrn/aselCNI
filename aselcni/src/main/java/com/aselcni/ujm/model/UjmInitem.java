package com.aselcni.ujm.model;

import lombok.Data;

@Data
public class UjmInitem { //입고
	private String initem_no; //입고번호, PK
	private int    seq_no; //순번
	private String initem_dt; //입고일자
	private String purc_no; //발주번호, fk
	private String cust_emp; //담당자명(상대편)
	private String remark; //비고
	private String wh_cd; //창고CD, fk
	private String initem_emp_id; //입고담당자ID
	private String initem_update; //입고수정일
	private int    initem_delete_chk; //입고삭제여부
}
