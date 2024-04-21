package com.aselcni.jdj.dao;

import java.util.List;

import com.aselcni.jdj.model.CustMst;
import com.aselcni.jdj.model.FindOrd;
import com.aselcni.jdj.model.Item;
import com.aselcni.jdj.model.ItemMst;
import com.aselcni.jdj.model.Order;
import com.aselcni.jdj.model.OrderItem;
import com.aselcni.jdj.model.UserMst;

public interface OrderDao {
//	주문조회 페이지
	List<Order> getOrderLi();
	List<CustMst> getCustMstLi();
	List<UserMst> getUserMstLi(int user_comm_code);

//	주문등록 페이지
	List<ItemMst> getItemMstLi();
	String createOrdNo(String order_dt);	// 주문번호 생성
	int regOrder(Order savingOrd);	// order table 저장	
	int regOrderItems(OrderItem orderItem);	// order_item 저장

	Order getOrdSpec(String order_sec_num);

	List<OrderItem> getOrdItems(String order_no);



	ItemMst getItemInfo(String item_cd);
	int delOrd(String order_no);
	
	void editOrd(Order editOrd);
	int editOrdItems(OrderItem editOrdItems);
	Order  findOrdByNum(String order_no);
	List<Order> findOrd(FindOrd findOrd, int offset, int limit);
//	List<Order> findOrd(FindOrd findOrd);
	UserMst getUserInfo(String user_id);
	List<Order> getOrderLi(int offset, int limit);
	int getOrdersLen();

//	int savingOrd(SavingOrd savingOrd);



	

}