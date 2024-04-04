package com.aselcni.jtu.model;

import lombok.Data;

@Data
// 창고 테이블
public class JtuWH {
	
	// 창고 테이블
	// TB_WHMST

	private String wh_cd;
	private String wh_nm;
	private String remark;
	
	private Integer wh_type1;
	private Integer wh_type2;
	private Integer wh_type3;
	private Integer use_flag;
	
	private String wh_regdate;
	private String wh_update;
	private String wh_emp_id;
	
	private Integer wh_delete_chk;

}
