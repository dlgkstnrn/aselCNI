package com.aselcni.jdj.dao;

import java.util.List;

import com.aselcni.jdj.model.Item;
import com.aselcni.jdj.model.Order;
import com.aselcni.jdj.model.OrderItem;

public interface OrderDao {

	List<Order> getOrders();

	Order getOrdSpec(String order_sec_num);

	List<OrderItem> getOrdItems(String order_no);

}
