package com.medicalorder.model;

import java.io.Serializable;
import java.sql.Date;
import java.sql.Date;

public class MedicalOrderVO implements Serializable{

	private String moNo;
	private String memNo;
	private String drNo;
	private String moStatus;
	private Integer moCost;
	private Date moTime;
	private Integer moHour;
	private String moIntro;
	private byte[] moVideo;
	private String moText;
	private String moCancelReason;
	
	public String getMoNo() {
		return moNo;
	}
	public void setMoNo(String moNo) {
		this.moNo = moNo;
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
	public String getMoStatus() {
		return moStatus;
	}
	public void setMoStatus(String moStatus) {
		this.moStatus = moStatus;
	}
	public Integer getMoCost() {
		return moCost;
	}
	public void setMoCost(Integer moCost) {
		this.moCost = moCost;
	}
	public Date getMoTime() {
		return moTime;
	}
	public void setMoTime(Date moTime) {
		this.moTime = moTime;
	}
	public Integer getMoHour() {
		return moHour;
	}
	public void setMoHour(Integer moHour) {
		this.moHour = moHour;
	}
	public String getMoIntro() {
		return moIntro;
	}
	public void setMoIntro(String moIntro) {
		this.moIntro = moIntro;
	}
	public byte[] getMoVideo() {
		return moVideo;
	}
	public void setMoVideo(byte[] moVideo) {
		this.moVideo = moVideo;
	}
	public String getMoText() {
		return moText;
	}
	public void setMoText(String moText) {
		this.moText = moText;
	}
	public String getMoCancelReason() {
		return moCancelReason;
	}
	public void setMoCancelReason(String moCancelReason) {
		this.moCancelReason = moCancelReason;
	}
	
}
