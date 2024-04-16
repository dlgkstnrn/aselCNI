package com.aselcni.pjh.model;

import java.util.List;

import lombok.Data;

@Data
public class PJHInitem {

	private String initem_no;
	private int seq_no;
	private String  initem_dt;
	private String purc_no;
	private String cust_emp;
	private String remark;
	private String wh_cd;
	private String initem_emp_id;
	private String initem_update;
	private String initem_delete_chk;
	
	// 정보 전달용
	private List<PJHInitemItem> inItems;
	private List<PJHWhmst> whs;
	private int status;
	private String cust_nm;
	private String item_nm;
	private String start_date;
	private String end_date;
	private String initem_emp_nm;
	private String purc_emp_nm;
	private int initem_end;
	
	// page 정보
	private int startPage; // 시작 페이지
	private int endPage; // 끝 페이지
	private int start; private int rowPage; // 시작번호(0부터), 가져올 로우 수
	private String currentPage; // 현재 페이지
}
