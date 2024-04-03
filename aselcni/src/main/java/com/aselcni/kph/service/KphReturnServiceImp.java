package com.aselcni.kph.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.aselcni.kph.dao.KphReturnDao;
import com.aselcni.kph.model.KphCustMst;
import com.aselcni.kph.model.KphItemMst;
import com.aselcni.kph.model.KphOutItem;
import com.aselcni.kph.model.KphTypeBig;
import com.aselcni.kph.model.KphTypeMid;
import com.aselcni.kph.model.KphTypeSml;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class KphReturnServiceImp implements KphReturnService {

	private final KphReturnDao kphReturnDao;
	
	@Override
	public List<KphOutItem> outItemList(KphOutItem kphOutItem) {
		return kphReturnDao.outItemList(kphOutItem);
	}
	
}
