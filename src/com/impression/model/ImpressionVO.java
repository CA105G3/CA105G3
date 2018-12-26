package com.impression.model;

import java.sql.Date;

public class ImpressionVO implements java.io.Serializable{
	private String impNo;
	private Date impTime;
	private String impName;
	private String actNo;
	private String memNo;
	private String impCon;
	private byte[] recVideo;
	private byte[] recPic;
	private String impField;
	
	
	public String getImpName() {
		return impName;
	}
	public void setImpName(String impName) {
		this.impName = impName;
	}
	public Date getImpTime() {
		return impTime;
	}
	public void setImpTime(Date impTime) {
		this.impTime = impTime;
	}
	public String getImpNo() {
		return impNo;
	}
	public void setImpNo(String impNo) {
		this.impNo = impNo;
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
	public String getImpCon() {
		return impCon;
	}
	public void setImpCon(String impCon) {
		this.impCon = impCon;
	}
	public byte[] getRecVideo() {
		return recVideo;
	}
	public void setRecVideo(byte[] recVideo) {
		this.recVideo = recVideo;
	}
	public byte[] getRecPic() {
		return recPic;
	}
	public void setRecPic(byte[] recPic) {
		this.recPic = recPic;
	}
	public String getImpField() {
		return impField;
	}
	public void setImpField(String impField) {
		this.impField = impField;
	}
}
