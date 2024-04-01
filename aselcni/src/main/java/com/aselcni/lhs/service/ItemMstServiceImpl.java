package com.aselcni.lhs.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.aselcni.lhs.dao.ItemMstDao;
import com.aselcni.lhs.model.ItemMst;
import com.aselcni.lhs.model.TypeBig;
import com.aselcni.lhs.model.TypeMid;
import com.aselcni.lhs.model.TypeSml;

import lombok.RequiredArgsConstructor;
@Service
@RequiredArgsConstructor
public class ItemMstServiceImpl implements ItemMstService {

	private final ItemMstDao itemMstDao;
	
	@Override
	public List<TypeBig> selectTypeBig() {
		return itemMstDao.selectTypeBig();
	}
	
	@Override
	public List<TypeMid> selectTypeMid(TypeMid typeMid) {
		return itemMstDao.selectTypeMid(typeMid);
	}
	
	@Override
	public List<TypeSml> selectTypeSml(TypeSml typeSml) {
		return itemMstDao.selectTypeSml(typeSml);
	}
	
	@Override
	public int selectItemCnt(ItemMst itemMst) {
		return itemMstDao.selectItemCnt(itemMst);
	}
	
	@Override
	public int insertItem(ItemMst itemMst) {
		return itemMstDao.insertItem(itemMst);
	}

}
