package com.ppttool.model;

import java.sql.Blob;

public class PPTToolVO {
	private String pptno;
	private String drno;
	private byte[] ppt;
	public String getPptno() {
		return pptno;
	}
	public void setPptno(String pptno) {
		this.pptno = pptno;
	}
	public String getDrno() {
		return drno;
	}
	public void setDrno(String drno) {
		this.drno = drno;
	}
	public byte[] getPpt() {
		return ppt;
	}
	public void setPpt(byte[] ppt) {
		this.ppt = ppt;
	}
	
}
