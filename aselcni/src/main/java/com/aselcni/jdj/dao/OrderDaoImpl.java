package com.aselcni.jdj.dao;


import org.antlr.v4.runtime.misc.Pair;
import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.eclipse.jdt.internal.compiler.env.IRecordComponent;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.security.config.annotation.web.configurers.oauth2.client.OAuth2LoginConfigurer.UserInfoEndpointConfig;
import org.springframework.stereotype.Repository;

import com.aselcni.jdj.model.CustMst;
import com.aselcni.jdj.model.FindOrd;
import com.aselcni.jdj.model.Item;
import com.aselcni.jdj.model.ItemMst;
import com.aselcni.jdj.model.Order;
import com.aselcni.jdj.model.OrderItem;
import com.aselcni.jdj.model.UserMst;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class OrderDaoImpl implements OrderDao {

	private final SqlSession session;
	
	// 주문 조회 main페이지 //
	@Override			// 주문 조회
	public List<Order> getOrderLi() {
		List<Order> orderLi = null;		
		System.out.println("[Dao - getOrderLi Start");
		try {
			orderLi = session.selectList("getOrderLi");
			System.out.println("[Dao - getOrderLi Fin");
		} catch (Exception e) {
			System.err.println(e.getMessage());
		}
		return orderLi;
	}
	
	@Override
	public List<Order> getOrderLi(int offset, int limit) {
		System.err.println("offset -> " + offset + " limit -> "+limit);
		List<Order> orderLi = null;		
		System.out.println("[Dao - getOrderLi Start");
		try {
			RowBounds rowBounds = new RowBounds(offset, limit);
			orderLi = session.selectList("getOrderLi",rowBounds);
			System.out.println("[Dao - getOrderLi Fin");
		} catch (Exception e) {
			System.err.println(e.getMessage());
		}
		return orderLi;
	}
	
	@Override
	public int getOrdersLen() {
		int size = 0;
		List<Order> orderLi = null;
		try {
			orderLi = session.selectList("getOrderLen");
			size = orderLi.size();
		} catch (Exception e) {
			// TODO: handle exception
		}
		return size;
	}
	
	@Override						// 고객사 리스트
	public List<CustMst> getCustMstLi() {
		List<CustMst> custMstLi = null;		
		System.out.println("[Dao - getCustMstLi Start");	
		try {
			custMstLi = session.selectList("getCustMstLi");
			System.out.println("[Dao - getCustMstLi Fin");	
		} catch (Exception e) {
			System.err.println(e.getMessage());
		}
		return custMstLi;
	}
	
	@Override			// 영업부 사원 리스트
	public List<UserMst> getUserMstLi(int user_comm_code) {
		System.out.println("[Dao - getUserMstLi Start");
		List<UserMst> userMstLi = null;
		try {
			userMstLi = session.selectList("getUserMstLi", user_comm_code);
			System.out.println("[Dao - getUserMstLi Fin");			
		} catch (Exception e) {
			System.err.println(e.getMessage());
		}
		return userMstLi;
	}
	
	// -----------------------------------------------------
	
	// 신규 주문 등록 //
	@Override
	public List<ItemMst> getItemMstLi() {
		List<ItemMst> itemMstLi = null;
		System.out.println("[Dao - getItemMstLi Start");
		try {
			itemMstLi = session.selectList("getItemMstLi");
			System.out.println("[Dao - getItemMstLi Fin");
			
		} catch (Exception e) {
			System.err.println(e.getMessage());
		}
		return itemMstLi;
	}
	
	
	
	// 들어온 주문 날짜로 주문번호 생성후 전달받음
	@Override
	public String createOrdNo(String order_dt) {
		String order_no = "";
		try {
			order_no = session.selectOne("createOrdNo", order_dt);
		} catch (Exception e) {
			System.err.println(e.getMessage());
		}
		return order_no;
	}
	
	// 주문 저장
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
	// 주문 아이템들 저장
	@Override
	public int regOrderItems(OrderItem orderItem) {
		System.out.println("-------------regOrderItem 다오~");
		int result = 0;
		try {
			result = session.insert("regOrderItems", orderItem);
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
	
//	-----------------------------------------------------
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
	public int delOrd(String order_no) {
		System.out.println("[Dao_ delOrd");
		int result=0;
		try {
			result = session.update("delOrd",order_no);
		} catch (Exception e) {
			System.err.println(e.getMessage());
		}
		return result;
	}

	@Override
	public void editOrd(Order editOrd) {
		System.out.println("[DAO] editOrd _ Start");
		try {
		    // 해당 주문 상품이 있으면 수량 업데이트
		    int result = session.update("updateOrd",editOrd);
		    // 없데이트된 행이 0개 즉, 없는 주문 상품이면
		    if (result == 0) {
		    	System.out.println("없는디?");
		    }   
		} catch (Exception e) {
			System.err.println(e.getMessage());
		}
		System.out.println("[DAO] editOrd _ End");
	}
	
	@Override
	public int editOrdItems(OrderItem editOrdItems) {
		System.out.println("[DAO] editOrdItems _ Start");
		System.out.println("[DAO] editOrdItems _" + editOrdItems.getQty() + " - name :" + editOrdItems.getItem_nm());
		System.out.println("[DAO] editOrdItems _" + editOrdItems.getItem_cd() + " - cost :" + editOrdItems.getCost());
		int result = 0;
		try {
		    // 해당 주문 상품이 있으면 수량 업데이트
		    result = session.update("checkOrdItem",editOrdItems);

		    // 없데이트된 행이 0개 즉, 없는 주문 상품이면
		    if (result == 0) {
		    	session.insert("regOrderItems", editOrdItems);
		    }
		}catch (Exception e) {
			System.err.println(e.getMessage());
		}
		System.out.println("[DAO] editOrdItems _ Fin");
		return result;
	}

	@Override
	public Order findOrdByNum(String order_no) {
		System.out.println("---- [Dao] findOrdByNum");
		Order findOrder = null;
		try {
			findOrder = session.selectOne("findOrdByNum", order_no);
			
			System.out.println("findOrder -> " + findOrder);
		} catch (Exception e) {
			
		}
		return findOrder;
	}

	@Override
	public List<Order> findOrd(FindOrd findOrd, int offset, int limit) {
//	public List<Order> findOrd(FindOrd findOrd) {
  		System.err.println("[Dao findOrd --> " + findOrd + " : " + offset + " : " + limit);

		String order_no = findOrd.getOrder_no();
		String input_start_dt =findOrd.getInput_start_dt();
		String input_end_dt = findOrd.getInput_end_dt();
		String seltDT = findOrd.getSeltDT();
		List<String> selUsers = findOrd.getSelUsers();
		List<String> selCusts = findOrd.getSelCusts();
		
		
//		System.out.println("order_no : " + order_no);
//		System.out.println("input_start_dt : " + input_start_dt);
//		System.out.println("input_end_dt : " + input_end_dt);
//		System.out.println("seltDT : " + seltDT);
//		System.out.println("selUsers : " + selUsers);
//		System.out.println("selCusts : " + selCusts);
		List<Order> findOrders =null;
		
		try {
			Map<String, Object> params = new HashMap<>();
			params.put("order_no", order_no);
			params.put("input_start_dt", input_start_dt);
			params.put("input_end_dt", input_end_dt);
			params.put("seltDT", seltDT);
			params.put("selUsers", selUsers);
			params.put("selCusts", selCusts);
			
//			RowBounds rowBounds = new RowBounds(offset, limit);
//	        findOrders = session.selectList("findOrd", params, rowBounds);
	        findOrders = session.selectList("findOrd", params);
	        
	        System.out.println("==============================================");
	        System.out.println("findOrders : " + findOrders);
	        System.out.println("==============================================");
//	        findOrders = session.selectList("findOrd", params);
//			findOrders = session.selectList("findOrd",params);
		} catch (Exception e) {
			System.err.println(e.getMessage());
		}
		
		return findOrders;
	}

	@Override
	public UserMst getUserInfo(String user_id) {
		System.out.println("---- [Dao] getUserInfo >>>> " + user_id);
		UserMst regUserInfo = null;
		try {
			regUserInfo = session.selectOne("getUserInfo", user_id);
			
			System.out.println("!!!!!!!!! -> " + regUserInfo);
		} catch (Exception e) {
			System.err.println(e.getMessage());
		}
		return regUserInfo;
	}



	


	

}