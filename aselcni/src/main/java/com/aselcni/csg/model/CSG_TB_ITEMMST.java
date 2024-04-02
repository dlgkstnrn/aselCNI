package com.aselcni.csg.model;

import lombok.Data;

@Data
//품목 테이블
public class CSG_TB_ITEMMST {
	private String ITEM_CD; //품목CD pk
	private String ITEM_NM; //품목명
	private int ITEM_FLAG;	//플래그 01이면 자재, 02면 제품
	private String CUST_CD;	// 거래처 CD, FK
	private int BIG_NO;	// 대분류번호 FK
	private int MID_NO;	//중분류번호 FK 
	private int SML_NO;	//소분류번호 FK
	private String ITEM_SPEC; ///규격
	private String ITEM_UNIT; //단위
	private String ITEM_COST; //단가(가격)
	private String REMARK; //비고
	
	//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	private String ITEM_REGDATE; //품목 등록일
	private String ITEM_UPDATE;	//품목 수정일
	//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

	
	private String PURC_EMP_ID; //품목담당자 ID
	private int ITEM_DELETE_CHK; //품목삭제여부
	
}
