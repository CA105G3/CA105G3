package com.menu.model;

public class MenuVO implements java.io.Serializable{
	private static final long serialVersionUID = 1L;
	
	private String menuNo;
	private String chefNo;
	private int unitPrice;
	private String mainCourse;
	private byte[] menuPic;
	private String deliverable;
	private String menuIntro;
	
	public String getMenuNo() {
		return menuNo;
	}
	public void setMenuNo(String menuNo) {
		this.menuNo = menuNo;
	}
	public String getChefNo() {
		return chefNo;
	}
	public void setChefNo(String chefNo) {
		this.chefNo = chefNo;
	}
	public int getUnitPrice() {
		return unitPrice;
	}
	public void setUnitPrice(int unitPrice) {
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
	public String getDeliverable() {
		return deliverable;
	}
	public void setDeliverable(String deliverable) {
		this.deliverable = deliverable;
	}
	public String getMenuIntro() {
		return menuIntro;
	}
	public void setMenuIntro(String menuIntro) {
		this.menuIntro = menuIntro;
	}
}
