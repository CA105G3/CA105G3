package com.license.model;

import java.sql.Date;

public class LicenseVO {
	private String licNo;
	private String memNo;
	private byte[] licDate;
	private String licStatus;
	private String licDesc;
	private Date licDue;
	
	
	public String getLicNo() {
		return licNo;
	}
	public void setLicNo(String licNo) {
		this.licNo = licNo;
	}
	public String getMemNo() {
		return memNo;
	}
	public void setMemNo(String memNo) {
		this.memNo = memNo;
	}
	public byte[] getLicDate() {
		return licDate;
	}
	public void setLicDate(byte[] licDate) {
		this.licDate = licDate;
	}
	public String getLicStatus() {
		return licStatus;
	}
	public void setLicStatus(String licStatus) {
		this.licStatus = licStatus;
	}
	public String getLicDesc() {
		return licDesc;
	}
	public void setLicDesc(String licDesc) {
		this.licDesc = licDesc;
	}
	public Date getLicDue() {
		return licDue;
	}
	public void setLicDue(Date licDue) {
		this.licDue = licDue;
	}
}
