package com.administrator.model;

import java.io.Serializable;
import java.sql.Date;

public class AdministratorVO implements Serializable{

	private String adminNo;
	private String adminId;
	private String adminPsw;
	private String adminName;
	private String priority;
	private String status;
	private Date reg;
	
	public String getAdminNo() {
		return adminNo;
	}
	public void setAdminNo(String adminNo) {
		this.adminNo = adminNo;
	}
	public String getAdminId() {
		return adminId;
	}
	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}
	public String getAdminPsw() {
		return adminPsw;
	}
	public void setAdminPsw(String adminPsw) {
		this.adminPsw = adminPsw;
	}
	public String getPriority() {
		return priority;
	}
	public void setPriority(String priority) {
		this.priority = priority;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public Date getReg() {
		return reg;
	}
	public void setReg(Date reg) {
		this.reg = reg;
	}
	public String getAdminName() {
		return adminName;
	}
	public void setAdminName(String adminName) {
		this.adminName = adminName;
	}
	
	
	
}
