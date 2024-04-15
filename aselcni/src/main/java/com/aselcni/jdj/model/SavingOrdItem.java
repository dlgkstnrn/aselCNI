package com.aselcni.jdj.model;


import lombok.Data;

@Data
public class SavingOrdItem {
    private String item_nm;
    private String item_unit;
    private int order_qty;
    private int item_cost;
    private int order_item_cost;

}
