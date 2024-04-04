package com.aselcni.ujm.model;

import lombok.Data;

@Data
public class UjmWh { //창고
	private String wh_cd; //창고CD, PK
	private String wh_nm; //창고명
	private String remark; //비고(설명)
	private int    wh_type1; //자재창고(1맞음0틀림)
	private int    wh_type2; //제품창고
	private int    wh_type3; //반품창고
	private int    use_flag; //사용여부
	private String wh_regdate; //창고등록일
	private String wh_update; //창고수정일
	private String wh_emp_id; //창고담당자ID
	private int wh_delete_chk; //창고삭제여부
}
