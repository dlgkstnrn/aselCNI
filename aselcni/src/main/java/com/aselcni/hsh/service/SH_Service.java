package com.aselcni.hsh.service;

import java.util.List;

import javax.sql.DataSource;

import org.springframework.stereotype.Service;

import com.aselcni.hsh.dao.SH_Dao;
import com.aselcni.hsh.model.Procmst;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class SH_Service implements SH_Service_Interface {
private final SH_Dao sd;

	//공정리스트 전달
	@Override
	public List<Procmst> getProcmst() {
		List<Procmst> getProcmsts = sd.getProcmst();
		return getProcmsts;
	}
	
	//모달에 상세공정 전달
	@Override
	public Procmst GetprocmstDetails(String id) {
		Procmst procmst = sd.GetprocmstDetails(id);
		return procmst;
	}
	@Override
	public boolean same_Emp_Id(String empId) {
		
		boolean same = sd.same_Emp_Id(empId);
		System.out.println("SH_Service same_Emp_Id  same->"+same);

		return same;
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

}
