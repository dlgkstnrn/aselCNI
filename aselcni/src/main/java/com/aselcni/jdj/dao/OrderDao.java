package com.aselcni.jdj.dao;

import java.util.List;

import com.aselcni.jdj.model.CustMst;
import com.aselcni.jdj.model.Item;
import com.aselcni.jdj.model.ItemMst;
import com.aselcni.jdj.model.Order;
import com.aselcni.jdj.model.OrderItem;
import com.aselcni.jdj.model.UserMst;

public interface OrderDao {

	List<Order> getOrders();

	Order getOrdSpec(String order_sec_num);

	List<OrderItem> getOrdItems(String order_no);

	List<CustMst> getCustLi();

	List<ItemMst> getItemLi();

	List<UserMst> getUserLi(int user_comm_code);

	ItemMst getItemInfo(String item_cd);

}
