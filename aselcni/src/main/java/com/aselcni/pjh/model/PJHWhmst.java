package com.aselcni.pjh.model;

import lombok.Data;

@Data
public class PJHWhmst {
	private String wh_cd;
	private String wh_nm;
	private String remark;
	private int wh_type1;
	private int wh_type2;
	private int wh_type3;
	private int use_flag;
	private String wh_regdate;
	private String wh_update;
	private String wh_emp_id;
	private int wh_delete_chk;
}
