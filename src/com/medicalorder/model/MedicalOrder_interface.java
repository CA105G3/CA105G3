package com.medicalorder.model;

import java.util.*;

public interface MedicalOrder_interface {

	public void insert(MedicalOrderVO medicalOrderVO);
	public void update(MedicalOrderVO medicalOrderVO);
	public void delete(String moNo);
	public MedicalOrderVO findByPrimaryKey(String moNo);
	public List<MedicalOrderVO> getAll();
	public List<MedicalOrderVO> findListforMember(String memNo);
	public void cancelMedicalOrder(MedicalOrderVO medicalOrderVO);
//	====================================================
	public List<MedicalOrderVO> getByDrno(String drno);
	public List<MedicalOrderVO> getByDrnoToday(String drno);
	public List<MedicalOrderVO> getByDrnoThisMonth(String drno);
	public List<MedicalOrderVO> getByDrnoNextMonth(String drno);
	public List<MedicalOrderVO> getByDrnoThisWeek(String drno);
	public void calcelByDr(MedicalOrderVO medicalOrderVO);
	public List<MedicalOrderVO> getByDrnoThisMonthDone(String drno);
	public void updatemotext(String mono,String motext);
}
