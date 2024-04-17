package com.aselcni.kdw.model;

import java.util.List;

import lombok.Data;

@Data
public class ProdPlanDataUpdate {
	private ProdPlanData prodPlanData;
	private List<Material> newMaterials;
	private List<MaterialToDelete> materialsToDelete;

	// 생산계획
	@Data
	public static class ProdPlanData {
		private  String prodPlanNo;
		private  String orderNo;
		private     int workDays;
		private  String startDate;
		private  String endDate;
		private     int productQty;
		private  String remark;
		private Product product;
	}

	// 제품
	@Data
	public static class Product {
		private String code;
		private String name;
	}

	// 자재
	@Data
	public static class Material {
		private String code;
		private String name;
		private    int quantity;
	}

	// 삭제를 위한 자재
	@Data
	public static class MaterialToDelete {
		private String code;
		private String name;
	}

}