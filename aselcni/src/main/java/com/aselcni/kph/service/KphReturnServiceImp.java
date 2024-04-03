package com.aselcni.kph.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.aselcni.kph.dao.KphReturnDao;
import com.aselcni.kph.model.KphOutItem;
import com.aselcni.kph.model.KphOutItemItem;
import com.aselcni.kph.model.KphReturn;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class KphReturnServiceImp implements KphReturnService {

	private final KphReturnDao kphReturnDao;
	
	
	@Override
	public List<KphOutItem> outItemList(KphOutItem kphOutItem) {
		return kphReturnDao.outItemList(kphOutItem);
	}
	
	@Override
	public List<KphOutItemItem> outItemItemList(KphOutItem outItem) {
		return kphReturnDao.outItemItemList(outItem);
	}

	@Override
	public void returnAdd(KphReturn kphReturn) {
		
		kphReturnDao.returnAdd(kphReturn);
	}
	
}
