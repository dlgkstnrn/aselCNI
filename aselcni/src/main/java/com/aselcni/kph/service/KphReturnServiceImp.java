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
	
	@Override
	public int totalReturnCount(KphReturn kphReturn) {
		return kphReturnDao.totalReturnCount(kphReturn);
	}
	
	@Override
	public List<KphReturn> returnList(KphReturn kphReturn) {
		return kphReturnDao.returnList(kphReturn);
	}
	
	@Override
	public KphReturn getReturn(KphReturn kphReturn) {
		KphReturn returnObj = kphReturnDao.getReturn(kphReturn);
		int maxQty = kphReturnDao.getUsableOutItemQty(returnObj);
		returnObj.setMax_qty(maxQty);
		return returnObj;
	}
	
	@Override
	public void returnDelete(KphReturn kphReturn) {
		kphReturnDao.returnDelete(kphReturn);
	}
	
	@Override
	public void returnUpdate(KphReturn kphReturn) {
		kphReturnDao.returnUpdate(kphReturn);
	}
	
}
