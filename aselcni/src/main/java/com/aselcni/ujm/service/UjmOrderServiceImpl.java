package com.aselcni.ujm.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.aselcni.ujm.dao.UjmOrderDao;
import com.aselcni.ujm.dao.UjmOutitemDao;
import com.aselcni.ujm.model.UjmOrderInfoToInsertDto;
import com.aselcni.ujm.model.UjmOrderNoDto;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class UjmOrderServiceImpl implements UjmOrderService {
	
	private final UjmOrderDao uord;
	
	@Override
	public List<UjmOrderNoDto> ujmGetOrderNo() {
		List<UjmOrderNoDto> ujmListOrderNo = null;
		 System.out.println("UjmOrderServiceImpl ujmGetOrderNo Start...");
		 ujmListOrderNo = uord.ujmGetOrderNo();
		 if(ujmListOrderNo!=null) {
			 System.out.println("UjmOrderServiceImpl ujmListOrderNo ujmListOrderNo.size()->" +ujmListOrderNo.size()); 
		 }
		 return ujmListOrderNo;
	}
	
	@Override
	public UjmOrderInfoToInsertDto ujmGetOrderInfoFromOrderNo(String order_no) {
		System.out.println("UjmOrderServiceImpl ujmGetOrderInfoFromOrderNo Start...");
		UjmOrderInfoToInsertDto orderInfo=null;
		orderInfo=uord.ujmGetOrderInfoFromOrderNo(order_no);
		return orderInfo;
	}
}
