package com.aselcni.kph.model;

import lombok.Data;

@Data
public class KphReturn {

	private String return_no;
	private String outitem_no;
	private int return_seq_no;
	private String return_dt;
	private String cust_cd;
	private String cust_emp;
	private String item_cd;
	private String res_rtn;
	private String remark;
	private String return_emp_id;
	private String qty;
	private String return_update;
	private String return_delete_chk;
	
	// 조회용
	private String currentPage;
	private int start;
	private int end;
	private String keyword;
	private String searchFilter;
	private String start_day;
	private String end_day;
	private String cust_nm;
	private String item_nm;
	private String return_emp_nm;
	private int max_qty; 
	
}