package com.aselcni.ujm.model;

import lombok.Data;

@Data
public class UjmWorkProc { //생산지시공정테이블
	private String workprod_no; //생산지시번호, PK, fk
	private String proc_cd; //공정CD, PK, fk
}
