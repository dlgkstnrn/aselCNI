package com.aselcni.kph.model;

import lombok.Data;

@Data
public class KphOutItem {

	private String outitem_no;
	private int seq_no;
	private String order_no;
	private String outitem_dt;
	private String cust_cd;
	private String cust_emp;
	private String item_cd;
	private int outitem_qty;
	private String remark;
	private String outitem_emp_id;
	private String outitem_update;
	private int outitem_delete_chk;
	
	// 조회용
	private String keyword;
	private String searchFilter;
	private String dateSearchFilter;
	
}
