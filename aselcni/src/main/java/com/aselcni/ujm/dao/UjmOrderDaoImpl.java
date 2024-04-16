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
		System.out.println(order_no);
		int ujmChangeOrderStatusChk= 0;
		try {	//주문한 상품의 일부만 출고되었을 시 0이, 모두 출고했을 경우 1이 select됨
			ujmChangeOrderStatusChk = session.selectOne("ujmChangeOrderStatusChk",order_no);
			System.out.println("ujmChangeOrderStatusChk:"+ujmChangeOrderStatusChk);
			
			if(ujmChangeOrderStatusChk==0) { //주문한 상품의 일부만 출고되었을 시, order_status_chk을 3으로 변경(또는 유지)
				ujmChangeOrderStatusChk = session.update("ujmChangeOrderStatusChkTwo",order_no);
				System.out.println("ujmChangeOrderStatusChk2:"+ujmChangeOrderStatusChk);
			} 
			else if(ujmChangeOrderStatusChk==1) { //주문한 상품 모두 출고되었을 시, order_status_chk을 3으로 변경
				ujmChangeOrderStatusChk = session.update("ujmChangeOrderStatusChkThree",order_no);
				System.out.println("ujmChangeOrderStatusChk3:"+ujmChangeOrderStatusChk); 
			}
		} catch (Exception e) {
			System.out.println("UjmOrderDaoImpl ujmChangeOrderStatusChk Exception->"+e.getMessage());
		}
		return ujmChangeOrderStatusChk;
	}
}
