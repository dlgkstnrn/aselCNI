package com.aselcni.hsh.model;

import lombok.Data;

@Data
public class Procmst {

	private String proc_Cd; // 공정CD
    private String proc_Nm; // 공정명
    private String remark; // 비고(설명)
    private Integer use_Flag; // 사용여부
    private String proc_Emp_Id; // 공정담당자 ID
    private String proc_Regdate; // 공정등록일
    private String proc_Update; // 공정수정일
    private Integer proc_Delete_Chk; // 공정삭제여부

	
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
