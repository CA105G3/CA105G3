package com.ppttool.model;

import java.util.List;

import com.doctor.model.DoctorVO;

public interface PPTToolDAO_interface {
	public void insert(PPTToolVO ppttoolvo);
	public void update(PPTToolVO ppttoolvo);
	public void delete(String pptno);
	public PPTToolVO findByPK(String Pptno);   
	public List<PPTToolVO> getAll();
	  
}
