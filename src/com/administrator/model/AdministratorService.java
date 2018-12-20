package com.administrator.model;

import java.util.List;

public class AdministratorService {
	private Administrator_interface dao;
	
	public AdministratorService() {
		dao=new AdministratorDAO();
	}
	
	public AdministratorVO addAdmin(String adminid,String adminpsw,String priority,String status,java.sql.Date reg) {
		AdministratorVO adminVO = new AdministratorVO();
		
		adminVO.setAdminId(adminid);
		adminVO.setAdminPsw(adminpsw);
		adminVO.setPriority(priority);
		adminVO.setStatus(status);
		adminVO.setReg(reg);
		dao.insert(adminVO);
		return adminVO;
	}
	
	public AdministratorVO updateAdmin(String adminno,String adminid,String adminpsw,String priority,String status,java.sql.Date reg) {
		AdministratorVO adminVO = new AdministratorVO();
		adminVO.setAdminNo(adminno);
		adminVO.setAdminId(adminid);
		adminVO.setAdminPsw(adminpsw);
		adminVO.setPriority(priority);
		adminVO.setStatus(status);
		adminVO.setReg(reg);
		dao.update(adminVO);
		return adminVO;
	}
	public void deleteAdmin(String adminno) {
		dao.delete(adminno);
	}
	public AdministratorVO getOneAdmin(String adminno) {
		return dao.findByPrimaryKey(adminno);
	}
	public List<AdministratorVO> getAll(){
		return dao.getAll();
	}
}
