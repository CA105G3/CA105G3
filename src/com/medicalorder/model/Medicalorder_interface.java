package com.medicalorder.model;

import java.util.*;

public interface Medicalorder_interface {

	public void insert(MedicalorderVO medicalorderVO);
	public void update(MedicalorderVO medicalorderVO);
	public void delete(MedicalorderVO medicalorderVO);
	public MedicalorderVO findByPrimaryKey(String mono);
	public List<MedicalorderVO> getAll();
	
}
