package com.aselcni.pjh.model;

import lombok.Data;

@Data
public class PJHPurchase {
	private String purc_no;
	private String purc_dt;
	private String cust_cd;
	private String cust_emp;
	private int purc_cost;
	private String remark;
	private String purc_emp_id;
	private String purc_update;
	private int purc_delete_chk;
	private int purc_status_chk;
	
	// 조회용
	private String period;
	private String cust_nm;
}
