package com.aselcni.hsh.service;

import java.util.List;

import javax.sql.DataSource;

import org.springframework.stereotype.Service;

import com.aselcni.hsh.dao.SH_Dao;
import com.aselcni.hsh.model.Procmst;
import com.aselcni.hsh.model.Whmst;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class SH_Service implements SH_Service_Interface {
private final SH_Dao sd;

	//공정리스트 전달
	@Override
	public List<Procmst> getProcmst(Procmst procmst) {
		List<Procmst> getProcmsts = null;
		getProcmsts = sd.getProcmst(procmst);
		return getProcmsts;
	}
	
	//모달에 상세공정 전달
	@Override
	public Procmst GetprocmstDetails(String id) {
		Procmst procmst = sd.GetprocmstDetails(id);
		return procmst;
	}
	@Override //회원아이디 중복코드확인
	public boolean same_Emp_Id(String empId) {
		
		boolean same = sd.same_Emp_Id(empId);
		System.out.println("SH_Service same_Emp_Id  same->"+same);

		return same;
	}
	
	@Override //공정 중복코드 확인
	public boolean same_pro_cd(String procd) {
		boolean procds = sd.same_pro_cd(procd);
		System.out.println("SH_Service same_pro_cd  procd->"+procd);

		return procds;
	}
	
	@Override
	public void updateProc(Procmst procmst) {
		System.out.println("SH_Service updateProc  procmst->"+procmst);
		sd.updateProc(procmst);
	}
	@Override
	public void DelDateProc(Procmst procmst) {
		System.out.println("SH_Service DelDateProc  procmst->"+procmst);
		sd.DelDateProc(procmst);

	}
	@Override
	public void NewProc(Procmst procmst) {
		System.out.println("SH_Service NewProc  procmst->"+procmst);
		sd.NewProc(procmst);
	}
	@Override
	public List<Whmst> getWhmst(Whmst whmst) {
		List<Whmst> getWhmst = null;
		getWhmst = sd.getWhmst(whmst);
		return getWhmst;
	}
	@Override
	public Whmst GetwhmstDetails(String id) {
		Whmst whmst = sd.GetwhmstDetails(id);
		System.out.println("SH_Service GetwhmstDetails  whmst->"+whmst);

		return whmst;
	}
	@Override //창고업데이트
	public void updateWhmst(Whmst whmst) {
		System.out.println("SH_Service updateWhmst  whmst->"+"   "+whmst);
		sd.updatewhmst(whmst);

		
	}
	@Override //창고삭제
	public void DelDatewhmst(Whmst whmst) {
		System.out.println("SH_Service DelDatewhmst  whmst->"+whmst);
		sd.DelDatewhmst(whmst);		
	}
	@Override //창고추가
	public void NewWhmst(Whmst whmst) {
		System.out.println("SH_Service NewWhmst  whmst->"+whmst);
		sd.NewWhmst(whmst);
	}
	@Override
	public int checkCd(String wh_cd) {
		System.out.println("SH_Service checkCd ...");
		int checkCd=0;
		checkCd=sd.checkCd(wh_cd);
		return checkCd;
	}
	@Override //페이징 작업
	public int totalprocmst() {
		int totprocmst = sd.totalprocmst();
		return totprocmst;
	}
	@Override
	public int totalwhmst() {
		int totalwhmst = sd.totalwhmst();
		return totalwhmst;
	}

	

	/*
	 * @Override public boolean same_Whcode(String wh_cd) { boolean same =
	 * sd.same_Whcode(wh_cd);
	 * System.out.println("SH_Service same_Emp_Id  same->"+same);
	 * 
	 * return same; }
	 */

}
