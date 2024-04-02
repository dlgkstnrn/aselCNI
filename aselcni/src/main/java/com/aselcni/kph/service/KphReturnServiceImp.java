package com.aselcni.kph.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.aselcni.kph.dao.KphReturnDao;
import com.aselcni.kph.model.KphCustMst;
import com.aselcni.kph.model.KphTypeBig;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class KphReturnServiceImp implements KphReturnService {

	private final KphReturnDao kphReturnDao;

	@Override
	public boolean isOutItem(String outitem_no) {
		boolean isOutItem = false;
		
		int countOutItem = kphReturnDao.countOutItemByOutItemNo(outitem_no);
		
		if(countOutItem > 0) {
			isOutItem = true;
		}
		
		return isOutItem;
	}

	@Override
	public List<KphCustMst> getCustList(KphCustMst cust) {
		List<KphCustMst> custList = kphReturnDao.getCustList(cust);
		return custList;
	}

	@Override
	public List<KphTypeBig> getTypeBigList() {
		return kphReturnDao.getTypeBigList();
	}
	
}
