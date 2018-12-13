package com.member.model;

import java.sql.Date;
import java.sql.Timestamp;

public class MemberVO implements java.io.Serializable{
	private String addr;
	private String allergy;
	private Date birth;
	private String bloodType;
	private String email;
	private String famHistory;
	private String gender;
	private String ident;
	private Integer locNo;
	private String medHistory;
	private String memId;
	private String memName;
	private String memNo;
	private String memStatus;
	private String phone;
	private String pwd;
	private Date regDate;
	private String smoking;
	private Timestamp stayTime;
	
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public String getAllergy() {
		return allergy;
	}
	public void setAllergy(String allergy) {
		this.allergy = allergy;
	}
	public Date getBirth() {
		return birth;
	}
	public void setBirth(Date birth) {
		this.birth = birth;
	}
	public String getBloodType() {
		return bloodType;
	}
	public void setBloodType(String bloodType) {
		this.bloodType = bloodType;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getFamHistory() {
		return famHistory;
	}
	public void setFamHistory(String famHistory) {
		this.famHistory = famHistory;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getIdent() {
		return ident;
	}
	public void setIdent(String ident) {
		this.ident = ident;
	}
	public Integer getLocNo() {
		return locNo;
	}
	public void setLocNo(Integer locNo) {
		this.locNo = locNo;
	}
	public String getMedHistory() {
		return medHistory;
	}
	public void setMedHistory(String medHistory) {
		this.medHistory = medHistory;
	}
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
	public String getMemName() {
		return memName;
	}
	public void setMemName(String memName) {
		this.memName = memName;
	}
	public String getMemNo() {
		return memNo;
	}
	public void setMemNo(String memNo) {
		this.memNo = memNo;
	}
	public String getMemStatus() {
		return memStatus;
	}
	public void setMemStatus(String memStatus) {
		this.memStatus = memStatus;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	public String getSmoking() {
		return smoking;
	}
	public void setSmoking(String smoking) {
		this.smoking = smoking;
	}
	public Timestamp getStayTime() {
		return stayTime;
	}
	public void setStayTime(Timestamp stayTime) {
		this.stayTime = stayTime;
	}
	
}
