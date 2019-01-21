package com.doctor.model;

import java.sql.Connection;
import java.util.List;

public interface DoctorDAO_interface {
	public void insert(DoctorVO doctorVO);
	public void update(DoctorVO doctorVO);
	public void delete(String drno);
	public DoctorVO findByPK(String drno);
	public List<DoctorVO> findByMajor(String major);
	public List<DoctorVO> getAll();
	public List<DoctorVO> getMajor();
	public DoctorVO getDrno(String memno);
	public void UpdateIsonline(String isonline,String memno);
	public void UpdateStatus(String status,String memno);
}

