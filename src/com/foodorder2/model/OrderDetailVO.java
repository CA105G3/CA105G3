package com.foodorder2.model;


import java.sql.Date;

public class OrderDetailVO {
	private String odno, orderno, menuListno,odStatus;
	private int amount, unitPrice;
	
	public String getOdno() {
		return odno;
	}
	public void setOdno(String odno) {
		this.odno = odno;
	} 
	public String getOrderno() {
		return orderno;
	}
	public void setOrderno(String orderno) {
		this.orderno = orderno;
	}
	public String getMenuListno() {
		return menuListno;
	}
	public void setMenuListno(String menuListno) {
		this.menuListno = menuListno;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	public int getUnitPrice() {
		return unitPrice;
	}
	public void setUnitPrice(int unitPrice) {
		this.unitPrice = unitPrice;
	}
	public String getOdStatus() {
		return odStatus;
	}
	public void setOdStatus(String odStatus) {
		this.odStatus = odStatus;
	}

}
