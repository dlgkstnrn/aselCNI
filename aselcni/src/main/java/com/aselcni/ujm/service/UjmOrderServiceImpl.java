package com.aselcni.ujm.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.aselcni.ujm.dao.UjmOrderDao;
import com.aselcni.ujm.dao.UjmOutitemDao;
import com.aselcni.ujm.model.UjmOrderInfoToInsertDto;
import com.aselcni.ujm.model.UjmOrderItem;
import com.aselcni.ujm.model.UjmOrderNoDto;
import com.aselcni.ujm.model.UjmOutitem;
import com.aselcni.ujm.model.UjmOutitemItem;
import com.aselcni.ujm.model.UjmOutitemParent;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class UjmOrderServiceImpl implements UjmOrderService {
	
	private final UjmOrderDao uord;
	
	private final UjmOutitemDao uod;
	
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

	@Override
	public List<UjmOrderItem> ujmGetOrderItem(String order_no) {
		System.out.println("UjmOrderServiceImpl ujmGetOrderItem Start...");
		List<UjmOrderItem> ujmListOrderItem=null;
		ujmListOrderItem=uord.ujmGetOrderItem(order_no);
		return ujmListOrderItem;
	}

	@Override
	public int ujmChangeOrderStatusChk(String order_no) {
		System.out.println(order_no);
		int ujmChangeOrderStatusChk=uord.ujmChangeOrderStatusChk(order_no); 
		return ujmChangeOrderStatusChk;
	}

	@Override
	public int ujmCheckOrderDeleteChk(String order_no) {
		System.out.println(order_no);
		int ujmCheckOrderDeleteChk=uord.ujmCheckOrderDeleteChk(order_no); 
		return ujmCheckOrderDeleteChk;
	}

	@Override
	public int ujmUpdateOrderStatusChk(String order_no) {
		System.out.println(order_no);
		int ujmUpdateOrderStatusChk=uord.ujmUpdateOrderStatusChk(order_no); 
		return ujmUpdateOrderStatusChk;
	}

	@Override
	public int ujmCheckOrderCancelChk(String order_no) {
		System.out.println(order_no);
		int ujmCheckOrderCancelChk=uord.ujmCheckOrderCancelChk(order_no); 
		return ujmCheckOrderCancelChk;
	}
}
