package com.aselcni.lhs.model;

import lombok.Data;

@Data
public class ItemMst {
	private String item_cd;
	private String item_nm;
	private int item_flag;
	private String cust_cd;
	private int big_no;
	private int mid_no;
	private int sml_no;
	private String item_spec;
	private String item_unit;
	private int item_cost;
	private String remark;
	private String item_regdate;
	private String item_update;
	private String item_emp_id;
	private int item_delete_chk;
	
	//----------------조회용-------------------
	private String currentPage;
	private int start;
	private int end;
	private String keyword;
	private String searchFilter;
	private String cust_nm;
}
