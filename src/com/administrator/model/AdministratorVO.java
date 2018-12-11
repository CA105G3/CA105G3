package com.administrator.model;

import java.io.Serializable;
import java.sql.Date;

public class AdministratorVO implements Serializable{

	private String adminno;
	private String priority;
	private String status;
	private Date reg;
	
	public String getAdminno() {
		return adminno;
	}
	public void setAdminno(String adminno) {
		this.adminno = adminno;
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
	
	
	
}
