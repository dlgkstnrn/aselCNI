package com.aselcni.ujm.model;

import lombok.Data;

@Data
public class UjmComp { //사업장
	private String comp_busi_no; //사업자번호, PK
	private String comp_nm; //사업장
	private String comp_president_nm; //대표자명
	private String comp_cond; //종목
	private String comp_item; //업태
	private String comp_addr; //주소
	private String comp_tel; //전화번호
	private String comp_fax; //팩스
	private byte[] comp_image; //이미지
	private String comp_update; //사업장수정일
}
