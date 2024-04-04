package com.aselcni.ujm.model;

import lombok.Data;

@Data
public class UjmProdplan { //생산계획
	private String prodplan_no; //생산계획번호, PK
	private String prodplan_dt; //생산시작일자
	private int    seq_no; //순번
	private String item_cd; //품목CD(제품), fk
	private int    qty; //생산수량
	private String remark; //비고
	private String order_no; //주문번호, fk
	private String prodplan_emp_id; //생산계획담당자ID
	private int    work_dt; //작업일수
	private String prodplan_end_dt; //생산계획완료일자
	private String prodplan_update; //생산계획수정일자
	private int    prodplan_delete_chk; //생산계획삭제여부
}
