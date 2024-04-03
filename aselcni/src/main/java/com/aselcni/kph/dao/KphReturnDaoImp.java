package com.aselcni.kph.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.aselcni.kph.model.KphCustMst;
import com.aselcni.kph.model.KphItemMst;
import com.aselcni.kph.model.KphOutItem;
import com.aselcni.kph.model.KphTypeBig;
import com.aselcni.kph.model.KphTypeMid;
import com.aselcni.kph.model.KphTypeSml;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class KphReturnDaoImp implements KphReturnDao {

	private final SqlSession session;
	
	@Override
	public List<KphOutItem> outItemList(KphOutItem kphOutItem) {
		return session.selectList("KphOutItemList", kphOutItem);
	}

}
