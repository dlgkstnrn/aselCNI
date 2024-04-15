package com.aselcni.ujm.model;

import java.util.List;

import lombok.Data;

@Data
public class UjmOutitemParent { //출고시 js에서 출고테이블과 출고품목테이블을 함께 다루기 위함 (두 객체를 하나에 넣고 직렬화해 전송)
	private UjmOutitem outitemData; //출고테이블
	private List<UjmOutitemItem> selectedItems; //출고품목테이블과 관련된 것
}
