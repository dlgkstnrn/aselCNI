package com.aselcni.lhs.model;

import lombok.Data;

@Data
public class Compmst {
	private String comp_busi_no;
	private String comp_nm;
	private String comp_president_nm;
	private String comp_cond;
	private String comp_item;
	private String comp_addr;
	private String comp_tel;
	private String comp_fax;
	private byte[] comp_image;
	private String comp_update;
}
