package com.aselcni.psa.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
//import org.springframework.transaction.PlatformTransactionManager;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class PsaWorkProdDaoImpl implements PsaWorkProdDao {
	
	private final SqlSession session;
//	private final PlatformTransactionManager tm;

}
