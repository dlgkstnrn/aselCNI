package com.aselcni.csg.service;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Data
public class csg_Paging {
	private int currentPage = 1; private int rowPage = 10;
	private int pageBlock = 5; // 한번에 표시할 페이지 번호의 숫자는 5
	private int start; private int end;
	private int startPage; private int endPage;
	private int total; private int totalPage;
	
	//				23					null(2)
	public csg_Paging(int total, String currentPage1) {
		this.total = total;
		if(currentPage1 !=null) {
			this.currentPage = Integer.parseInt(currentPage1); //2
		}
		
		//		1				10
		start = (currentPage-1) * rowPage+1; //시작시1	11
		end = start + rowPage -1;//시작시 10			20
		
		//				23			10
		totalPage = (int)Math.ceil((double)total / rowPage);//시작시 3
		
		startPage = currentPage - (currentPage -1)%pageBlock; //시작시 1
		endPage = startPage + pageBlock - 1; //10
		
		//	10			14
		if(endPage > totalPage) {
			endPage = totalPage;
		}
	}
	
}
