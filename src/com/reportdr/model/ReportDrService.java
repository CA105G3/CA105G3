package com.reportdr.model;

import java.util.List;

import com.medicalorder.model.MedicalOrderDAO;
import com.reportact.model.ReportactVO;

public class ReportDrService {

	private ReportDr_interface dao;
	
	public ReportDrService() {
		dao = new ReportDrDAO();
	}
	
	public ReportDrVO addReportDr(String memNo, String drNo, String rdrReason, String rdrState) {
		
		ReportDrVO reportDrVO = new ReportDrVO();
		
		reportDrVO.setMemNo(memNo);
		reportDrVO.setDrNo(drNo);
		reportDrVO.setRdrReason(rdrReason);
		reportDrVO.setRdrState(rdrState);
		dao.insert(reportDrVO);
		
		return reportDrVO;		
	}
	
	public ReportDrVO update_rdrReason_rdrStateReportDr(String rdrReason, String rdrState,String drNo) {
		
		ReportDrVO reportDrVO = new ReportDrVO();
		
		reportDrVO.setRdrState(rdrState);
		reportDrVO.setRdrReason(rdrReason);
		reportDrVO.setDrNo(drNo);
		dao.update_rdrReason_rdrState(reportDrVO);
	
		return reportDrVO;		
	}
	
	public ReportDrVO update_rdrReasonReportDr(String rdrReason, String drNo) {
		
		ReportDrVO reportDrVO = new ReportDrVO();
		
		reportDrVO.setRdrReason(rdrReason);
		reportDrVO.setDrNo(drNo);
		dao.update_rdrReason(reportDrVO);
	
		return reportDrVO;		
	}
	
	public ReportDrVO update_rdrStateReportDr(String rdrState, String rdrNo) {
		
		ReportDrVO reportDrVO = new ReportDrVO();
		
		reportDrVO.setRdrState(rdrState);
		reportDrVO.setRdrNo(rdrNo);
		dao.update_rdrState(reportDrVO);
		
		return reportDrVO;
	}
	
	public void deleteReportDr(String rdrNo) {
		dao.delete(rdrNo);
	}
	
	public ReportDrVO getOneReportDr(String rdrNo) {
		return dao.findByPrimaryKey(rdrNo);
	}
	
	public List<ReportDrVO> getAllReportDr(){
		return dao.getAll();
	}
	
	public List<ReportDrVO> getNeedUpdate(){//撈出實際會使用到需要修改狀態的指令與方法：後台管理員處理檢舉
		return dao.getNeedUpdate();
	}
	
	
	
	
	
	
}
