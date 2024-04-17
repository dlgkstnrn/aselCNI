package com.aselcni.kph.model;

import lombok.Data;

@Data
public class KphCustMst {
	
	private String cust_cd;
	private String cust_nm;
	private String president_nm;
	private String biz_no;
	private String biz_cond;
	private String biz_item;
	private String biz_addr;
	private String biz_tel;
	private String biz_fax;
	private String emp_id;
	private int biz_flag;
	private String cust_regdate;
	private String cust_update;
	private int cust_delete_chk;
	
	// 조회용
	private String keyword;
	
}