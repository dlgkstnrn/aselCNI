package com.aselcni.lhs.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.aselcni.lhs.model.ItemMst;
import com.aselcni.lhs.model.TypeBig;
import com.aselcni.lhs.model.TypeMid;
import com.aselcni.lhs.model.TypeSml;

import lombok.RequiredArgsConstructor;
@Repository
@RequiredArgsConstructor
public class ItemMstDaoImpl implements ItemMstDao {

	private final SqlSession session;
	
	@Override
	public List<TypeBig> selectTypeBig() {
		return session.selectList("selectListTypeBig");
	}
	
	@Override
	public List<TypeMid> selectTypeMid(TypeMid typeMid) {
		return session.selectList("selectListTypeMid",typeMid);
	}
	
	@Override
	public List<TypeSml> selectTypeSml(TypeSml typeSml) {
		return session.selectList("selectListTypeSml", typeSml);
	}
	
	@Override
	public int selectItemCnt(ItemMst itemMst) {
		return session.selectOne("selectItemCnt", itemMst);
	}
	
	@Override
	public int insertItem(ItemMst itemMst) {
		return session.insert("insertItem", itemMst);
	}

}
