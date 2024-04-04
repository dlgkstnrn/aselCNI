package com.aselcni.psa.model;

import lombok.Data;

@Data
public class WorkProc {
	
	// 3. 생산지시 공정 테이블
	// TB_WORK_PROC
	
	private String workprod_no;
	// 공정CD
	private String proc_cd;
	
	// 조회용
	// 공정명
	private String proc_nm;

}
