package com.aselcni.ujm.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.aselcni.ujm.model.UjmOrderInfoToInsertDto;
import com.aselcni.ujm.model.UjmOrderNoDto;

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
		try {
			orderInfo=session.selectOne("ujmGetOrderInfoFromOrderNo",order_no);
			if (orderInfo!=null) {
				System.out.println("UjmOrderDaoImpl ujmGetOrderInfoFromOrderNo의 order_no:"+orderInfo.getOrder_no());
			}
		} catch (Exception e) {
			System.out.println("UjmOrderDaoImpl ujmGetOrderInfoFromOrderNo 오류: "+e.getMessage());
		}
		return orderInfo;
	}
}
