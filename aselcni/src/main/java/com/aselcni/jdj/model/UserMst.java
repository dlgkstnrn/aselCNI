package com.aselcni.jdj.model;

import lombok.Data;

@Data
public class UserMst {
	
	private String user_id;			// 사원 ID
	private String user_nm;			// 사원명
	private String user_phone;		// 핸드폰 번호
	private String	user_tel;		// 전화번호
	private String user_email;		// 이메일
	private String user_regdate;	// 등록일
	private String user_update;		// 수정일			
	private int user_comm_code;		// 분류 코드
	private int user_delete_check;	// 삭제여부
	
}
