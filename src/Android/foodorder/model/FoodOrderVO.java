package Android.foodorder.model;

import java.io.Serializable;
import java.sql.Date;

public class FoodOrderVO implements Serializable {
	private static final long serialVersionUID = 1L;
	private String orderno, memno, deliverAddr, chefno, orderStatus;
	private Date ordTime;
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
	public Date getOrdTime() {
		return ordTime;
	}
	public void setOrdTime(Date ordTime) {
		this.ordTime = ordTime;
	}
	

}