package com.aselcni.csg.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.aselcni.csg.dao.SK_Dao_Interface;
import com.aselcni.csg.model.CSG_TB_TYPE_BIG;
import com.aselcni.csg.model.CSG_TB_TYPE_MID;
import com.aselcni.csg.model.CSG_TB_TYPE_SML;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class SK_Service implements SK_Service_Interface {
	
	private final SK_Dao_Interface sk_Dao_Interface;

	@Override
	public List<CSG_TB_TYPE_BIG> findBigTypelist() {
		System.out.println("Service에서 bigType을 불러오자고");
		List<CSG_TB_TYPE_BIG> bigTypeList = sk_Dao_Interface.findBigTypelist();
		return bigTypeList;
	}



}
