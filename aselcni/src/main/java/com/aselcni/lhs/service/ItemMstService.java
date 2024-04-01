package com.aselcni.lhs.service;

import java.util.List;

import com.aselcni.lhs.model.ItemMst;
import com.aselcni.lhs.model.TypeBig;
import com.aselcni.lhs.model.TypeMid;
import com.aselcni.lhs.model.TypeSml;

public interface ItemMstService {

	List<TypeBig> selectTypeBig();

	List<TypeMid> selectTypeMid(TypeMid typeMid);

	List<TypeSml> selectTypeSml(TypeSml typeSml);

	int selectItemCnt(ItemMst itemMst);

	int insertItem(ItemMst itemMst);

}
