package com.aselcni.ujm.model;

import lombok.Data;

@Data
public class UjmWorkprod { //생산지시
	private String workprod_no; //생산지시번호, PK
	private String workprod_dt; //생산시작일자
	private int    seq_no; //순번
	private String item_cd; //품목CD(제품코드), fk
	private int    qty; //생산수량
	private int    work_dt; //작업일수
	private String prodplan_no; //생산계획번호, fk
	private String work_cmd; //작업시주의사항
	private String remark; //비고
	private String workprod_emp_id; //생산지시담당자ID
	private String workprod_update; //생산지시수정일
	private int    workprod_delete_chk; //생산지시삭제여부
}
