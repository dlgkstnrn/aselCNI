package com.aselcni.jdj.dao;


import org.antlr.v4.runtime.misc.Pair;
import org.apache.ibatis.session.SqlSession;
import org.eclipse.jdt.internal.compiler.env.IRecordComponent;

import static org.hamcrest.CoreMatchers.nullValue;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.aselcni.jdj.model.CustMst;
import com.aselcni.jdj.model.Item;
import com.aselcni.jdj.model.ItemMst;
import com.aselcni.jdj.model.Order;
import com.aselcni.jdj.model.OrderItem;
import com.aselcni.jdj.model.SavingOrd;
import com.aselcni.jdj.model.UserMst;

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

	@Override
	public List<CustMst> getCustLi() {
		List<CustMst> custMsts = null;
		
		try {
			System.out.println("dao_ getCstLi");
			custMsts = session.selectList("getCustLi", custMsts);
			
			System.out.println("dao_getCstLi -> " + custMsts);
			
		} catch (Exception e) {
			System.err.println(e.getMessage());
		}
		return custMsts;
	}

	@Override
	public List<ItemMst> getItemLi() {
		List<ItemMst> itemMsts = null;
		
		try {
			System.out.println("dao_ getItemLi");
			itemMsts = session.selectList("geItemLi", itemMsts);
			
			System.out.println("dao_itemMsts -> " + itemMsts);
			
		} catch (Exception e) {
			System.err.println(e.getMessage());
		}
		return itemMsts;
	}

	@Override
	public List<UserMst> getUserLi(int user_comm_code) {
		System.out.println("[OS_getUserLi Start...");
		List<UserMst> userMsts = null;
		try {
			userMsts = session.selectList("getUserLi", user_comm_code);
			System.out.println("OD_getUserLi -> " + userMsts);
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return userMsts;
	}

	@Override
	public ItemMst getItemInfo(String item_cd) {
		System.out.println("[OS_getItemInfo Start...");
		ItemMst itemMst = null;
		try {
			itemMst = session.selectOne("getItemInfo", item_cd);
			System.out.println("OD_getItemInfo -> " + itemMst);
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return itemMst;
	}

	@Override
	public int savingOrd(SavingOrd savingOrd) {
		// TODO Auto-generated method stub
		return 0;
	}
	
	// 들어온 주문 날짜로 주문번호 생성후 전달받음
	@Override
	public String createOrdNo(String order_dt) {
		System.out.println("[Dao - create order_no] ---");
		String order_no = "";
		try {
			order_no = session.selectOne("createOrdNo", order_dt);
			System.out.println("----- new order_no : " + order_no);
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return order_no;
	}

	@Override
	public int regOrder(Order savingOrd) {
		int result = 0;
		try {
			result = session.insert("regOrder", savingOrd);
			if(result == 0) {
				System.out.println("insert 실패");
			}else {
				System.out.println("insert성공인듯");
			}
		} catch (Exception e) {
			System.err.println(e.getMessage());
		}
		
		return result;
	}

	@Override
	public int regOrderItem(OrderItem orderItem) {
		System.out.println("-------------regOrderItem 다오~");
		int result = 0;
		try {
			result = session.insert("regOrderItem", orderItem);
			if(result == 0) {
				System.out.println("insert 실패");
			}else {
				System.out.println("insert성공인듯");
			}
		} catch (Exception e) {
			System.err.println(e.getMessage());
		}
		
		return result;
	}

}
