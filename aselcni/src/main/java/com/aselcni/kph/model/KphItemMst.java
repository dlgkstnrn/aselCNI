package com.aselcni.kph.model;

import lombok.Data;

@Data
public class KphItemMst {

	private String item_cd;
	private String item_nm;
	private int item_flag;
	private String cust_cd;
	private int big_no;
	private int mid_no;
	private int sml_no;
	private String item_spec;
	private String item_unit;
	private String item_cost;
	private String remark;
	private String item_regdate;
	private String item_update;
	private String item_emp_id;
	private int item_delete_chk;
	
}
