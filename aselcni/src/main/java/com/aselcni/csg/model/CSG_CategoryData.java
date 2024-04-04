package com.aselcni.csg.model;

import java.util.List;

import lombok.Data;

@Data
public class CSG_CategoryData {

    private List<CSG_TB_TYPE_BIG> bigTypes;

    private List<CSG_TB_TYPE_MID> midTypes;
	
    private List<CSG_TB_TYPE_SML> smallTypes;

}
