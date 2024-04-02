package com.aselcni.lhs.dao;

import java.util.List;

import com.aselcni.lhs.model.ItemMst;
import com.aselcni.lhs.model.TypeBig;
import com.aselcni.lhs.model.TypeMid;
import com.aselcni.lhs.model.TypeSml;

public interface ItemMstDao {

	List<TypeBig> selectTypeBig();

	List<TypeMid> selectTypeMid(TypeMid typeMid);

	List<TypeSml> selectTypeSml(TypeSml typeSml);

	int selectItemCntByitemCd(ItemMst itemMst);

	int insertItem(ItemMst itemMst);

	int selectItemCnt(ItemMst itemMst);

	List<ItemMst> selectItemList(ItemMst itemMst);

	ItemMst selectItemByitemCd(ItemMst itemMst);

	int updateItem(ItemMst itemMst);

	int deleteItem(ItemMst itemMst);

}
