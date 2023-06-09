package com.dev.pms.stock;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class HotelStockVO {
    private Long inventoryId;
    private Long itemId;
    private Long currentStock;
    private Long autoOrderQuantity;
    private String orderStatus;
    private String roomUsageStatus;
    private String productName;
    private String itemCode;
    private String companyName;
    private Long unitPrice;


    private PartnerStockVO partnerStockVO;
}