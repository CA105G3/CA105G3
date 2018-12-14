package com.reportact.model;

public class ReportactVO implements java.io.Serializable{
	private String repaNo;
	private String actNo;
	private String memNo;
	private String repaStatus;
	
	
	public String getRepaNo() {
		return repaNo;
	}
	public void setRepaNo(String repaNo) {
		this.repaNo = repaNo;
	}
	public String getActNo() {
		return actNo;
	}
	public void setActNo(String actNo) {
		this.actNo = actNo;
	}
	public String getMemNo() {
		return memNo;
	}
	public void setMemNo(String memNo) {
		this.memNo = memNo;
	}
	public String getRepaStatus() {
		return repaStatus;
	}
	public void setRepaStatus(String repaStatus) {
		this.repaStatus = repaStatus;
	}
}
