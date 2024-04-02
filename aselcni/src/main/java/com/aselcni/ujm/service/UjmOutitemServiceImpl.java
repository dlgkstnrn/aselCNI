package com.aselcni.ujm.service;

import java.util.List;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.aselcni.ujm.dao.UjmOutitemDao;
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
			 System.out.println("EmpServiceImpl listEmp empList.size()->" +ujmListOutitems.size()); 
		 }
		 return ujmListOutitems;
	}

}
