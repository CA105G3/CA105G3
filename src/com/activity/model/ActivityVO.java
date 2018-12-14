package com.activity.model;

import java.sql.Date;

public class ActivityVO implements java.io.Serializable{
	private String actNo;
	private String memNo;
	private String actName;
	private String actLoc;
	private Date actTime;
	private String actStatus;
	private Integer actLimit;
	private Integer timeCheck;
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
	public String getActName() {
		return actName;
	}
	public void setActName(String actName) {
		this.actName = actName;
	}
	public String getActLoc() {
		return actLoc;
	}
	public void setActLoc(String actLoc) {
		this.actLoc = actLoc;
	}
	public Date getActTime() {
		return actTime;
	}
	public void setActTime(Date actTime) {
		this.actTime = actTime;
	}
	public String getActStatus() {
		return actStatus;
	}
	public void setActStatus(String actStatus) {
		this.actStatus = actStatus;
	}
	public Integer getActLimit() {
		return actLimit;
	}
	public void setActLimit(Integer actLimit) {
		this.actLimit = actLimit;
	}
	public Integer getTimeCheck() {
		return timeCheck;
	}
	public void setTimeCheck(Integer timeCheck) {
		this.timeCheck = timeCheck;
	}
	
	
	
}
