package com.aselcni.ujm.model;

import lombok.Data;

@Data
public class UjmOrderNoDto { //출고에서, 주문번호와
	//거래처이름, 거래처에서 주문한 상품, 및 개수를 가져올 때 사용
	private String order_no; //주문번호
	private String customer_name; //거래처명
	private String items; //주문한 상품명+상품개수
}
