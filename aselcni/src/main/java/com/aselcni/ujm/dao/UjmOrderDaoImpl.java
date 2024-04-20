package com.aselcni.ujm.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.aselcni.ujm.model.UjmOrder;
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
		UjmOrder order=new UjmOrder();
		order.setOrder_no(order_no);
		try {	//주문한 상품의 일부만 출고되었을 시 0이, 모두 출고했을 경우 1이 select됨
			ujmChangeOrderStatusChk = session.selectOne("ujmSelectAllOrderOutitemChk",order_no);
			System.out.println("ujmChangeOrderStatusChk:"+ujmChangeOrderStatusChk);
			
			if(ujmChangeOrderStatusChk==0) { //주문한 상품의 일부만 출고되었을 시, order_status_chk을 2으로 변경(또는 유지)
				System.out.println("order_status_chk을 2로 변경");
				order.setOrder_status_chk(2);
			} 
			else if(ujmChangeOrderStatusChk==1) { //주문한 상품 모두 출고되었을 시, order_status_chk을 3으로 변경
				order.setOrder_status_chk(3);
			}
			ujmChangeOrderStatusChk = session.update("ujmChangeOrderStatusChk",order);
			System.out.println("최종 변경한 ujmChangeOrderStatusChk:"+ujmChangeOrderStatusChk); 
		} catch (Exception e) {
			System.out.println("UjmOrderDaoImpl ujmChangeOrderStatusChk Exception->"+e.getMessage());
		}
		return ujmChangeOrderStatusChk;
	}

	@Override
	public int ujmCheckOrderDeleteChk(String order_no) {
		System.out.println("UjmOrderDaoImpl ujmChangeOrderStatusChk start..");
		System.out.println(order_no);
		int ujmCheckOrderDeleteChk= 0;
		try {
			ujmCheckOrderDeleteChk=session.selectOne("ujmCheckOrderDeleteChk",order_no);
		} catch (Exception e) {
			System.out.println("UjmOrderDaoImpl ujmChangeOrderStatusChk Exception->"+e.getMessage());
		}
		return ujmCheckOrderDeleteChk;
	}

	@Override
	public int ujmUpdateOrderStatusChk(String order_no) {
		System.out.println("UjmOrderDaoImpl ujmUpdateOrderStatusChk start..");
		System.out.println(order_no);
		
		int ujmUpdateOrderStatusChk= 0;
		UjmOrder order=new UjmOrder();
		order.setOrder_no(order_no);
		System.out.println(order);
		try {		
			//해당 주문번호가 출고품목에 있는지 체크, 없으면 수정으로 삭제된 것이므로 출고상태를 0으로 변경해야함
			int ujmOutitemItemJoinOrderNoChk = session.selectOne("ujmOutitemItemJoinOrderNoChk",order_no);
			System.out.println("ujmOutitemItemJoinOrderNoChk:"+ujmOutitemItemJoinOrderNoChk);
			//이미 ajax에서 삭제체크를 하므로 삭제체크를 하지 않음
			
			if(ujmOutitemItemJoinOrderNoChk==0) { //출고품목에 없으면 주문상태가 출고되지 않은것이므로
				System.out.println("ujmOutitemItemJoinOrderNoChk이 0이므로 order_status_chk을 0으로 변경");
				order.setOrder_status_chk(0);
			} else {
				//주문한 상품의 일부만 출고되었을 시 0이, 모두 출고했을 경우 1이 select됨
				ujmUpdateOrderStatusChk = session.selectOne("ujmSelectAllOrderOutitemChk",order_no);
				System.out.println("ujmChangeOrderStatusChk:"+ujmUpdateOrderStatusChk);
				
				if(ujmUpdateOrderStatusChk==0) { //주문한 상품의 일부만 출고되었을 시, order_status_chk을 2으로 변경(또는 유지)
					System.out.println("order_status_chk을 2으로 변경");
					order.setOrder_status_chk(2);
				} else if(ujmUpdateOrderStatusChk==1) { //주문한 상품 모두 출고되었을 시, order_status_chk을 3으로 변경
					System.out.println("order_status_chk을 3으로 변경");
					order.setOrder_status_chk(3);	
				}		
			}
			System.out.println(order);
			ujmUpdateOrderStatusChk = session.update("ujmChangeOrderStatusChk",order);
			System.out.println("최종 변경한 ujmUpdateOrderStatusChk:"+ujmUpdateOrderStatusChk); 
		} catch (Exception e) {
			System.out.println("UjmOrderDaoImpl ujmChangeOrderStatusChk Exception->"+e.getMessage());
		}
		return ujmUpdateOrderStatusChk;
	}

	@Override
	public int ujmCheckOrderCancelChk(String order_no) {
		System.out.println("UjmOrderDaoImpl ujmCheckOrderCancelChk start..");
		System.out.println(order_no);
		int ujmCheckOrderCancelChk= 0;
		try {
			ujmCheckOrderCancelChk=session.selectOne("ujmCheckOrderCancelChk",order_no);
		} catch (Exception e) {
			System.out.println("UjmOrderDaoImpl ujmCheckOrderCancelChk Exception->"+e.getMessage());
		}
		return ujmCheckOrderCancelChk;
	}

	@Override
	public int ujmUpdateOrderStatusChkAtDelete(String order_no) {
		System.out.println("UjmOrderDaoImpl ujmUpdateOrderStatusChkAtDelete start..");
		System.out.println(order_no);
		UjmOrder order=new UjmOrder();
		order.setOrder_no(order_no);
		
		int ujmUpdateOrderStatusChkAtDelete= 0; 
		try {	
			//주문의 상태가 2또는 3이고, 해당 주문번호에 종속된 출고가 있는지 체크
			//삭제하려는 출고는 이미 outitem_delete_chk이 1로 된 상태
			int outitemCntAtChangeOrderStatusChkAtDelete = session.selectOne("outitemCntAtChangeOrderStatusChkAtDelete",order_no);
			System.out.println("outitemCntAtChangeOrderStatusChkAtDelete:"+outitemCntAtChangeOrderStatusChkAtDelete);
			
			if(outitemCntAtChangeOrderStatusChkAtDelete==0) { //0이면, 해당 주문이 출고되지 않은 것이므로 order_status_chk을 0으로 변경
				System.out.println("order_status_chk을 0으로 변경");
				order.setOrder_status_chk(0);
			} else if(outitemCntAtChangeOrderStatusChkAtDelete>0) { //0이 아니면, 주문번호를 가지고 있는 출고가 아직 있는 것이고
				//삭제하는 시점에서 order_status_chk이 3이 될 순 없으니까 2로 변경
				System.out.println("order_status_chk을 2으로 변경");
				order.setOrder_status_chk(2);
			}
			try {
				ujmUpdateOrderStatusChkAtDelete= session.update("ujmChangeOrderStatusChk",order); 
				System.out.println("최종 수정한 ujmUpdateOrderStatusChkAtDelete:"+ujmUpdateOrderStatusChkAtDelete);
			} catch (Exception e) {
				System.out.println("UjmOrderDaoImpl ujmUpdateOrderStatusChkAtDelete Exception->"+e.getMessage());
			}
		
		} catch (Exception e) {
			System.out.println("UjmOrderDaoImpl outitemCntAtChangeOrderStatusChkAtDelete Exception->"+e.getMessage());
		}
		return ujmUpdateOrderStatusChkAtDelete;
	}
}
