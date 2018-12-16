package com.doctor.model;

import java.util.List;

public class DoctorService {
	private DoctorDAO_interface dao;
	
	public DoctorService(){
		dao = new DoctorJDBCDAO();
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
	
	public List<DoctorVO> getAll(){
		return dao.getAll();
	}
}
