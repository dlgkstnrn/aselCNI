package com.aselcni.pjh.dao;

import java.util.List;

import com.aselcni.pjh.model.PJHInitem;
import com.aselcni.pjh.model.PJHPurchase;
import com.aselcni.pjh.model.PJHPurchaseItem;
import com.aselcni.pjh.model.PJHWhmst;

public interface PJHDaoInterface {

	List<PJHPurchase> searchPurc(PJHPurchase purchase);

	List<PJHPurchaseItem> getItemsByPurc(String purc_no);

	List<PJHWhmst> getWhList();

	int registInitem(PJHInitem initem);

	int getTotalInitemNum(PJHInitem initem);

	List<PJHInitem> getInitemList(PJHInitem initem);

	PJHInitem detailInitem(PJHInitem initem);

	int updateInitem(PJHInitem initem);

	int deleteInitem(PJHInitem initem);

}
