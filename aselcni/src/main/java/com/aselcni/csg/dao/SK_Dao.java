package com.aselcni.csg.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.aselcni.csg.model.CSG_CategoryData;
import com.aselcni.csg.model.CSG_TB_TYPE_BIG;
import com.aselcni.csg.model.CSG_TB_TYPE_MID;
import com.aselcni.csg.model.CSG_TB_TYPE_SML;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class SK_Dao implements SK_Dao_Interface {
	
	private final SqlSession session;

	@Override
	public List<CSG_TB_TYPE_BIG> findBigTypelist() {
		System.out.println("dao에서 bigType을 불러오자고");
		
		List<CSG_TB_TYPE_BIG> bigTypeList = session.selectList("bigTypeList");
		System.out.println("DB에서 불러오게 된 bigTypeList ==>"+bigTypeList);
		
		return bigTypeList;
	}
	

}
