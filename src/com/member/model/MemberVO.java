package com.member.model;

import java.sql.Date;

public class MemberVO {
	private String memNo;
	private String memId;
	private String pwd;
	private String memName;
	private String phone;
	private Date birth;
	private Long regDate;   //這裡是Timestamp
	private Long stayTime;   //這裡是Timestamp
	private String memStatus;
	private String ident;
	private String gender;
	private String email;
	private Integer locNo;
	private String addr;
	private String bloodtype;
	private String smoking;
	private String allergy;
	private String medHistory;
	private String famHistory;
	public String getMemNo() {
		return memNo;
	}
	public void setMemNo(String memNo) {
		this.memNo = memNo;
	}
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getMemName() {
		return memName;
	}
	public void setMemName(String memName) {
		this.memName = memName;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public Date getBirth() {
		return birth;
	}
	public void setBirth(Date birth) {
		this.birth = birth;
	}
	public Long getRegDate() {
		return regDate;
	}
	public void setRegDate(Long regDate) {
		this.regDate = regDate;
	}
	public Long getStayTime() {
		return stayTime;
	}
	public void setStayTime(Long stayTime) {
		this.stayTime = stayTime;
	}
	public String getMemStatus() {
		return memStatus;
	}
	public void setMemStatus(String memStatus) {
		this.memStatus = memStatus;
	}
	public String getIdent() {
		return ident;
	}
	public void setIdent(String ident) {
		this.ident = ident;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public Integer getLocNo() {
		return locNo;
	}
	public void setLocNo(Integer locNo) {
		this.locNo = locNo;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public String getBloodtype() {
		return bloodtype;
	}
	public void setBloodtype(String bloodtype) {
		this.bloodtype = bloodtype;
	}
	public String getSmoking() {
		return smoking;
	}
	public void setSmoking(String smoking) {
		this.smoking = smoking;
	}
	public String getAllergy() {
		return allergy;
	}
	public void setAllergy(String allergy) {
		this.allergy = allergy;
	}
	public String getMedHistory() {
		return medHistory;
	}
	public void setMedHistory(String medHistory) {
		this.medHistory = medHistory;
	}
	public String getFamHistory() {
		return famHistory;
	}
	public void setFamHistory(String famHistory) {
		this.famHistory = famHistory;
	}
	
	
	
	
}
