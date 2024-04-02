package com.aselcni.ujm.model;

import lombok.Data;

@Data
public class UjmProc { //공정관리
	private String proc_cd; //공정CD, PK
	private String proc_nm; //공정명
	private String remark; //비고(설명)
	private int    use_flag; //사용여부
	private String proc_emp_id; //공정담당자ID
	private String proc_regdate; //공정등록일
	private String proc_update; //공정수정일
	private int    proc_delete_chk; //공정삭제여부
}
