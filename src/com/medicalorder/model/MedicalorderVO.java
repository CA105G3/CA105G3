package com.medicalorder.model;

import java.io.Serializable;
import java.sql.Date;

public class MedicalorderVO implements Serializable{

	private String mono;
	private String memno;
	private String drno;
	private String mostatus;
	private Integer mocost;
	private Date motime;
	private String motext;
	private byte[] movideo;
	private String mointro;
	public String getMono() {
		return mono;
	}
	public void setMono(String mono) {
		this.mono = mono;
	}
	public String getMemno() {
		return memno;
	}
	public void setMemno(String memno) {
		this.memno = memno;
	}
	public String getDrno() {
		return drno;
	}
	public void setDrno(String drno) {
		this.drno = drno;
	}
	public String getMostatus() {
		return mostatus;
	}
	public void setMostatus(String mostatus) {
		this.mostatus = mostatus;
	}
	public Integer getMocost() {
		return mocost;
	}
	public void setMocost(Integer mocost) {
		this.mocost = mocost;
	}
	public Date getMotime() {
		return motime;
	}
	public void setMotime(Date motime) {
		this.motime = motime;
	}
	public String getMotext() {
		return motext;
	}
	public void setMotext(String motext) {
		this.motext = motext;
	}
	public byte[] getMovideo() {
		return movideo;
	}
	public void setMovideo(byte[] movideo) {
		this.movideo = movideo;
	}
	public String getMointro() {
		return mointro;
	}
	public void setMointro(String mointro) {
		this.mointro = mointro;
	}
	
}
