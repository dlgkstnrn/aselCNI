package com.aselcni.ujm.dao;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.aselcni.ujm.model.UjmOutitem;
import com.aselcni.ujm.model.UjmOutitemItem;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class UjmOutitemDaoImpl implements UjmOutitemDao {

	private final SqlSession session;
	
	@Override
	public int ujmTotalOutitemCnt(UjmOutitem outitem) {
		int ujmTotalOutitemCnt=0;
		System.out.println("ujmOutitemDaoImpl에서 ujmTotalOutitemCnt (객체)");
		try {
			ujmTotalOutitemCnt=session.selectOne("ujmTotalOutitemCnt", outitem);
			System.out.println("ujmOutitemDaoImpl에서 ujmTotalOutitemCnt한 값(객체):"+ujmTotalOutitemCnt);
		} catch (Exception e) {
			System.out.println("ujmOutitemDaoImpl에서 ujmTotalOutitemCnt 도중 실패:"+e.getMessage());
		}
		
		return ujmTotalOutitemCnt;
	}

	@Override
	public List<UjmOutitem> ujmListOutiem(UjmOutitem outitem) {
		List<UjmOutitem> ujmListOutitems = null;
		System.out.println("UjmOutitemDaoImpl ujmListOutiem 시작 ..." );
		System.out.println("UjmOutitemDaoImpl ujmListOutiem : try 넣기 전 outitem:"+outitem);
		try {
			//
			ujmListOutitems = session.selectList("ujmListOutitemAll", outitem);
			if(ujmListOutitems!=null) {
				System.out.println("UjmOutitemDaoImpl ujmListOutitems ujmListOutitems.size()->"+ujmListOutitems.size());
				}
		} catch (Exception e) {
			System.out.println("UjmOutitemDaoImpl ujmListOutitems 오류:"+e.getMessage());
		}
		return ujmListOutitems;
	}

	@Override
	public String ujmSetOutitemNo(String outitem_no) {
		System.out.println("UjmOutitemDaoImpl ujmSetOutitemNo 시작 ...");
		System.out.println(outitem_no); //사용자가 출고날짜로 달력으로 입력한, 2024-04-01같은 날짜 형태
		
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Date date=sdf.parse(outitem_no);
			
			SimpleDateFormat sdf2 = new SimpleDateFormat("yyMMdd");
			String changedOutitem_no = "OUT" + sdf2.format(date); // OUT240401
			System.out.println("changedOutitem_no:"+changedOutitem_no);
			
			int outitemNoCnt=session.selectOne("outitemNoCnt", changedOutitem_no); 
			//OUT240401로 시작하는(포함하는) 출고번호의 개수를 셈 (삭제여부와 무관)
			System.out.println("outitemNoCnt:"+outitemNoCnt);
			
			int outitemNoPlusCnt=outitemNoCnt+1; //0이면(없으면) 1로, 1이면 2로....
			
			String outitemNoStr = String.valueOf(outitemNoPlusCnt); 
	        int outitemNoStrLength = outitemNoStr.length(); //자릿수
	        
	        if (outitemNoStrLength == 1) { //한자리
	        	outitemNoStr=changedOutitem_no +"000" + outitemNoPlusCnt; //OUT2404010001
	        } else if (outitemNoStrLength == 2) {
	        	outitemNoStr= changedOutitem_no +"00" + outitemNoPlusCnt; //OUT2404010012
	        } else if (outitemNoStrLength == 3) {
	        	outitemNoStr= changedOutitem_no+ "0" + outitemNoPlusCnt; //OUT2404010123
	        } 
	          else {outitemNoStr= changedOutitem_no + String.valueOf(outitemNoPlusCnt); //OUT2404011234
	        }
	        System.out.println("outitemNoStr:"+outitemNoStr);
			return outitemNoStr;
		} catch (Exception e) {
			System.out.println("UjmOutitemDaoImpl ujmSetOutitemNo 오류:"+e.getMessage());
			return null;
		}
	}

	@Override
	public int ujmGetSeqNo(String order_no) {
		System.out.println("UjmOutitemDaoImpl ujmGetSeqNo 시작 ...");
		System.out.println(order_no); 
		
		//출고메인에서 하나의 주문번호에 걸려있는 출고번호의 개수를 순번(seq_no)으로 정의, 하나의 출고번호는 여러개의 품목 가질 수 있음
		//순번 매기기 위함이므로 삭제여부와는 무관
		try {
			int outitemNoCnt=session.selectOne("ujmGetSeqNo", order_no);
			//이미 있는 개수+1
			return outitemNoCnt+1;
		} catch (Exception e) {
			System.out.println("UjmOutitemDaoImpl ujmGetSeqNo 오류:"+e.getMessage());
			return -1;
		}
		
	}

	@Override
	public int ujmInsertOutitem(UjmOutitem outitem) {
		System.out.println("UjmOutitemDaoImpl ujmInsertOutitem 시작 ...");
		System.out.println(outitem);
		try {
			int insertOutitemResult=session.insert("ujmInsertOutitem",outitem);
			return insertOutitemResult;
		} catch (Exception e) {
			System.out.println("UjmOutitemDaoImpl ujmInsertOutitem 오류:"+e.getMessage());
			return -1;
		}
	}

	@Override
	public void ujmInsertOutitemItem(UjmOutitemItem item) {
		System.out.println("UjmOutitemDaoImpl insertOutitemItem 시작 ...");
		System.out.println(item);
		try {
			session.insert("ujmInsertOutitemItem",item);
		} catch (Exception e) {
			System.out.println("UjmOutitemDaoImpl ujmInsertOutitemItem 오류:"+e.getMessage());
		}
		
	}

	@Override
	public int ujmOutitemItemCnt(UjmOutitem outitemData) {
		System.out.println("UjmOutitemDaoImpl ujmOutitemItemCnt 시작 ...");
		System.out.println(outitemData);
		try { //출고등록시 출고품목에 추가되는 (출고번호와 주문번호를 토대로) 품목의 개수를 구하는 것이므로, 삭제여부 고려 x 
			int ujmOutitemItemCnt=session.selectOne("ujmOutitemItemCnt",outitemData);
			return ujmOutitemItemCnt;
		} catch (Exception e) {
			System.out.println("UjmOutitemDaoImpl ujmOutitemItemCnt 오류:"+e.getMessage());
			return -1;
		}
	}

	@Override
	public List<UjmOutitem> ujmGetOutitemDetail(String outitem_no, String order_no) {
		System.out.println("UjmOutitemDaoImpl ujmGetOutitemDetail 시작 ..." );
		List<UjmOutitem> ujmListOutitemDetail = null;
		System.out.println(outitem_no);
		System.out.println(order_no);
		UjmOutitem outitem=new UjmOutitem();
		outitem.setOutitem_no(outitem_no);
		outitem.setOrder_no(order_no);
		System.out.println(outitem);
		try {
			ujmListOutitemDetail=session.selectList("ujmGetOutitemDetail",outitem);
			if (ujmListOutitemDetail!=null) {
				System.out.println("UjmOutitemDaoImpl ujmGetOutitemDetail.size():"+ujmListOutitemDetail.size());
				System.out.println(ujmListOutitemDetail);
			}
		} catch (Exception e) {
			System.out.println("UjmOutitemDaoImpl ujmGetOutitemDetail 오류: "+e.getMessage());
		}
		return ujmListOutitemDetail;
	}

	@Override
	public List<UjmOutitem> ujmGetOutitemToUpdate(String order_no, String outitem_no) {
		System.out.println("UjmOutitemDaoImpl ujmGetOutitemToUpdate 시작 ..." );

		UjmOutitem ujmOutitem = new UjmOutitem();
		ujmOutitem.setOrder_no(order_no);
		ujmOutitem.setOutitem_no(outitem_no);
		System.out.println("ujmOutitem:"+ujmOutitem);
		
		List<UjmOutitem> ujmListOutitem = null;
		try {
			ujmListOutitem=session.selectList("ujmGetOutitemToUpdate",ujmOutitem);
			if (ujmListOutitem!=null) {
				System.out.println("UjmOutitemDaoImpl ujmListOutitem.size():"+ujmListOutitem.size());
			}
		} catch (Exception e) {
			System.out.println("UjmOutitemDaoImpl ujmGetOutitemToUpdate 오류: "+e.getMessage());
		}
		return ujmListOutitem;
	}

	@Override
	public int ujmUpdateOutitem(UjmOutitem outitem) {
		System.out.println("UjmOutitemDaoImpl ujmUpdateOutitem 시작 ...");
		System.out.println(outitem);
		try {
			int updateOutitemResult=session.update("ujmUpdateOutitem",outitem);
			return updateOutitemResult;
		} catch (Exception e) {
			System.out.println("UjmOutitemDaoImpl ujmUpdateOutitem 오류:"+e.getMessage());
			return -1;
		}
	}

	@Override
	public int ujmitemNotNullCheck(UjmOutitemItem item) {
		System.out.println("UjmOutitemDaoImpl ujmitemNotNullCheck 시작 ...");
		System.out.println(item); 
		int cnt=0;
		
		try {
			cnt=session.selectOne("ujmitemNotNullCheck", item); //있으면 1 없으면 0이 나와야 함
		} catch (Exception e) {
			System.out.println("UjmOutitemDaoImpl ujmitemNotNullCheck 오류:"+e.getMessage());
		} 			
		return cnt;
	}

	@Override
	public int ujmUpdateOutitemItem(UjmOutitemItem item) {
		System.out.println("UjmOutitemDaoImpl ujmUpdateOutitemItem 시작 ...");
		System.out.println(item);
		try {
			int updateOutitemItemResult=session.update("ujmUpdateOutitemItem",item);
			return updateOutitemItemResult;
		} catch (Exception e) {
			System.out.println("UjmOutitemDaoImpl updateOutitemItemResult 오류:"+e.getMessage());
			return -1;
		}
	}

	@Override
	public int ujmDeleteOutitemItem(UjmOutitemItem item) {
		System.out.println("UjmOutitemDaoImpl ujmDeleteOutitemItem 시작 ...");
		System.out.println(item);
		try {
			int deleteOutitemItemResult=session.delete("ujmDeleteOutItemItem",item);
			return deleteOutitemItemResult;
		} catch (Exception e) {
			System.out.println("UjmOutitemDaoImpl ujmDeleteOutitemItem 오류:"+e.getMessage());
			return -1;
		}
	}

	@Override
	public String ujmFindOutitemRemark(String outitem_no) {
		System.out.println("UjmOutitemDaoImpl ujmFindOutitemRemark 시작 ...");
		System.out.println(outitem_no);
		String outitemRemark=null;
		try {
			outitemRemark=session.selectOne("ujmFindOutitemRemark",outitem_no);
			System.out.println("outitemRemark:"+outitemRemark);
			return outitemRemark;
		} catch (Exception e) {
			System.out.println("UjmOutitemDaoImpl ujmFindOutitemRemark 오류:"+e.getMessage());
			return "";
		}
	}

	@Override
	public int ujmDeleteOutitem(String outitem_no) {
		System.out.println("UjmOutitemDaoImpl ujmDeleteOutitem 시작 ...");
		System.out.println(outitem_no);
		try {
			int deleteOutitem=session.update("ujmDeleteOutitem",outitem_no);
			return deleteOutitem;
		} catch (Exception e) {
			System.out.println("UjmOutitemDaoImpl ujmDeleteOutitem 오류:"+e.getMessage());
			return -1;
		}
	}

		
}

	

