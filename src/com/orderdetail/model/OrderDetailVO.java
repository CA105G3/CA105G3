package com.orderdetail.model;


import java.sql.Date;

public class OrderDetailVO {
	private String odno, orderno, menuListno;
	private int amount, unitPrice;
	
	private String menuTimeSlot, mainCourse;
	private Date menuDate;
	
	
	public String getMenuTimeSlot() {
		return menuTimeSlot;
	}
	public void setMenuTimeSlot(String menuTimeSlot) {
		this.menuTimeSlot = menuTimeSlot;
	}
	public String getMainCourse() {
		return mainCourse;
	}
	public void setMainCourse(String mainCourse) {
		this.mainCourse = mainCourse;
	}
	public Date getMenuDate() {
		return menuDate;
	}
	public void setMenuDate(Date menuDate) {
		this.menuDate = menuDate;
	}
	
	
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

}
