package com.member.model;

import java.sql.Date;
import java.sql.Timestamp;

public class MemberVO implements java.io.Serializable{
	private String addr;
	private String allergy;
	private Date birth;
	private String bloodtype;
	private String email;
	private String famhistory;
	private String gender;
	private String ident;
	private Integer locno;
	private String medhistory;
	private String memid;
	private String memname;
	private String memno;
	private String memstatus;
	private String phone;
	private String pwd;
	private Date regdate;
	private String smoking;
	private Timestamp staytime;
	
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
	public String getBloodtype() {
		return bloodtype;
	}
	public void setBloodtype(String bloodtype) {
		this.bloodtype = bloodtype;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getFamhistory() {
		return famhistory;
	}
	public void setFamhistory(String famhistory) {
		this.famhistory = famhistory;
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
	public Integer getLocno() {
		return locno;
	}
	public void setLocno(Integer locno) {
		this.locno = locno;
	}
	public String getMedhistory() {
		return medhistory;
	}
	public void setMedhistory(String medhistory) {
		this.medhistory = medhistory;
	}
	public String getMemid() {
		return memid;
	}
	public void setMemid(String memid) {
		this.memid = memid;
	}
	public String getMemname() {
		return memname;
	}
	public void setMemname(String memname) {
		this.memname = memname;
	}
	public String getMemno() {
		return memno;
	}
	public void setMemno(String memno) {
		this.memno = memno;
	}
	public String getMemstatus() {
		return memstatus;
	}
	public void setMemstatus(String memstatus) {
		this.memstatus = memstatus;
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
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	public String getSmoking() {
		return smoking;
	}
	public void setSmoking(String smoking) {
		this.smoking = smoking;
	}
	public Timestamp getStaytime() {
		return staytime;
	}
	public void setStaytime(Timestamp staytime) {
		this.staytime = staytime;
	}
	
}
