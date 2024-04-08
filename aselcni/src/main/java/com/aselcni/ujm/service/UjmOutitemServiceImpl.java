package com.aselcni.ujm.service;

import java.util.List;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.aselcni.ujm.dao.UjmOutitemDao;
import com.aselcni.ujm.model.UjmOrderNoDto;
import com.aselcni.ujm.model.UjmOutitem;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
@Transactional //jpa에서
public class UjmOutitemServiceImpl implements UjmOutitemService {
	
	private final UjmOutitemDao uod;

	@Override
	public int ujmTotalOutitemCnt() {
		System.out.println("UjmOutitemServiceImpl Start ujmTotalOutitemCnt..." );
		int ujmTotalOutitemCnt = uod.ujmTotalOutitemCnt();
		System.out.println("UjmOutitemServiceImpl ujmTotalOutitemCnt totEmpCnt->" + ujmTotalOutitemCnt);
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
	public List<UjmOrderNoDto> ujmGetOrderNo() {
		List<UjmOrderNoDto> ujmListOrderNo = null;
		 System.out.println("UjmOutitemServiceImpl ujmGetOrderNo Start..." );
		 ujmListOrderNo = uod.ujmGetOrderNo();
		 if(ujmListOrderNo!=null) {
			 System.out.println("UjmOutitemServiceImpl ujmListOrderNo ujmListOrderNo.size()->" +ujmListOrderNo.size()); 
		 }
		 return ujmListOrderNo;
	}

}
