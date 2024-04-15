package com.aselcni.kdw.model;

import java.util.List;

import lombok.Data;

@Data
public class ProdPlanData {

    private String orderNo; // 주문정보
    private int workDays;   // 작업일수
    private String startDate; // 생산시작예정일
    private String endDate;// 생산종료예정일
    private int productQty; // 제품생산수량
    private ProductInfo product; // 제품정보
    private List<MaterialInfo> materials; //자재정보
    private String remark; // 비고 
    
    // 제품정보
    public static class ProductInfo {
        private String code; // 제품코드
        private String name; // 제품이름
        
		public String getCode() {
			return code;
		}
		public void setCode(String code) {
			this.code = code;
		}
		public String getName() {
			return name;
		}
		public void setName(String name) {
			this.name = name;
		}
    }
    // 자재정보
    public static class MaterialInfo {
        private String code;
        private int quantity;
        private String name;
        
		public String getCode() {
			return code;
		}
		public void setCode(String code) {
			this.code = code;
		}
		public int getQuantity() {
			return quantity;
		}
		public void setQuantity(int quantity) {
			this.quantity = quantity;
		}
		public String getName() {
			return name;
		}
		public void setName(String name) {
			this.name = name;
		}
    }

	
}