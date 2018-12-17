package com.medicalorder.model;

import java.util.List;

public class MedicalOrderService {
	
	private MedicalOrder_interface dao;
	
	public MedicalOrderService() {
		dao = new MedicalOrderDAO();
	}
	
	public MedicalOrderVO addMedicalOrder(String moNo, String memNo, String drNo, String moStatus,
			 Integer moCost, java.sql.Date moTime, String moIntro, byte[] moVideo, String moText) {
		
		MedicalOrderVO medicalOrderVO = new MedicalOrderVO();
		
		medicalOrderVO.setMoNo(moNo);
		medicalOrderVO.setMemNo(memNo);
		medicalOrderVO.setDrNo(drNo);
		medicalOrderVO.setMoStatus(moStatus);
		medicalOrderVO.setMoTime(moTime);
		medicalOrderVO.setMoIntro(moIntro);
		medicalOrderVO.setMoVideo(moVideo);
		medicalOrderVO.setMoText(moText);
		dao.insert(medicalOrderVO);
		
		return medicalOrderVO;
		
	}

	public MedicalOrderVO updateMedicalOrder(String moNo, String memNo, String drNo, String moStatus,
			 Integer moCost, java.sql.Date moTime, String moIntro, byte[] moVideo, String moText) {
		
		MedicalOrderVO medicalOrderVO = new MedicalOrderVO();
		
		medicalOrderVO.setMoNo(moNo);
		medicalOrderVO.setMemNo(memNo);
		medicalOrderVO.setDrNo(drNo);
		medicalOrderVO.setMoStatus(moStatus);
		medicalOrderVO.setMoTime(moTime);
		medicalOrderVO.setMoIntro(moIntro);
		medicalOrderVO.setMoVideo(moVideo);
		medicalOrderVO.setMoText(moText);
		dao.update(medicalOrderVO);
		
		return medicalOrderVO;
		
	}
	
	public void deleteMedicalOrder(String moNo) {
		dao.delete(moNo);
	}
	
	public MedicalOrderVO getOneMedicalOrder(String moNo) {
		return dao.findByPrimaryKey(moNo);	
	}
	
	public List<MedicalOrderVO> getAll(){
		return dao.getAll();
	}
	
}
