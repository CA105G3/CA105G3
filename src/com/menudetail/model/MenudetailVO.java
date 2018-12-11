package com.menudetail.model;

import java.sql.Date;

public class MenudetailVO {
	private String menuListno;
	private String menuNo;
	private Date menudate;
	private String menuTimeSlot;
	
	public String getMenuListno() {
		return menuListno;
	}
	public void setMenuListno(String menuListno) {
		this.menuListno = menuListno;
	}
	public String getMenuNo() {
		return menuNo;
	}
	public void setMenuNo(String menuNo) {
		this.menuNo = menuNo;
	}
	public Date getMenudate() {
		return menudate;
	}
	public void setMenudate(Date menudate) {
		this.menudate = menudate;
	}
	public String getMenuTimeSlot() {
		return menuTimeSlot;
	}
	public void setMenuTimeSlot(String menuTimeSlot) {
		this.menuTimeSlot = menuTimeSlot;
	}
	
	
}
