package com.aselcni.jdj.model;

import lombok.Data;

@Data
public class CustMst {

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
	private String cust_regdate;
	private String cust_update;
	private int cust_delete_chk;
	private int biz_flag;
}
