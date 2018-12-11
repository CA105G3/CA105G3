package com.reportdr.model;

import java.sql.Date;

public class ReportdrVO {
	
	private String rdrno;
	private String memno;
	private String drno;
	private String rdrreason;
	private Date rdrtime;
	private String rdrstate;
	
	public String getRdrno() {
		return rdrno;
	}
	public void setRdrno(String rdrno) {
		this.rdrno = rdrno;
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
	public String getRdrreason() {
		return rdrreason;
	}
	public void setRdrreason(String rdrreason) {
		this.rdrreason = rdrreason;
	}
	public Date getRdrtime() {
		return rdrtime;
	}
	public void setRdrtime(Date rdrtime) {
		this.rdrtime = rdrtime;
	}
	public String getRdrstate() {
		return rdrstate;
	}
	public void setRdrstate(String rdrstate) {
		this.rdrstate = rdrstate;
	}
	
	

}
