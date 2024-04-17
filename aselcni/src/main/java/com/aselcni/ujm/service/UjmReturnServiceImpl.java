package com.aselcni.ujm.service;

import org.springframework.stereotype.Service;

import com.aselcni.ujm.dao.UjmReturnDao;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class UjmReturnServiceImpl implements UjmReturnService {
	
	private final UjmReturnDao urd;
	
	@Override
	public int ujmReturnChk(String outitem_no) {
		System.out.println(outitem_no);
		int ujmReturnChk=urd.ujmReturnChk(outitem_no); 
		return ujmReturnChk;
	}

	

}
