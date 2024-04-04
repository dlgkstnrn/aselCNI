package com.aselcni.hsh.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import static org.hamcrest.CoreMatchers.nullValue;
import com.aselcni.hsh.model.Procmst;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class SH_Dao implements SH_Dao_Interface {
	private final SqlSession session;
//공정정보리스트 가져오기
	@Override
	public List<Procmst> getProcmst() {
		List<Procmst> getProcmst = null;
		try {
			getProcmst= session.selectList("HshgetProcmst");
		} catch (Exception e) {
			System.out.println("SH_Dao getProcmst e.getMessage()->" + e.getMessage());
		}
		return getProcmst;
	}
	//상세공정가져오기
	@Override
	public Procmst GetprocmstDetails(String id) {
		Procmst getProcmst = null;
		System.out.println("SH_Dao GetprocmstDetails start...");
		try {
			getProcmst= session.selectOne("GetprocmstDetails",id);
		} catch (Exception e) {
			System.out.println("SH_Dao GetprocmstDetails e.getMessage()->" + e.getMessage());
		}
		return getProcmst;
	}
	@Override
	public boolean same_Emp_Id(String empId) {
		System.out.println("SH_Dao same_Emp_Id start...");
		try {
			String result = session.selectOne("same_Emp_Id",empId);
			return !"No".equals(result);
		} catch (Exception e) {
			System.out.println("SH_Dao same_Emp_Id e.getMessage()->" + e.getMessage());
			return false;
		}
		
	}
	@Override
	public void updateProc(Procmst procmst) {
		System.out.println("SH_Dao updateProc start...");
		try {
			session.update("updateProc", procmst);
			System.out.println("SH_Dao updateProc procmst->"+" "+procmst);

		} catch (Exception e) {
			System.out.println("SH_Dao updateProc e.getMessage()->" + e.getMessage());
		}
		
	}
	@Override
	public void DelDateProc(Procmst procmst) {
		System.out.println("SH_Dao DelDateProc start...");
		try {
			session.update("DelDateProc", procmst);
			System.out.println("SH_Dao DelDateProc procmst->"+" "+procmst);

		} catch (Exception e) {
			System.out.println("SH_Dao DelDateProc e.getMessage()->" + e.getMessage());
		}		
	}
	@Override
	public void NewProc(Procmst procmst) {
		System.out.println("SH_Dao NewProc start...");
		try {
			session.insert("NewProc", procmst);
			System.out.println("SH_Dao NewProc procmst->"+" "+procmst);

		} catch (Exception e) {
			System.out.println("SH_Dao NewProc e.getMessage()->" + e.getMessage());
		}		
	}

}
