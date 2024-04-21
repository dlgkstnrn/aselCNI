package com.aselcni.jdj.model;

import java.util.List;

import lombok.Data;

@Data
public class FindOrd {
	private String order_no;
	private String seltDT;
	private List<String> selUsers;
	private List<String> selCusts;
	private String input_start_dt;
	private String input_end_dt;
	private int currPage;
}