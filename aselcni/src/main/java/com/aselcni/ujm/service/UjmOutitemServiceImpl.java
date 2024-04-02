package com.aselcni.ujm.service;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.aselcni.ujm.dao.ujmOutitemDao;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
@Transactional //jpa에서
public class UjmOutitemServiceImpl implements UjmOutitemService {
	
	private final ujmOutitemDao od;

	@Override
	public int ujmTotalOutitemCnt() {
		System.out.println("UjmOutitemServiceImpl Start ujmTotalOutitemCnt..." );
		int ujmTotalOutitemCnt = od.ujmTotalOutitemCnt();
		System.out.println("UjmOutitemServiceImpl ujmTotalOutitemCnt totEmpCnt->" + ujmTotalOutitemCnt);
		return ujmTotalOutitemCnt;
	}

}
