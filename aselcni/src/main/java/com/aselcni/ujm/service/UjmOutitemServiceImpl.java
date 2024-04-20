package com.aselcni.ujm.service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.aselcni.ujm.dao.UjmOrderDao;
import com.aselcni.ujm.dao.UjmOutitemDao;
import com.aselcni.ujm.model.UjmOrderInfoToInsertDto;
import com.aselcni.ujm.model.UjmOrderItem;
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
	public int ujmTotalOutitemCnt(UjmOutitem outitem) {
		System.out.println("UjmOutitemServiceImpl Start ujmTotalOutitemCnt" );
		int ujmTotalOutitemCnt = uod.ujmTotalOutitemCnt(outitem);
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
        
        outitem.setSeq_no(uod.ujmGetSeqNo(outitemData.getOrder_no())); //주문번호를 토대로 순번을 찾아 설정
        System.out.println(outitem.getSeq_no());
        
        outitem.setCust_cd(uord.ujmGetCustCd(outitemData.getOrder_no())); //주문번호를 토대로 거래처cd를 찾아 설정
        System.out.println(outitem.getCust_cd());
        
        //단순변환
        outitem.setOutitem_no(outitemData.getOutitem_no());
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
	@Transactional
	public int ujmInsertOutitemItem(UjmOutitemParent insertData) {
		System.out.println("UjmOutitemServiceImpl ujmInsertOutitemItem Start..." );
		UjmOutitem outitemData=insertData.getOutitemData(); //가져온 출고 객체
		System.out.println(outitemData);
		
		System.out.println(insertData.getSelectedItems());
		 for (UjmOutitemItem item : insertData.getSelectedItems()) { //출고품목 테이블에서 행 하나마다
			 
			 item.setOutitem_no(outitemData.getOutitem_no()); 
			 item.setOrder_no(outitemData.getOrder_no());
			 uod.ujmInsertOutitemItem(item); //하나씩 추가
         }
		 int outitemItemCnt=uod.ujmOutitemItemCnt(outitemData); //추가된 행 개수 찾기
		 
		return outitemItemCnt;
	}

	@Override
	public String ujmSetOutitemNo(String outitem_no) {
		System.out.println("UjmOutitemServiceImpl ujmSetOutitemNo Start...");
		String changedOutitemNo=uod.ujmSetOutitemNo(outitem_no);
		return changedOutitemNo;
	}

	@Override
	public List<UjmOutitem> ujmGetOutitemDetail(String outitem_no, String order_no) {
		System.out.println("UjmOutitemServiceImpl ujmGetOutitemDetail Start...");
		List<UjmOutitem> ujmListOutitemDetail=null;
		ujmListOutitemDetail=uod.ujmGetOutitemDetail(outitem_no, order_no);
		return ujmListOutitemDetail;
	}

	@Override
	public List<UjmOutitem> ujmGetOutitemToUpdate(String order_no, String outitem_no) {
		System.out.println("UjmOutitemServiceImpl : ujmGetOutitemToUpdate Start...");
		List<UjmOutitem> ujmListOutitem=null;
		ujmListOutitem=uod.ujmGetOutitemToUpdate(order_no, outitem_no);
		return ujmListOutitem;
	}

	@Override
	@Transactional
	public int ujmUpdateOutitem(UjmOutitemParent updateData, String userId) {
		System.out.println("UjmOutitemServiceImpl ujmUpdateOutitem Start..." );
		UjmOutitem outitem=new UjmOutitem(); //등록할 출고 객체
		
		System.out.println(userId);
		outitem.setOutitem_emp_id(userId); //로그인된 유저id로 담당자id 설정(변경)
		System.out.println(outitem.getOutitem_emp_id());
		
        System.out.println(updateData.getOutitemData());
        UjmOutitem outitemData=updateData.getOutitemData(); //가져온 출고 객체
        
        //수정일자 추가
        LocalDateTime currentTime = LocalDateTime.now();
        String outitem_update=currentTime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        System.out.println("outitem_update:"+outitem_update);
        outitem.setOutitem_update(outitem_update);
        
        //단순변환
        outitem.setOutitem_no(outitemData.getOutitem_no());
        outitem.setOrder_no(outitemData.getOrder_no());
        
        System.out.println("outitemData.getOutitem_dt():"+outitemData.getOutitem_dt());
        outitem.setOutitem_dt(outitemData.getOutitem_dt());
        
        System.out.println("outitemData.getCust_emp():"+outitemData.getCust_emp());
        outitem.setCust_emp(outitemData.getCust_emp());
        
        System.out.println("outitemData.getRemark():"+outitemData.getRemark());
        outitem.setRemark(outitemData.getRemark());
        
        System.out.println("넣을 outitem:"+outitem);
        
        int updateOutitemResult = uod.ujmUpdateOutitem(outitem); //위에서 조정한 outitem(출고)를 수정
        
		System.out.println("서비스에서 수정된 updateOutitemResult:"+updateOutitemResult);
		
		return updateOutitemResult;
	}

	@Override
	@Transactional
	public int ujmUpdateOutitemItem(UjmOutitemParent updateData) {
		System.out.println("UjmOutitemServiceImpl ujmUpdateOutitemItem Start..." );
		UjmOutitem outitemData=updateData.getOutitemData(); //가져온 출고 객체
		System.out.println(outitemData);
		
		System.out.println(updateData.getSelectedItems());
		 for (UjmOutitemItem item : updateData.getSelectedItems()) { //출고품목 테이블에서 행 하나마다
			 
			 item.setOutitem_no(outitemData.getOutitem_no()); 
			 item.setOrder_no(outitemData.getOrder_no());
			 
			 //수정할때 가져온 품목 코드가 기존에 (등록에) 있었던 출고품목 테이블에 있는지 체크 
			 int itemNotNullCheck=uod.ujmitemNotNullCheck(item);
			 
			 //있으면
			 if(itemNotNullCheck>0) {
				 
				//qty가 0인지 체크
				 if(item.getQty()==0) { //출고품목에서 삭제
				 int ujmDeleteOutitemItem=uod.ujmDeleteOutitemItem(item);
				 System.out.println("UjmOutitemServiceImpl ujmUpdateOutitemItem ujmDeleteOutitemItem:"+ujmDeleteOutitemItem);
				 } else { //정상적인 수정
				 int ujmUpdateOutitemItem =uod.ujmUpdateOutitemItem(item); //해당 item의 qty를 수정
				 System.out.println("UjmOutitemServiceImpl ujmUpdateOutitemItem ujmUpdateOutitemItem:"+ujmUpdateOutitemItem);
				 }
			 } else { //없으면(itemNotNullCheck=0이면), 신규 등록
				 uod.ujmInsertOutitemItem(item);
			 } 
         }
		 int outitemItemCnt=uod.ujmOutitemItemCnt(outitemData); //출고품목 개수 리턴
		 
		return outitemItemCnt;
	}

	@Override
	public String ujmFindOutitemRemark(String outitem_no) {
		System.out.println("UjmOutitemServiceImpl : ujmFindOutitemRemark Start...");
		String outitemRemark=null;
		outitemRemark=uod.ujmFindOutitemRemark(outitem_no);
		System.out.println(outitemRemark);
		return outitemRemark;
	}

	@Override
	public UjmOutitem ujmDateLogic(UjmOutitem outitem) {
		System.out.println(outitem);
		if(outitem.getStart_day() == null && outitem.getEnd_day() == null) {
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
//			String today = LocalDate.now().format(formatter);
			String oneMonthAgo = LocalDate.now().minusMonths(1).format(formatter); 
			String oneMonthAfter = LocalDate.now().plusMonths(1).format(formatter);
			
			outitem.setStart_day(oneMonthAgo);
			outitem.setEnd_day(oneMonthAfter);
		} 
		return outitem;
	}

	@Override
	@Transactional
	public int ujmDeleteOutitem(String outitem_no, String order_no) {
		System.out.println("UjmOutitemServiceImpl ujmDeleteOutitem" );
		
		//outitem_delete_chk을 1로 변경
		int ujmDeleteOutitemCnt = uod.ujmDeleteOutitem(outitem_no);
		System.out.println("UjmOutitemServiceImpl ujmDeleteOutitemCnt->" + ujmDeleteOutitemCnt);
		
		//주문의 order_status_chk를 변경
		int ujmUpdateOrderStatusChkAtDelete = uord.ujmUpdateOrderStatusChkAtDelete(order_no);
		System.out.println("UjmOutitemServiceImpl ujmUpdateOrderStatusChkAtDelete->" + ujmUpdateOrderStatusChkAtDelete);
		
		return ujmDeleteOutitemCnt;
	}



}
