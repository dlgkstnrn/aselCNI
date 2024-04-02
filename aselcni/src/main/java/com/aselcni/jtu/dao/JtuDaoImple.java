package com.aselcni.jtu.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.aselcni.psa.model.ProdItem;
import com.aselcni.psa.model.WorkProd;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class JtuDaoImple implements JtuDaoInterface{
	private final SqlSession session;
	
	@Override
	public List<WorkProd> getWprList() {
		System.out.println("JtuDaoImple getWprList Start... ");
		List<WorkProd> wprList=new ArrayList<>();
//		WorkProd wpd1 = new WorkProd();
//		wpd1.setWorkprod_no("WPR20240401101");
//		wpd1.setWorkprod_dt("2024-04-01");
//		wpd1.setSeq_no(0);
//		wpd1.setItem_cd("buldak001");
//		wpd1.setQty(5000);
//		wpd1.setWork_dt(30);
//		wpd1.setProdplan_no("PRP20240301101");
//		wpd1.setWork_cmd("아무튼 조심1");
//		wpd1.setRemark("비고 비었음1");
//		wpd1.setWorkprod_emp_id("psa");
//		wpd1.setWorkprod_update("2024-04-01");
//		wpd1.setWorkprod_delete_chk(1);
//		wpd1.setItem_nm("불닭1호");
//		
//		
//		WorkProd wpd2 = new WorkProd();
//		wpd2.setWorkprod_no("WPR20240402101");
//		wpd2.setWorkprod_dt("2024-04-02");
//		wpd2.setSeq_no(0);
//		wpd2.setItem_cd("buldak002");
//		wpd2.setQty(4000);
//		wpd2.setWork_dt(28);
//		wpd2.setProdplan_no("PRP20240302101");
//		wpd2.setWork_cmd("아무튼 조심2");
//		wpd2.setRemark("비고 비었음2");
//		wpd2.setWorkprod_emp_id("psa");
//		wpd2.setWorkprod_update("2024-04-02");
//		wpd2.setWorkprod_delete_chk(1);
//		wpd2.setItem_nm("불닭2호");
//		
//		WorkProd wpd3 = new WorkProd();
//		wpd3.setWorkprod_no("WPR20240403101");
//		wpd3.setWorkprod_dt("2024-04-03");
//		wpd3.setSeq_no(0);
//		wpd3.setItem_cd("buldak003");
//		wpd3.setQty(3000);
//		wpd3.setWork_dt(28);
//		wpd3.setProdplan_no("PRP20240303101");
//		wpd3.setWork_cmd("아무튼 조심3");
//		wpd3.setRemark("비고 비었음3");
//		wpd3.setWorkprod_emp_id("psa");
//		wpd3.setWorkprod_update("2024-04-03");
//		wpd3.setWorkprod_delete_chk(1);
//		wpd3.setItem_nm("불닭3호");
//		
//		wpdList.add(wpd1);
//		wpdList.add(wpd2);
//		wpdList.add(wpd3);
//		
		try {
			wprList =session.selectList("jtuGetWprList");
		} catch (Exception e) {
			System.out.println("getWprList exception->" + e.getMessage());
		}
		return wprList;
	}

	@Override
	public void setPriOne() {
		System.out.println("JtuDaoImple setPriOne Start... ");
		
		
		try {
			
		} catch (Exception e) {
			System.out.println("setPriOne exception->" + e.getMessage());
		}
	}



}
