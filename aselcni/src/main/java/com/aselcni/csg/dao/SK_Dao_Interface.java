package com.aselcni.csg.dao;


import java.util.List;

import com.aselcni.csg.model.CSG_CategoryData;
import com.aselcni.csg.model.CSG_TB_ITEMMST;
import com.aselcni.csg.model.CSG_TB_TYPE_BIG;
import com.aselcni.csg.model.CSG_TB_TYPE_MID;
import com.aselcni.csg.model.CSG_TB_TYPE_SML;

public interface SK_Dao_Interface {

	List<CSG_TB_TYPE_BIG> findBigTypelist();

	List<CSG_TB_TYPE_MID> CSG_MidType(CSG_TB_TYPE_MID csgMid);

	List<CSG_TB_TYPE_SML> CSG_SmlType(CSG_TB_TYPE_SML csgSml);

	List<CSG_TB_ITEMMST> CSG_SelectedItems(CSG_TB_TYPE_SML items);


}
