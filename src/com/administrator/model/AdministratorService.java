package com.administrator.model;

import java.util.List;

public class AdministratorService {
	private Administrator_interface dao;
	
	public AdministratorService() {
		dao=new AdministratorDAO();
	}
	
	public AdministratorVO addAdmin(String adminId,String adminPsw,String adminName,String priority,String status,java.sql.Date reg) {
		AdministratorVO adminVO = new AdministratorVO();
		
		adminVO.setAdminId(adminId);
		adminVO.setAdminPsw(adminPsw);
		adminVO.setAdminName(adminName);
		adminVO.setPriority(priority);
		adminVO.setStatus(status);
		adminVO.setReg(reg);
		dao.insert(adminVO);
		return adminVO;
	}
	
	public AdministratorVO updateAdmin(String adminNo,String adminId,String adminPsw,String adminName ,String priority,String status,java.sql.Date req) {
		AdministratorVO adminVO = new AdministratorVO();
		
		adminVO.setAdminId(adminId);
		adminVO.setAdminName(adminName);
		adminVO.setAdminPsw(adminPsw);
		adminVO.setPriority(priority);
		adminVO.setStatus(status);
		adminVO.setAdminNo(adminNo);
		adminVO.setReg(req);
		dao.update(adminVO);
		return adminVO;
	}
	public void deleteAdmin(String adminNo) {
		dao.delete(adminNo);
	}
	public AdministratorVO getOneAdmin(String adminNo) {
		return dao.findByPrimaryKey(adminNo);
	}
	public List<AdministratorVO> getAll(){
		return dao.getAll();
	}

	public AdministratorVO findByIdPsw(String adminId){		
		return dao.findByIdPsw(adminId);		
	}


}
