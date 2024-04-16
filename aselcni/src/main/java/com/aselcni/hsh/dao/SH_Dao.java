package com.aselcni.hsh.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import static org.hamcrest.CoreMatchers.nullValue;
import com.aselcni.hsh.model.Procmst;
import com.aselcni.hsh.model.Whmst;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class SH_Dao implements SH_Dao_Interface {
	private final SqlSession session;
//공정정보리스트 가져오기
	@Override
	public List<Procmst> getProcmst(Procmst procmst) {
		List<Procmst> getProcmst = null;
		try {
			getProcmst= session.selectList("HshgetProcmst",procmst);
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
	//아이디 유무확인
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
	//코드중복 확인
	@Override
	public boolean same_pro_cd(String procd) {
		System.out.println("SH_Dao same_Emp_Id start...");
		try {
			String result = session.selectOne("same_pro_cd",procd);
			return !"Yes".equals(result);
		} catch (Exception e) {
			System.out.println("SH_Dao same_pro_cd e.getMessage()->" + e.getMessage());
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
	@Override
	public List<Whmst> getWhmst(Whmst whmst) {
		List<Whmst> getWhmst = null;
		System.out.println("!SH_Dao getStart ->" + whmst.getStart());
		System.out.println("!SH_Dao getEnd ->" + whmst.getEnd());
		System.out.println("!SH_Dao getCurrentPage ->" + whmst.getCurrentPage());
		try {
			getWhmst= session.selectList("HshgetWhmst",whmst);
			System.out.println("!SH_Dao getWhmst ->" + getWhmst);
			System.out.println("!SH_Dao getWhmst size!!!->" + getWhmst.size());

		} catch (Exception e) {
			System.out.println("!!SH_Dao getWhmst e.getMessage()->" + e.getMessage());
			 e.printStackTrace();
		}
		return getWhmst;
	}
	@Override
	public Whmst GetwhmstDetails(String id) {
		Whmst getWhmst = null;
		System.out.println("SH_Dao GetwhmstDetails start...");
		try {
			getWhmst= session.selectOne("GetwhmstDetails",id);
			System.out.println("SH_Dao GetwhmstDetails ->"+"   "+getWhmst);

		} catch (Exception e) {
			System.out.println("SH_Dao GetwhmstDetails e.getMessage()->" + e.getMessage());
		}
		return getWhmst;
	}
	@Override
	public void updatewhmst(Whmst whmst) {
		System.out.println("SH_Dao updatewhmst start...");
		try {
			session.update("updateWhmst", whmst);
			System.out.println("SH_Dao updatewhmst procmst->"+" "+whmst);

		} catch (Exception e) {
			System.out.println("SH_Dao updatewhmst e.getMessage()->" + e.getMessage());
		}
				
	}
	@Override
	public void DelDatewhmst(Whmst whmst) {
		System.out.println("SH_Dao DelDatewhmst start...");
		try {
			session.update("DelDatewhmst", whmst);
			System.out.println("SH_Dao DelDatewhmst procmst->"+" "+whmst);

		} catch (Exception e) {
			System.out.println("SH_Dao DelDatewhmst e.getMessage()->" + e.getMessage());
		}		
	}
	@Override
	public void NewWhmst(Whmst whmst) {

		System.out.println("SH_Dao NewWhmst start...");
		try {
			session.insert("NewWhmst", whmst);
			System.out.println("SH_Dao NewWhmst procmst->"+" "+whmst);

		} catch (Exception e) {
			System.out.println("SH_Dao NewWhmst e.getMessage()->" + e.getMessage());
		}		
	}
	@Override
	public int checkCd(String wh_cd) {
		System.out.println("SH_Dao checkCd start..");
		int checkWdCount= 0;
		try {
			checkWdCount = session.selectOne("hshCheckCd",wh_cd);
			System.out.println("SH_Dao checkCd checkWdCount->"+"  "+checkWdCount);

		} catch (Exception e) {
			System.out.println("SH_Dao checkCd Exception->"+e.getMessage());
		}
		return checkWdCount;
	}
	@Override //페이징 작업
	public int totalprocmst() {
		int totalprocmst = 0;
		System.out.println(" SH_Dao totalprocmst Start procmstTotal...");

		try {
			totalprocmst = session.selectOne("procmstTotal");

		} catch (Exception e) {
			System.out.println("SH_Dao totalprocmst procmstTotal Exception->" + e.getMessage());
		}
		return totalprocmst;
	}
	@Override
	public int totalwhmst() {
		int totalwhmst = 0;
		System.out.println(" SH_Dao totalwhmst Start totalwhmst...");

		try {
			totalwhmst = session.selectOne("totalwhmst");

		} catch (Exception e) {
			System.out.println("SH_Dao totalwhmst totalwhmst Exception->" + e.getMessage());
		}
		return totalwhmst;
	}
	
	/*
	 * @Override public boolean same_Whcode(String wh_cd) {
	 * System.out.println("SH_Dao same_Whcode start..."); try { String result =
	 * session.selectOne("same_Whcode",wh_cd); return !"Yes".equals(result); } catch
	 * (Exception e) { System.out.println("SH_Dao same_Whcode e.getMessage()->" +
	 * e.getMessage()); return false; } }
	 */
	
	
	

}
