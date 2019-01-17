package com.medicalorder.model;

import java.sql.Date;
import java.util.List;

public class MedicalOrderService {
	
	private MedicalOrder_interface dao;
	
	public MedicalOrderService() {
		dao = new MedicalOrderDAO();
	}
	
	public MedicalOrderVO addMedicalOrder(String memNo, String drNo, String moStatus,
			 Integer moCost, Date moTime, Integer moHour, String moIntro, String moCancelReason ,byte[] moVideo, String moText) {
		
		MedicalOrderVO medicalOrderVO = new MedicalOrderVO();
		
//		medicalOrderVO.setMoNo(moNo);
		medicalOrderVO.setMemNo(memNo);
		medicalOrderVO.setDrNo(drNo);
		medicalOrderVO.setMoStatus(moStatus);
		medicalOrderVO.setMoCost(moCost);
		medicalOrderVO.setMoTime(moTime);
		medicalOrderVO.setMoHour(moHour);
		medicalOrderVO.setMoIntro(moIntro);
		medicalOrderVO.setMoCancelReason(moCancelReason);
		medicalOrderVO.setMoVideo(moVideo);
		medicalOrderVO.setMoText(moText);
		dao.insert(medicalOrderVO);
		
		return medicalOrderVO;
		
	}

	public MedicalOrderVO updateMedicalOrder(String moNo, String memNo, String drNo, String moStatus,
			 Integer moCost, Date moTime, String moIntro, String moCancelReason ,byte[] moVideo, String moText) {
		
		MedicalOrderVO medicalOrderVO = new MedicalOrderVO();

		medicalOrderVO.setMoNo(moNo);
		medicalOrderVO.setMemNo(memNo);
		medicalOrderVO.setDrNo(drNo);
		medicalOrderVO.setMoStatus(moStatus);
		medicalOrderVO.setMoCost(moCost);
		medicalOrderVO.setMoTime(moTime);
		medicalOrderVO.setMoIntro(moIntro);
		medicalOrderVO.setMoCancelReason(moCancelReason);
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
	
	public List<MedicalOrderVO> findListforMember(String memNo){
		return dao.findListforMember(memNo);	
	}
	
	public MedicalOrderVO cancelMedicalOrder(String moNo, String moCancelReason) {
		MedicalOrderVO medicalOrderVO = new MedicalOrderVO();
		medicalOrderVO.setMoNo(moNo);
		medicalOrderVO.setMoCancelReason(moCancelReason);
		dao.cancelMedicalOrder(medicalOrderVO);
		return medicalOrderVO;
	}
	
	
//	========================================================
	public List<MedicalOrderVO> getByDrno(String drno){
		return dao.getByDrno(drno);
	}
	
	public List<MedicalOrderVO> getByDrnoToday(String drno){
		return dao.getByDrnoToday(drno);
	}
	
	public List<MedicalOrderVO> getByDrnoThisMonth(String drno){
		return dao.getByDrnoThisMonth(drno);
	}
	
	public List<MedicalOrderVO> getByDrnoNextMonth(String drno){
		return dao.getByDrnoNextMonth(drno);
	}
	
	public List<MedicalOrderVO> getByDrnoThisWeek(String drno){
		return dao.getByDrnoThisWeek(drno);
	}
	
	public void cancelByDr(String moNo, String moStatus){
		MedicalOrderVO medicalOrderVO = new MedicalOrderVO();
		medicalOrderVO.setMoStatus(moStatus);
		medicalOrderVO.setMoNo(moNo);
		dao.calcelByDr(medicalOrderVO);
	}
	
	public List<MedicalOrderVO> getByDrnoThisMonthDone(String drno){
		return dao.getByDrnoThisMonthDone(drno);
	}
	
	public void addMotext(String moNo,String record) {
		dao.updatemotext(moNo, record);
	}
}


