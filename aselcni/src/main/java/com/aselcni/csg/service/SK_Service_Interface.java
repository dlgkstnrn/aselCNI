package com.aselcni.csg.service;

import java.util.List;

import com.aselcni.csg.model.CSG_CategoryData;
import com.aselcni.csg.model.CSG_TB_TYPE_BIG;
import com.aselcni.csg.model.CSG_TB_TYPE_MID;
import com.aselcni.csg.model.CSG_TB_TYPE_SML;

public interface SK_Service_Interface {

	List<CSG_TB_TYPE_BIG> findBigTypelist();


}
