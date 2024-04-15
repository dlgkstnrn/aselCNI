package com.aselcni.hsh.dao;

import java.util.List;

import com.aselcni.hsh.model.Procmst;
import com.aselcni.hsh.model.Whmst;

public interface SH_Dao_Interface {



	Procmst GetprocmstDetails(String id);


	boolean same_Emp_Id(String empId);


	void updateProc(Procmst procmst);


	void DelDateProc(Procmst procmst);


	void NewProc(Procmst procmst);




	Whmst GetwhmstDetails(String id);


	void updatewhmst(Whmst whmst);


	void DelDatewhmst(Whmst whmst);


	void NewWhmst(Whmst whmst);


	int checkCd(String wh_cd);


	boolean same_pro_cd(String procd);


	int totalprocmst();


	List<Procmst> getProcmst(Procmst procmst);


	List<Whmst> getWhmst(Whmst whmst);


	int totalwhmst();



}
