package com.medicalorder.model;

import java.util.*;

public interface MedicalOrder_interface {

	public void insert(MedicalOrderVO medicalOrderVO);
	public void update(MedicalOrderVO medicalOrderVO);
	public void delete(String moNo);
	public MedicalOrderVO findByPrimaryKey(String memNo);
	public List<MedicalOrderVO> getAll();
	
}
