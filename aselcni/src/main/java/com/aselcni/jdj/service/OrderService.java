package com.aselcni.jdj.service;

import java.util.List;

import com.aselcni.jdj.model.UserMst;
import com.aselcni.jdj.model.CustMst;
import com.aselcni.jdj.model.FindOrd;
import com.aselcni.jdj.model.Item;
import com.aselcni.jdj.model.ItemMst;
import com.aselcni.jdj.model.Order;
import com.aselcni.jdj.model.OrderItem;
import com.aselcni.jdj.model.SavingOrd;



public interface OrderService {

//	주문 조회
	List<Order> getOrderLi();
	List<Order> getOrderLi(int offset, int limit);
	
	List<CustMst> getCustMstLi();
	List<UserMst> getUserMstLi(int comm_cd);

//  주문 등록
	List<ItemMst> getItemMstLi();
	ItemMst getItemInfo(String item_cd); 	// 모달 아이템 상세
	int regOrder(Order savingOrd);			// 주문 등록 저장
	
//	주문 내역 상세
	Order getOrdSpec(String order_sec_num);

	//	해당 주문의 품목들
	List<OrderItem> getOrdItems(String order_no);

	// 주문 삭제
	int delOrd(String order_no);
	void editOrd(Order editOrd);
	Order  findOrdByNum(String order_no);
//	List<Order> findOrd(FindOrd findOrd);
	List<Order> findOrd(FindOrd findOrd, int offset, int limit);
	UserMst getUserInfo(String user_id);
	int getOrdersLen();
}