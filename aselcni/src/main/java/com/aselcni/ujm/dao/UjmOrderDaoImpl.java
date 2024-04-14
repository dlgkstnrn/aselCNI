package com.aselcni.ujm.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.aselcni.ujm.model.UjmOrderInfoToInsertDto;
import com.aselcni.ujm.model.UjmOrderItem;
import com.aselcni.ujm.model.UjmOrderNoDto;
import com.aselcni.ujm.model.UjmOutitem;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class UjmOrderDaoImpl implements UjmOrderDao {
	
	private final SqlSession session;
	
	@Override
	public List<UjmOrderNoDto> ujmGetOrderNo() {
		List<UjmOrderNoDto> ujmListOrderNo = null;
		System.out.println("UjmOrderDaoImpl ujmGetOrderNo 시작 ..." );
		try {
			ujmListOrderNo = session.selectList("ujmListOrderNo");
			if(ujmListOrderNo!=null) {
				System.out.println("UjmOrderDaoImpl ujmListOrderNo ujmListOrderNo.size()->"+ujmListOrderNo.size());
				}
		} catch (Exception e) {
			System.out.println("UjmOrderDaoImpl ujmListOrderNo 오류:"+e.getMessage());
		}
		return ujmListOrderNo;
	}

	@Override
	public UjmOrderInfoToInsertDto ujmGetOrderInfoFromOrderNo(String order_no) {
		System.out.println("UjmOrderDaoImpl ujmGetOrderInfoFromOrderNo 시작 ..." );
		UjmOrderInfoToInsertDto orderInfo=new UjmOrderInfoToInsertDto();
		System.out.println(order_no);
		try {
			orderInfo=session.selectOne("ujmGetOrderInfoFromOrderNo",order_no);
			if (orderInfo!=null) {
				System.out.println("UjmOrderDaoImpl ujmGetOrderInfoFromOrderNo의 주문일자:"+orderInfo.getOrder_dt());
			}
		} catch (Exception e) {
			System.out.println("UjmOrderDaoImpl ujmGetOrderInfoFromOrderNo 오류: "+e.getMessage());
		}
		return orderInfo;
	}

	@Override
	public List<UjmOrderItem> ujmGetOrderItem(String order_no) {
		System.out.println("UjmOrderDaoImpl ujmGetOrderItem 시작 ..." );
		List<UjmOrderItem> ujmListOrderItem = null;
		System.out.println(order_no);
		try {
			ujmListOrderItem=session.selectList("ujmGetOrderItemList",order_no);
			if (ujmListOrderItem!=null) {
				System.out.println("UjmOrderDaoImpl ujmGetOrderItem.size():"+ujmListOrderItem.size());
			}
		} catch (Exception e) {
			System.out.println("UjmOrderDaoImpl ujmGetOrderItem 오류: "+e.getMessage());
		}
		return ujmListOrderItem;
	}

	@Override
	public String ujmGetCustCd(String order_no) {
		System.out.println("UjmOrderDaoImpl ujmGetCustCd 시작 ...");
		System.out.println(order_no); 
		try {
			String cust_cd=session.selectOne("ujmGetCustCd", order_no);
			return cust_cd;
		} catch (Exception e) {
			System.out.println("UjmOrderDaoImpl ujmGetCustCd 오류:"+e.getMessage());
			return null;
		}
	}

	@Override
	public int ujmChangeOrderStatusChk(String order_no) {
		System.out.println("UjmOrderDaoImpl ujmChangeOrderStatusChk start..");
		int ujmChangeOrderStatusChk= 0;
		try {	
			ujmChangeOrderStatusChk = session.update("ujmChangeOrderStatusChk",order_no);
			System.out.println(ujmChangeOrderStatusChk);
		} catch (Exception e) {
			System.out.println("UjmOrderDaoImpl ujmChangeOrderStatusChk Exception->"+e.getMessage());
		}
		return ujmChangeOrderStatusChk;
	}
}
