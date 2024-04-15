package com.aselcni.jtu.service;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class JtuPaging {
	private int currentPage= 1; private int rowPage =10; //한 페이지에 몇개 보여줄지
	private int pageBlock =5; //밑에 몇개 보여줄지
	private int start; 			private int end;
	private int startPage;		private int endPage;
	private int total;			private int totalPage;
	
	
	//  		23					null(2)
	public JtuPaging (int total, Integer currentPage) {
		this.total = total;		//23
		this.currentPage = currentPage;
		
		//				1			10
		start = (currentPage-1)*rowPage +1;		//시작시 1	11
		end = start +rowPage-1;					//시작시 10	20
					//					  23	 10
		totalPage=(int)Math.ceil((double)total/rowPage);	//시작시 3
		
		startPage = currentPage - (currentPage-1)%pageBlock;//시작시 1
		endPage =startPage + pageBlock-1;	//10
		
		  //   10         14
	      if(endPage > totalPage) {
	         endPage = totalPage;
	      }
	}//Paging
}//class
