package com.doctoravailable.model;

import java.sql.Date;
import java.util.List;

import com.doctor.model.DoctorDAO_interface;

public class DravailableService {
	private DravailableDAO_interface dao;
	
	public DravailableService() {
		dao = new DravailableDAO();
	}
	
	public DravailableVO addDravailable(String drno, Date draym, String drava) {
		DravailableVO dvo = new DravailableVO();
		dvo.setDrno(drno);
		dvo.setDraym(draym);
		dvo.setDrava(drava);
		
		dao.insert(dvo);
		return dvo;
	}
	
	public DravailableVO updateDravailable(String dravano, String drava) {
		DravailableVO dvo = new DravailableVO();
		dvo.setDravano(dravano);
		dvo.setDrava(drava);
		
		dao.update(dvo);
		
		return dvo;
	}
	
	public void deleteDravailable(String dravano) {
		dao.delete(dravano);
	}
	
	public DravailableVO getOneDravailable(String dravano) {
		return dao.findByPK(dravano);
	}
	
	public List<DravailableVO> getSameDravailable(String drno){
		return dao.findByDrno(drno);
	}
	
	public DravailableVO getDravaInThismonthByDrno(String drno) {
		return dao.findDravaByDrnoThismonth(drno);
	}
	
	public DravailableVO getDravaNextmonthByDrno(String drno) {
		return dao.findDravaByDrnoNextmonth(drno);
	}
	public List<DravailableVO> getAll(){
		return dao.getAll();
	}
	
	
}
