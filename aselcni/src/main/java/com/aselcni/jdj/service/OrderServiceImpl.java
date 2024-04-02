package com.aselcni.jdj.service;

import static org.hamcrest.CoreMatchers.nullValue;

import java.util.List;

import org.springframework.stereotype.Service;

import com.aselcni.jdj.dao.OrderDao;
import com.aselcni.jdj.model.Order;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class OrderServiceImpl implements OrderService {
	
	
	private final OrderDao od;
	
	@Override
	public List<Order> getOrderLi() {
		
		System.out.println("[Order_Service Start...");
		List<Order> orders = null;
		
		try {			
			orders = od.getOrdLi();
		} catch (Exception e) {
			System.err.println(e.getMessage());
		}

		return orders;
		
	
	}

	@Override
	public String getCust_nm( ) {
		// 파라미터로 전달받은 cust_cd값으로 cust_nm을 가져옴
		
		
		return null;
	}

}
                                     