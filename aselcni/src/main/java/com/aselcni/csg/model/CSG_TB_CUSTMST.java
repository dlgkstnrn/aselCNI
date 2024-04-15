package com.aselcni.csg.model;

import lombok.Data;

@Data
public class CSG_TB_CUSTMST { //거래처
	private String  cust_cd; //거래처CD, PK
	private String  cust_nm; //거래처명
	private String  president_nm; //대표자명
	private String  biz_no; //사업자번호
	private String  biz_cond; //업종
	private String  biz_item; //업태
	private String  biz_addr; //주소
	private String  biz_tel; //전화번호
	private String  biz_fax; //팩스
	private String  emp_id; //담당자ID
	private int 	biz_flag; //01구매처 02고개가
	private String  cust_regdate; //거래처등록일
	private String  cust_update; //거래처수정일
	private int 	cust_delete_chk; //거래처삭제여부
	
	//조회용
	private String cust_emp; //담당자명(상대편)

	

}
