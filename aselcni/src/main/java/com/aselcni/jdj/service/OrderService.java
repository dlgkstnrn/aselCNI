package com.aselcni.jdj.service;

import java.util.List;

import com.aselcni.jdj.model.UserMst;
import com.aselcni.jdj.model.CustMst;
import com.aselcni.jdj.model.Item;
import com.aselcni.jdj.model.ItemMst;
import com.aselcni.jdj.model.Order;
import com.aselcni.jdj.model.OrderItem;
import com.aselcni.jdj.model.SavingOrd;

public interface OrderService {

//	주문 조회
	List<Order> getOrders();
	
//	주문 내역 상세
	Order getOrdSpec(String order_sec_num);
//	해당 주문의 품목들
	List<OrderItem> getOrdItems(String order_no);

	List<CustMst> getCustLi();

	List<ItemMst> getItemLi();

	List<UserMst> getUserLi(int i);

	ItemMst getItemInfo(String item_cd);

	int regOrder(Order savingOrd);

//	거래처 리스트 가져오기
}
