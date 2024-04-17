package com.aselcni.pjh.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.hibernate.service.spi.Stoppable;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.aselcni.pjh.model.PJHInitem;
import com.aselcni.pjh.model.PJHInitemItem;
import com.aselcni.pjh.model.PJHPurchase;
import com.aselcni.pjh.model.PJHPurchaseItem;
import com.aselcni.pjh.model.PJHWhmst;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class PJHDaoImpl implements PJHDaoInterface {

	private final SqlSession session;
	private final PlatformTransactionManager transactionManager;
	
	@Override
	public List<PJHPurchase> searchPurc(PJHPurchase purchase) {
		List<PJHPurchase> purchases = null;
		System.out.println("PJHDaoImpl searchPurc param->"+ purchase.getPeriod()+purchase.getPurc_dt()+purchase.getCust_nm()+purchase.getPurc_no());
		try {
			purchases = session.selectList("pjhSearchPurc", purchase);
			System.out.println("PJHDaoImpl searchPurc purchases.size()->"+ purchases.size());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return purchases;
	}

	@Override
	public List<PJHPurchaseItem> getItemsByPurc(String purc_no) {
		System.out.println("PJHDaoImpl getItemsByPurc start...");
		System.out.println("PJHDaoImpl getItemsByPurc purc_no->"+ purc_no);
		
		List<PJHPurchaseItem> purchaseItems = null;
		try {
			purchaseItems = session.selectList("pjhItemsByPurc", purc_no);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		System.out.println("PJHDaoImpl getItemsByPurc purchaseItems->"+ purchaseItems);
		return purchaseItems;
	}

	@Override
	public List<PJHWhmst> getWhList() {
		List<PJHWhmst> whmsts = null;
		
		try {
			whmsts = session.selectList("pjhWhs", whmsts);
			System.out.println("PJHDaoImpl getWhList whmsts->"+ whmsts);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return whmsts;
	}

	@Override
	public int registInitem(PJHInitem initem) {
		System.out.println("PJHDaoImpl registInitem start...");
		int result = 0;
		TransactionStatus txStatus = transactionManager.getTransaction(new DefaultTransactionDefinition());
		
		try {
			String initem_no = session.selectOne("pjhCreateInitemNo", initem);
			System.out.println("PJHDaoImpl registInitem initem_no->"+ initem_no);
			initem.setInitem_no(initem_no);
			initem.getInItems().forEach(item -> item.setInitem_no(initem_no));
			System.out.println("PJHDaoImpl registInitem initem->"+ initem);
			result = session.insert("pjhRegistInitem", initem);
			if(result == 0)
				throw new Exception("인서트 안들어감");
			result = 0;
			for(PJHInitemItem item : initem.getInItems())
				result += session.insert("pjhInsertInitems", item);
			if(result != initem.getInItems().size())
				throw new Exception("인서트 안들어감");
			
			if(initem.getInitem_end() == 0) {
				int totalItemRemain = 0;
				List<PJHPurchaseItem> items = session.selectList("pjhItemsByPurc", initem.getPurc_no());
				for(PJHPurchaseItem item : items) {
					totalItemRemain += item.getQty();
				}
				if(totalItemRemain == 0) {
					initem.setStatus(2);
				} else {
					initem.setStatus(1);
				}
				System.out.println("PJHDaoImpl registInitem totalItemRemain->"+ totalItemRemain);
				session.update("pjhChangePurcStatus", initem);
			} else {
				session.update("pjhEndPurcStatus",initem.getPurc_no());
			}
			transactionManager.commit(txStatus);
		} catch (Exception e) {
			transactionManager.rollback(txStatus);
	        e.printStackTrace();
			result = 0;
		}
		System.out.println("PJHDaoImpl registInitem result->"+ result);
		return result;
	}

	@Override
	public int getTotalInitemNum(PJHInitem initem) {
		System.out.println("PJHDaoImpl getTotalInitemNum start...");
		System.out.println("PJHDaoImpl getTotalInitemNum initem->"+ initem);
		int total = 0;
		try {
			total = session.selectOne("pjhTotalInitem", initem);
			System.out.println("PJHDaoImpl getTotalInitemNum total->"+ total);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return total;
	}

	@Override
	public List<PJHInitem> getInitemList(PJHInitem initem) {
		System.out.println("PJHDaoImpl getInitemList start...");
		System.out.println("PJHDaoImpl getInitemList initem->"+ initem);
		List<PJHInitem> initems = null;
		try {
			initems = session.selectList("pjhInitemList",initem);
			System.out.println("PJHDaoImpl getInitemList initems.size()->"+ initems.size());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return initems;
	}

	@Override
	public PJHInitem detailInitem(PJHInitem initem) {
		System.out.println("PJHDaoImpl detailInitem start...");
		System.out.println("PJHDaoImpl detailInitem initem->"+ initem);
		PJHInitem resultInitem = null;
		try {
			resultInitem = session.selectOne("pjhInitemByNo", initem.getInitem_no());
			resultInitem.setInItems(session.selectList("pjhInitems", resultInitem.getInitem_no()));
			resultInitem.setWhs(session.selectList("pjhWhs"));
			System.out.println("PJHDaoImpl detailInitem whs->"+ resultInitem.getWhs());
			System.out.println("PJHDaoImpl detailInitem result->"+ resultInitem);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultInitem;
	}

	@Override
	public int updateInitem(PJHInitem initem) {
		System.out.println("PJHDaoImpl updateInitem start...");
		int result = 0;
		System.out.println("PJHDaoImpl updateInitem initem->"+ initem);
		TransactionStatus txStatus = transactionManager.getTransaction(new DefaultTransactionDefinition());
		try {
			// TB_INITEM 수정 부분
			result = session.update("pjhUpdateInitem", initem);
			if( result < 1)
				throw new Exception("INITEM 입력 오류");
			// TB_INITEM_ITEM 수정 부분
			if(initem.getInItems().size() > 0) {
				result = session.update("pjhUpdateInitemItem", initem.getInItems());
				if(result < 1)
					throw new Exception("INITEM_ITEM 입력 오류");
				//for(PJHInitemItem item : initem.getInItems()) {
				//}
			}
			// 수정이후 TB_PURCHASE 상태 변경 부분
			if(initem.getInitem_end() == 0) {
				int totalItemRemain = 0;
				List<PJHPurchaseItem> items = session.selectList("pjhItemsByPurc", initem.getPurc_no());
				for(PJHPurchaseItem item : items) {
					totalItemRemain += item.getQty();
				}
				if(totalItemRemain == 0) {
					initem.setStatus(2);
				} else {
					initem.setStatus(1);
				}
				System.out.println("PJHDaoImpl updateInitem totalItemRemain->"+ totalItemRemain);
				session.update("pjhChangePurcStatus", initem);
			} else {
				session.update("pjhEndPurcStatus",initem.getPurc_no());
			}
			transactionManager.commit(txStatus);
		} catch (Exception e) {
			transactionManager.rollback(txStatus);
			e.printStackTrace();
			result = -1;
		}
		System.out.println("PJHDaoImpl updateInitem result->"+ result);
		return result;
	}

	@Override
	public int deleteInitem(PJHInitem initem) {
		System.out.println("PJHDaoImpl deleteInitem start...");
		int result = 0;
		TransactionStatus txStatus = transactionManager.getTransaction(new DefaultTransactionDefinition());
		try {
			result = session.update("pjhDeleteInitem",initem);
			
			// 삭제이후 TB_PURCHASE 상태 변경 부분
			int totalItemRemain = 0;
			List<PJHPurchaseItem> items = session.selectList("pjhItemsByPurc", initem.getPurc_no());
			System.out.println("PJHDaoImpl deleteInitem delete totalItems->"+ items);
			for(PJHPurchaseItem item : items) {
				totalItemRemain += item.getQty();
			}
			if(totalItemRemain == 0) {
				initem.setStatus(2);
			} else {
				initem.setStatus(1);
				int initemCount = session.selectOne("pjhInitemCount", initem.getPurc_no());
				System.out.println("PJHDaoImpl deleteInitem initemCount->"+ initemCount);
				if(initemCount == 0)
					initem.setStatus(0);
			}
			System.out.println("PJHDaoImpl deleteInitem totalItemRemain->"+ totalItemRemain);
			session.update("pjhChangePurcStatus", initem);
			
			
			transactionManager.commit(txStatus);
		} catch (Exception e) {
			transactionManager.rollback(txStatus);
			e.printStackTrace();
			result = -1;
		}
		System.out.println("PJHDaoImpl deleteInitem result->"+ result);
		return result;
	}
	
}
