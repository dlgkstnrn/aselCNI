package com.aselcni.jdj.dao;


import org.antlr.v4.runtime.misc.Pair;
import org.apache.ibatis.session.SqlSession;

import static org.hamcrest.CoreMatchers.nullValue;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.aselcni.jdj.model.Item;
import com.aselcni.jdj.model.Order;
import com.aselcni.jdj.model.OrderItem;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class OrderDaoImpl implements OrderDao {

	private final SqlSession session;

	@Override
	public List<Order> getOrders() {
		List<Order> orders = null;
		System.out.println("od_getOrders start!");
		
		try {
			orders = session.selectList("getOrders");
			System.out.println("od_getOrders -> " + orders);
		} catch (Exception e) {
			System.err.println(e.getMessage());
		}
		return orders;
	}

	@Override
	public Order getOrdSpec(String order_sec_num) {
		Order orderSpec = null;
		
		try {
			orderSpec = session.selectOne("getOrdSpec", order_sec_num);
			System.out.println("orderSpec -> " + orderSpec);
			
		} catch (Exception e) {
			System.err.println(e.getMessage());
		}
		
		return orderSpec;
	}

	@Override
	public List<OrderItem> getOrdItems(String order_no) {
		List<OrderItem> items = null;
		
		try {
			System.out.println("[ Dao ] = getOrdItem List order_no -> " + order_no);
			items = session.selectList("getOrdItems", order_no);
			System.out.println("[ Dao ] - getOrdItemList  -> " + items);
			
		} catch (Exception e) {
			System.err.println(e.getMessage());
		}

		return items;
	}

}
