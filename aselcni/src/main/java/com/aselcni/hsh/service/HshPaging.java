package com.aselcni.hsh.service;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class HshPaging {
    private int currentPage = 1; // 현재 페이지
    private int rowPage = 10;    // 페이지당 행 수
    private int pageBlock = 10;  // 페이지 블록
    private int start;           // SQL 'OFFSET'에 사용될 값
    private int end;             // SQL 'FETCH NEXT'에 사용될 값(수정할 필요가 있음)
    private int startPage;       // 페이지네이션 시작 페이지
    private int endPage;         // 페이지네이션 끝 페이지
    private int total;           // 전체 행 수
    private int totalPage;       // 전체 페이지 수

    public HshPaging(int total, String currentPage1) {
        this.total = total;
        if (currentPage1 != null) {
            this.currentPage = Integer.parseInt(currentPage1);
        }
        start = (currentPage - 1) * rowPage + 1;  // 시작시 1     11   
		end   = start + rowPage - 1;                       // 'FETCH NEXT'에 사용할 값으로 페이지당 행 수 지정

        totalPage = (int) Math.ceil((double) total / rowPage);

        startPage = currentPage - (currentPage - 1) % pageBlock;
        endPage = startPage + pageBlock - 1;

        if (endPage > totalPage) {
            endPage = totalPage;
        }
    }
}