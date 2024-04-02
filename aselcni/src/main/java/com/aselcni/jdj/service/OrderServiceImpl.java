package com.aselcni.jdj.service;

import org.springframework.stereotype.Service;

import com.aselcni.jdj.dao.OrderDao;
import com.aselcni.jdj.model.Order;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class OrderServiceImpl implements OrderService {
	
	
	private final OrderDao od;
	
	@Override
	public Order getOrderLi() {
		// TODO Auto-generated method stub
		Order order = new Order();
		
		
		return null;
	}

}
                                     