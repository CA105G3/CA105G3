package com.reportdr.model;

import java.sql.Date;
import java.util.List;

public class ReportDrVO {
	
	private String rdrNo;
	private String memNo;
	private String drNo;
	private String rdrReason;
	private Date rdrTime;
	private String rdrState;
	
	public String getRdrNo() {
		return rdrNo;
	}
	public void setRdrNo(String rdrNo) {
		this.rdrNo = rdrNo;
	}
	public String getMemNo() {
		return memNo;
	}
	public void setMemNo(String memNo) {
		this.memNo = memNo;
	}
	public String getDrNo() {
		return drNo;
	}
	public void setDrNo(String drNo) {
		this.drNo = drNo;
	}
	public String getRdrReason() {
		return rdrReason;
	}
	public void setRdrReason(String rdrReason) {
		this.rdrReason = rdrReason;
	}
	public Date getRdrTime() {
		return rdrTime;
	}
	public void setRdrTime(Date rdrTime) {
		this.rdrTime = rdrTime;
	}
	public String getRdrState() {
		return rdrState;
	}
	public void setRdrState(String rdrState) {
		this.rdrState = rdrState;
	}
	
	
	

}
