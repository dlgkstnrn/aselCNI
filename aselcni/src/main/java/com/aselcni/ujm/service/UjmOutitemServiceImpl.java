package com.aselcni.ujm.service;

import java.util.List;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.aselcni.ujm.dao.UjmOrderDao;
import com.aselcni.ujm.dao.UjmOutitemDao;
import com.aselcni.ujm.model.UjmOrderInfoToInsertDto;
import com.aselcni.ujm.model.UjmOrderNoDto;
import com.aselcni.ujm.model.UjmOutitem;
import com.aselcni.ujm.model.UjmOutitemItem;
import com.aselcni.ujm.model.UjmOutitemParent;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class UjmOutitemServiceImpl implements UjmOutitemService {
	
	private final UjmOutitemDao uod;
	
	private final UjmOrderDao uord;

	@Override
	public int ujmTotalOutitemCnt() {
		System.out.println("UjmOutitemServiceImpl Start ujmTotalOutitemCnt..." );
		int ujmTotalOutitemCnt = uod.ujmTotalOutitemCnt();
		System.out.println("UjmOutitemServiceImpl ujmTotalOutitemCnt->" + ujmTotalOutitemCnt);
		return ujmTotalOutitemCnt;
	}

	@Override
	public List<UjmOutitem> ujmListOutitem(UjmOutitem outitem) {
		List<UjmOutitem> ujmListOutitems = null;
		 System.out.println("UjmOutitemServiceImpl ujmListOutiem Start..." );
		 ujmListOutitems = uod.ujmListOutiem(outitem);
		 if(ujmListOutitems!=null) {
			 System.out.println("UjmOutitemServiceImpl ujmListOutitem ujmListOutitems.size()->" +ujmListOutitems.size()); 
		 }
		 return ujmListOutitems;
	}


	@Override
	@Transactional
	public int ujmInsertOutitem(UjmOutitemParent insertData, String userId) {
		System.out.println("UjmOutitemServiceImpl ujmInsertOutitem Start..." );
		UjmOutitem outitem=new UjmOutitem(); //등록할 출고 객체
		
		System.out.println(userId);
		outitem.setOutitem_emp_id(userId); //로그인된 유저id로 담당자id 설정
		System.out.println(outitem.getOutitem_emp_id());
		
        System.out.println(insertData.getOutitemData());
        UjmOutitem outitemData=insertData.getOutitemData(); //가져온 출고 객체
        
        outitem.setOutitem_no(uod.ujmSetOutitemNo(outitemData.getOutitem_no())); //가져온 날짜형태의 출고번호(2024-04-13)을 제대로 만들기
        System.out.println(outitem.getOutitem_no());
        
        outitem.setSeq_no(uod.ujmGetSeqNo(outitemData.getOrder_no())); //주문번호를 토대로 순번을 찾아 설정
        System.out.println(outitem.getSeq_no());
        
        outitem.setCust_cd(uord.ujmGetCustCd(outitemData.getOrder_no())); //주문번호를 토대로 거래처cd를 찾아 설정
        System.out.println(outitem.getCust_cd());
        
        //단순변환
        outitem.setOrder_no(outitemData.getOrder_no());
        outitem.setOutitem_dt(outitemData.getOutitem_dt());
        outitem.setCust_emp(outitemData.getCust_emp());
        outitem.setRemark(outitemData.getRemark());
        
        System.out.println(outitem);
        
        int insertOutitemResult = uod.ujmInsertOutitem(outitem); //위에서 조정한 outitem(출고)를 등록
        
		System.out.println(insertOutitemResult);
		
		return insertOutitemResult;
	}

	@Override
	public int ujmInsertOutitemItem(UjmOutitemParent insertData) {
		System.out.println("UjmOutitemServiceImpl ujmInsertOutitemItem Start..." );
		UjmOutitem outitemData=insertData.getOutitemData(); //가져온 출고 객체
		System.out.println(outitemData);
		outitemData.setOutitem_no(uod.ujmSetOutitemNo(outitemData.getOutitem_no())); //마찬가지로 출고번호 변경
		
		
		System.out.println(insertData.getSelectedItems());
		 for (UjmOutitemItem item : insertData.getSelectedItems()) { //출고품목 테이블에서 행 하나마다
			 
			 item.setOutitem_no(uod.ujmSetOutitemNo(outitemData.getOutitem_no())); 
			 item.setOrder_no(outitemData.getOrder_no());
			 uod.ujmInsertOutitemItem(item); //하나씩 추가
         }
		 int OutitemItemCnt=uod.ujmOutitemItemCnt(outitemData); //추가된 행 개수 찾기
		 
		return OutitemItemCnt;
	}





}
