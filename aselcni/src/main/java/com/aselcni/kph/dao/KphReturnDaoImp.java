package com.aselcni.kph.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.aselcni.kph.model.KphOutItem;
import com.aselcni.kph.model.KphOutItemItem;
import com.aselcni.kph.model.KphReturn;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class KphReturnDaoImp implements KphReturnDao {

	private final SqlSession session;
	private final PlatformTransactionManager transactionManager;
	
	@Override
	public List<KphOutItem> outItemList(KphOutItem kphOutItem) {
		return session.selectList("KphOutItemList", kphOutItem);
	}
	
	@Override
	public List<KphOutItemItem> outItemItemList(KphOutItem outItem) {
		return session.selectList("KphOutItemItemList", outItem);
	}
	
	@Override
	public void returnAdd(KphReturn kphReturn) {
		TransactionStatus txStatus = transactionManager.getTransaction(new DefaultTransactionDefinition());
		
		try {
			int returnCount = session.selectOne("KphReturnCountByOutItemNo", kphReturn);
			session.insert("KphReturnAdd", kphReturn);
			transactionManager.commit(txStatus);
		} catch (Exception e) {
			e.printStackTrace();
			transactionManager.rollback(txStatus);
		}
	}

}