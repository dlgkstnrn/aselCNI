package com.aselcni.ujm.service;

import java.util.List;

import com.aselcni.ujm.model.UjmOrderInfoToInsertDto;
import com.aselcni.ujm.model.UjmOrderItem;
import com.aselcni.ujm.model.UjmOrderNoDto;
import com.aselcni.ujm.model.UjmOutitemParent;

public interface UjmOrderService {
	
	List<UjmOrderNoDto> ujmGetOrderNo();
	
	UjmOrderInfoToInsertDto ujmGetOrderInfoFromOrderNo(String order_no);

	List<UjmOrderItem> ujmGetOrderItem(String order_no);

	int ujmChangeOrderStatusChk(String order_no);

	int ujmCheckOrderDeleteChk(String order_no);

	int ujmUpdateOrderStatusChk(String order_no);

	int ujmCheckOrderCancelChk(String order_no);

}
