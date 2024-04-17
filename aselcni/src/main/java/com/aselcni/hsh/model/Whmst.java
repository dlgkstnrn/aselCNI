package com.aselcni.hsh.model;

import lombok.Data;

@Data
public class Whmst {

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
    // 조회용
    private String 	search;        		private String 	keyword;
    private String 	pageNum;  			private String jjcategory;
    private int 	start;              private int 	end;
  	private int 	prevPage;			private int 	nextPage;

  	private int		report_id;// report
  	private String  reportSelect;
	private String searchFilter;

  	// Page 정보
    private String currentPage;
}
