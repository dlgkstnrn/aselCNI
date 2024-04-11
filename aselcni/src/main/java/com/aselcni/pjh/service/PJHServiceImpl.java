package com.aselcni.pjh.service;

import java.time.LocalDate;
import java.util.List;

import org.springframework.stereotype.Service;

import com.aselcni.pjh.dao.PJHDaoInterface;
import com.aselcni.pjh.model.PJHInitem;
import com.aselcni.pjh.model.PJHPurchase;
import com.aselcni.pjh.model.PJHPurchaseItem;
import com.aselcni.pjh.model.PJHWhmst;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class PJHServiceImpl implements PJHServiceInterface {

	private final PJHDaoInterface dao;

	@Override
	public List<PJHPurchase> searchPurc(PJHPurchase purchase) {
		setSearchPurcPeriod(purchase);
		
		List<PJHPurchase> purchases = dao.searchPurc(purchase);
		System.out.println("PJHServiceImpl searchPurc purchases.size()->"+ purchases.size());
		return purchases;
	}

	private void setSearchPurcPeriod(PJHPurchase purchase) {
		LocalDate now = LocalDate.now();
		System.out.println("PJHServiceImpl setSearchPurcPeriod now->"+ now);
		System.out.println(purchase.getPeriod());
		String stringDate = now.toString();
		switch (purchase.getPeriod()) {
			case "1":
				System.out.println("1일 차감");
				stringDate = now.minusDays(1).toString();
				break;
			case "2":
				System.out.println("7일 차감");
				stringDate = now.minusDays(7).toString();
				break;
			case "3":
				System.out.println("30일 차감");
				stringDate = now.minusDays(30).toString();
				break;
			default:
				System.out.println("디폴트");
				break;
		}
		purchase.setPurc_dt(stringDate);
		System.out.println(purchase.getPurc_dt());
	}

	@Override
	public List<PJHPurchaseItem> getItemsByPurc(String purc_no) {
		System.out.println("PJHServiceImpl getItemsByPurc start...");
		
		List<PJHPurchaseItem> purchaseItems = dao.getItemsByPurc(purc_no);
		
		System.out.println("PJHServiceImpl getItemsByPurc purchaseItems->"+ purchaseItems.size());
		
		return purchaseItems;
	}

	@Override
	public List<PJHWhmst> getWhList() {
		System.out.println("PJHServiceImpl getWhList start...");
		List<PJHWhmst> whmsts = dao.getWhList();
		return whmsts;
	}

	@Override
	public int registInitem(PJHInitem initem) {
		System.out.println("PJHServiceImpl registInitem start...");
		return dao.registInitem(initem);
	}

	@Override
	public int getTotalInitemNum(PJHInitem initem) {
		System.out.println("PJHServiceImpl getTotalInitemNum start...");
		if(initem.getStart_date() == null || initem.getStart_date() == "") {
			initem.setStart_date(LocalDate.now().toString());
		}
		if(initem.getEnd_date() == null || initem.getEnd_date() == "") {
			initem.setEnd_date(LocalDate.now().toString());
		}
		return dao.getTotalInitemNum(initem);
	}

	@Override
	public List<PJHInitem> getInitemList(PJHInitem initem) {
		System.out.println("PJHServiceImpl getInitemList start...");
		return dao.getInitemList(initem);
	}

	@Override
	public PJHInitem detailInitem(PJHInitem initem) {
		System.out.println("PJHServiceImpl detailInitem start...");
		return dao.detailInitem(initem);
	}

	@Override
	public int updateInitem(PJHInitem initem) {
		System.out.println("PJHServiceImpl updateInitem start...");
		return dao.updateInitem(initem);
	}

	@Override
	public int deleteInitem(PJHInitem initem) {
		System.out.println("PJHServiceImpl deleteInitem start...");
		return dao.deleteInitem(initem);
	}
	
	
	
}
