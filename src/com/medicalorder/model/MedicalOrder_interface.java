package com.medicalorder.model;

import java.util.*;

public interface MedicalOrder_interface {

	public void insert(MedicalOrderVO medicalOrderVO);
	public void update(MedicalOrderVO medicalOrderVO);
	public void delete(MedicalOrderVO medicalOrderVO);
	public MedicalOrderVO findByPrimaryKey(String moNo);
	public List<MedicalOrderVO> getAll();
	
}
