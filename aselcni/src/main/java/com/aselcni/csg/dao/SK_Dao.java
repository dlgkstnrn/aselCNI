package com.aselcni.csg.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.aselcni.csg.model.CSG_TB_ITEMMST;
import com.aselcni.csg.model.CSG_TB_TYPE_BIG;
import com.aselcni.csg.model.CSG_TB_TYPE_MID;
import com.aselcni.csg.model.CSG_TB_TYPE_SML;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class SK_Dao implements SK_Dao_Interface {
	
	private final SqlSession session;

	//모달의 대분류 카테고리들 만들기
	@Override
	public List<CSG_TB_TYPE_BIG> findBigTypelist() {
		System.out.println("dao에서 bigType을 불러오자고");
		
		List<CSG_TB_TYPE_BIG> bigTypeList = session.selectList("SK_bigTypeList");
		System.out.println("DB에서 불러오게 된 bigTypeList ==>"+bigTypeList);
		
		return bigTypeList;
	}

	//모달의 중분류 카테고리들 만들기
	@Override
	public List<CSG_TB_TYPE_MID> CSG_MidType(CSG_TB_TYPE_MID csgMid) {
		
		List<CSG_TB_TYPE_MID> midTypeList = null;
		System.out.println(csgMid.getBig_no());
		try {
			midTypeList = session.selectList("SK_MidTypeList", csgMid);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return midTypeList;
	}
	
	//모달의 소분류 카테고리들 만들기
	@Override
	public List<CSG_TB_TYPE_SML> CSG_SmlType(CSG_TB_TYPE_SML csgSml) {
		
		List<CSG_TB_TYPE_SML> smlTypeList = null;
		System.out.println(csgSml.getBig_no());
		try {
			smlTypeList = session.selectList("SK_smlTypeList", csgSml);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return smlTypeList;
	}

	//모달에서 대중소분류 선택 후에 선택된 아이템리스트들 가져오기
	@Override
	public List<CSG_TB_ITEMMST> CSG_SelectedItems(CSG_TB_TYPE_SML items) {
		System.out.println("dao에서 모달에서 선택된 아이템 리스트 DB로 보내기전 items @@@@@====>"+items);
		
		List<CSG_TB_ITEMMST> selectedItemList = null;
		try {
			selectedItemList = session.selectList("selectedItemsList", items);
			System.out.println("아이템리스트들을 잘 불러왔니?? selectedItemList==>"+selectedItemList);
		}catch (Exception e) {
			System.out.println(selectedItemList);
		}
		
		System.out.println("dao에서 모달에서 선택된 아이템 리스트 DB에서 가져왔니?? ----->");

		return selectedItemList;
	}
	

}
