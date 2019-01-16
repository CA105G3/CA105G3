package com.joinact.model;

import java.sql.Date;

public class ChatRoomVO implements java.io.Serializable{
	private String memNo;
	private String actNo;
	private String memName;

	
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
	public String getMemName() {
		return memName;
	}
	public void setMemName(String memName) {
		this.memName = memName;
	}	
}

