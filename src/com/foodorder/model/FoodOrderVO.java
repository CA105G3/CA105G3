package com.foodorder.model;

import java.sql.Date;
import java.sql.Timestamp;

public class FoodOrderVO {
	private String orderno, memno, deliverAddr, chefno, orderStatus;
	private Timestamp ordTime;
	public String getOrderno() {
		return orderno;
	}
	public void setOrderno(String orderno) {
		this.orderno = orderno;
	}
	public String getMemno() {
		return memno;
	}
	public void setMemno(String memno) {
		this.memno = memno;
	}
	public String getDeliverAddr() {
		return deliverAddr;
	}
	public void setDeliverAddr(String deliverAddr) {
		this.deliverAddr = deliverAddr;
	}
	public String getChefno() {
		return chefno;
	}
	public void setChefno(String chefno) {
		this.chefno = chefno;
	}
	public String getOrderStatus() {
		return orderStatus;
	}
	public void setOrderStatus(String orderStatus) {
		this.orderStatus = orderStatus;
	}
	public Timestamp getOrdTime() {
		return ordTime;
	}
	public void setOrdTime(Timestamp ordTime) {
		this.ordTime = ordTime;
	}

}