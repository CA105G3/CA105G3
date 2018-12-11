package com.orderdetail.model;

public class OrderdetailVO {
    private String odNo;
    private String orderNo;
    private String menulistNo;
    private Integer amount;
    private Integer unitPrice;
    
    
	public String getOdNo() {
		return odNo;
	}
	public void setOdNo(String odNo) {
		this.odNo = odNo;
	}
	public String getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}
	public String getMenulistNo() {
		return menulistNo;
	}
	public void setMenulistNo(String menulistNo) {
		this.menulistNo = menulistNo;
	}
	public Integer getAmount() {
		return amount;
	}
	public void setAmount(Integer amount) {
		this.amount = amount;
	}
	public Integer getUnitPrice() {
		return unitPrice;
	}
	public void setUnitPrice(Integer unitPrice) {
		this.unitPrice = unitPrice;
	}
    
    
}
