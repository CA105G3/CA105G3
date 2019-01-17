package com.foodorder2.model;

public class MenuListVO implements java.io.Serializable{
	private static final long serialVersionUID = 1L;
	
	private String menuListNo;
	private String menuNo;
	private java.sql.Date menuDate;
	private String menuTimeSlot;
	
	public String getMenuListNo() {
		return menuListNo;
	}
	public void setMenuListNo(String menuListNo) {
		this.menuListNo = menuListNo;
	} 
	public String getMenuNo() {
		return menuNo;
	}
	public void setMenuNo(String menuNo) {
		this.menuNo = menuNo;
	}
	public java.sql.Date getMenuDate() {
		return menuDate;
	}
	public void setMenuDate(java.sql.Date menuDate) {
		this.menuDate = menuDate;
	}
	public String getMenuTimeSlot() {
		return menuTimeSlot;
	}
	public void setMenuTimeSlot(String menuTimeSlot) {
		this.menuTimeSlot = menuTimeSlot;
	}
}
