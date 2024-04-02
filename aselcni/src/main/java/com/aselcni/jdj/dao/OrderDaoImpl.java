package com.aselcni.jdj.dao;


import org.antlr.v4.runtime.misc.Pair;
import org.apache.ibatis.session.SqlSession;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.aselcni.jdj.model.Order;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class OrderDaoImpl implements OrderDao {

	private final SqlSession session;
	
	@Override
	public List<Order> getOrdLi() {
		System.out.println("[Order_Dao] getOrdLi Start");		
		List<Order> orders = null;
		String cust_nm = null;
		String emp_nm = null; 
		
		 try {
			 
			orders = session.selectList("getOrderLi", orders);
			System.out.println("[Order_Dao orderLi -> " + orders);

			for (Order order : orders) {
				cust_nm = session.selectOne("getCust_nm",order.getCust_cd());
				emp_nm = session.selectOne("getEmp_nm",order.getOrder_emp_id());
				order.setCust_nm(cust_nm);
				order.setOrder_emp_nm(emp_nm);
				
//				System.out.println();
		    }

		} catch (Exception e) {
			System.err.println(e.getMessage());
		}
		 
		return orders;
	}

}
