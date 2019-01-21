package com.menulist.model2;

import com.menu.model.MenuVO;

public class MenuListVO implements java.io.Serializable{
	private static final long serialVersionUID = 1L;
	
	private String menuListNo;
	private String odno;
	private String orderno;
	private String chefRep;
	private String mainCourse;
	private int amount;
	private int unitPrice;
	private String chefNo;
	private String menuNo;
	private java.sql.Date menuDate;
	private String menuTimeSlot;
	private String chefName;
	private String deliverAddr;
	
	
	public String getChefName() {
		return chefName;
	}
	public void setChefName(String chefName) {
		this.chefName = chefName;
	}
	public String getOdno() {
		return odno;
	}
	public void setOdno(String odno) {
		this.odno = odno;
	}
	public String getChefRep() {
		return chefRep;
	}
	public void setChefRep(String chefRep) {
		this.chefRep = chefRep;
	}
	
	
	public String getOrderno() {
		return orderno;
	}
	public void setOrderno(String orderno) {
		this.orderno = orderno;
	}
	public String getMainCourse() {
		return mainCourse;
	}
	public void setMainCourse(String mainCourse) {
		this.mainCourse = mainCourse;
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
	
	
	public String getDeliverAddr() {
		return deliverAddr;
	}
	public void setDeliverAddr(String deliverAddr) {
		this.deliverAddr = deliverAddr;
	}
	public String getChefNo() {
		return chefNo;
	}
	public void setChefNo(String chefNo) {
		this.chefNo = chefNo;
	}
		
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
