package com.doctor.model;

import java.sql.Connection;
import java.util.List;

public class DoctorService {
	private DoctorDAO_interface dao;
	
	public DoctorService(){
		dao = new DoctorDAO();
	}
	
	public DoctorVO addDoctor(String memno, String resume,String isonline, String status, 
			String major, Integer fee, byte[] photo) {
		DoctorVO dvo = new DoctorVO();
		dvo.setMemno(memno);
		dvo.setResume(resume);
		dvo.setIsonline(isonline);
		dvo.setStatus(status);
		dvo.setMajor(major);
		dvo.setFee(fee);
		dvo.setPhoto(photo);
		
		dao.insert(dvo);
		return dvo;
	}
	
	public DoctorVO updateDoctor(String drno, String memno, String resume,String isonline, String status, 
			String major, Integer fee, byte[] photo) {
		DoctorVO dvo = new DoctorVO();
		dvo.setDrno(drno);
		dvo.setMemno(memno);
		dvo.setResume(resume);
		dvo.setIsonline(isonline);
		dvo.setStatus(status);
		dvo.setMajor(major);
		dvo.setFee(fee);
		dvo.setPhoto(photo);
		
		dao.update(dvo);
		return dvo;
	}	
	
	public void deleteDoctor(String drno) {
		dao.delete(drno);
	}
	
	public DoctorVO getOneDoctor(String drno) {
		return dao.findByPK(drno);
	} 
	
	public List<DoctorVO> getByMajor(String major){
		return dao.findByMajor(major);
	}
	public List<DoctorVO> getAll(){
		return dao.getAll();
	}
	
	public List<DoctorVO> getMajor(){
		return dao.getMajor();
	}
	
	public DoctorVO getDrno(String memno) {
		return dao.getDrno(memno);
	}
	
	public void UpdateIsonline(String isonline,String memno) {
		dao.UpdateIsonline(isonline, memno);
	}
	
	public void UpdateStatus(String status,String memno) {
		dao.UpdateStatus(status, memno);
	}
}
