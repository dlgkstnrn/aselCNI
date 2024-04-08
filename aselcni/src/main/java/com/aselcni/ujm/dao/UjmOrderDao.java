package com.aselcni.ujm.dao;

import java.util.List;

import com.aselcni.ujm.model.UjmOrderInfoToInsertDto;
import com.aselcni.ujm.model.UjmOrderNoDto;

public interface UjmOrderDao {
	
	List<UjmOrderNoDto> ujmGetOrderNo();

	UjmOrderInfoToInsertDto ujmGetOrderInfoFromOrderNo(String order_no);
	
}