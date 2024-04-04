package com.aselcni.csg.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.aselcni.csg.dao.SK_Dao_Interface;
import com.aselcni.csg.model.CSG_TB_ITEMMST;
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

	@Override
	public List<CSG_TB_TYPE_MID> CSG_MidType(CSG_TB_TYPE_MID csgMid) {
		System.out.println("service에서 대분류 선택하고 중분류 애들 골라보자");
		List<CSG_TB_TYPE_MID> midTypeList = sk_Dao_Interface.CSG_MidType(csgMid);
		
		return midTypeList;
	}

	@Override
	public List<CSG_TB_TYPE_SML> CSG_SmlType(CSG_TB_TYPE_SML csgSml) {
		System.out.println("service에서 중분류 선택하고 소분류 애들 골라보자");
		List<CSG_TB_TYPE_SML> smlTypeList = sk_Dao_Interface.CSG_SmlType(csgSml);

		return smlTypeList;
	}

	@Override
	public List<CSG_TB_ITEMMST> CSG_SelectedItems(CSG_TB_TYPE_SML items) {
		System.out.println("서비스에서 모달에서 대중소분류 선택된 아이템테이블 가져와보자");
		List<CSG_TB_ITEMMST> selectedItemList = sk_Dao_Interface.CSG_SelectedItems(items);
		
		//System.out.println("서비스에서 모달에서 대중소분류 선택된 itemsList DB에서 가져온것들===>"+selectedItemList);

		return selectedItemList;
	}



}
