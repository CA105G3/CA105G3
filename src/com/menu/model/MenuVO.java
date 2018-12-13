package com.menu.model;

public class MenuVO {
	private String menuBo;
	private String chefNo;
	private Integer unitPrice;
	private String mainCourse;
	private byte[] menuPic;
	private String deliverTime;
	
	  
	public String getMenuBo() {
		return menuBo;
	}
	public void setMenuBo(String menuBo) {
		this.menuBo = menuBo;
	}
	public String getChefNo() {
		return chefNo;
	}
	public void setChefNo(String chefNo) {
		this.chefNo = chefNo;
	}
	public Integer getUnitPrice() {
		return unitPrice;
	}
	public void setUnitPrice(Integer unitPrice) {
		this.unitPrice = unitPrice;
	}
	public String getMainCourse() {
		return mainCourse;
	}
	public void setMainCourse(String mainCourse) {
		this.mainCourse = mainCourse;
	}
	public byte[] getMenuPic() {
		return menuPic;
	}
	public void setMenuPic(byte[] menuPic) {
		this.menuPic = menuPic;
	}
	public String getDeliverTime() {
		return deliverTime;
	}
	public void setDeliverTime(String deliverTime) {
		this.deliverTime = deliverTime;
	}
	
	
}
