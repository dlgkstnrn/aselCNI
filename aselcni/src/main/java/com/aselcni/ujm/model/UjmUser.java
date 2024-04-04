package com.aselcni.ujm.model;

import lombok.Data;

@Data
public class UjmUser { //유저
	private String user_id; //사용자ID, PK
	private String user_nm; //사용자명
	private String user_pw; //암호
	private String user_phone; //전화번호
	private String user_tel; //유선번호
	private String user_email; //이메일
	private String user_regdate; //유저가입일
	private String user_update; //유저수정일
	private int    user_comm_code; //공통코드, fk
	private int    user_delete_check; //유저삭제여부
}
