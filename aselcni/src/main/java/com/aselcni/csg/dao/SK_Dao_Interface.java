package com.aselcni.csg.dao;


import java.util.List;

import com.aselcni.csg.model.CSG_CategoryData;
import com.aselcni.csg.model.CSG_TB_CUSTMST;
import com.aselcni.csg.model.CSG_TB_ITEMMST;
import com.aselcni.csg.model.CSG_TB_PURCHASE;
import com.aselcni.csg.model.CSG_TB_PURCHASE_ITEM;
import com.aselcni.csg.model.CSG_TB_TYPE_BIG;
import com.aselcni.csg.model.CSG_TB_TYPE_MID;
import com.aselcni.csg.model.CSG_TB_TYPE_SML;

public interface SK_Dao_Interface {

	List<CSG_TB_CUSTMST> findCustlist();

	List<CSG_TB_TYPE_BIG> findBigTypelist(String custCd);

	List<CSG_TB_TYPE_MID> CSG_MidType(CSG_TB_TYPE_MID csgMid);

	List<CSG_TB_TYPE_SML> CSG_SmlType(CSG_TB_TYPE_SML csgSml);

	List<CSG_TB_ITEMMST> CSG_SelectedItems(CSG_TB_TYPE_SML items);

	CSG_TB_PURCHASE findCustEmployeeByCustCd(String custCd);

	List<CSG_TB_PURCHASE> findAllPurchase(CSG_TB_PURCHASE csg_TB_PURCHASE);

	int totalPurchase(CSG_TB_PURCHASE csg_TB_PURCHASE);

	String inserForPurchaseToPurcNo();

	void insertPurchase(CSG_TB_PURCHASE purchaseAndItem);

	void insertPurchaseItem(CSG_TB_PURCHASE_ITEM purchase_item);

	List<CSG_TB_PURCHASE> findById(String id);

	void updateDeleteFlagById(String id);







}
