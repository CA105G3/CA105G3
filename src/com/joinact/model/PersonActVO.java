package com.joinact.model;

import java.sql.Date;

public class PersonActVO implements java.io.Serializable{
	private String memNo;
	private String actNo;
	private String actName;
	private String actLoc;
	private Date actTime;
	private byte[] actPic;
	private String actDesc;
	
	public String getMemNo() {
		return memNo;
	}
	public void setMemNo(String memNo) {
		this.memNo = memNo;
	}
	public String getActNo() {
		return actNo;
	}
	public void setActNo(String actNo) {
		this.actNo = actNo;
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
	public byte[] getActPic() {
		return actPic;
	}
	public void setActPic(byte[] actPic) {
		this.actPic = actPic;
	}
	public String getActDesc() {
		return actDesc;
	}
	public void setActDesc(String actDesc) {
		this.actDesc = actDesc;
	}
	
}
