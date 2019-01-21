package com.license.model;

import java.sql.Date;
import java.util.List;
import java.util.Set;

public class LicenseService {
	
private LicenseDAO_interface dao;
	
	public LicenseService(){
	dao = new LicenseDAO();
	}
	
public LicenseVO addLic(String memNo,byte[] licData,String licStatus,String licDesc,Date licDue) {
		
		LicenseVO licenseVO = new LicenseVO();
		licenseVO.setMemNo(memNo);
		licenseVO.setLicData(licData);
		licenseVO.setLicStatus(licStatus);
		licenseVO.setLicDesc(licDesc);
		licenseVO.setLicDue(licDue);
		dao.insert(licenseVO);
		return licenseVO;
	}
	
	public LicenseVO updateLic(String licNo,String memNo,byte[] licData,String licStatus,String licDesc,Date licDue) {
		LicenseVO licenseVO = new LicenseVO();
		licenseVO.setLicNo(licNo);
		licenseVO.setMemNo(memNo);
		licenseVO.setLicData(licData);
		licenseVO.setLicStatus(licStatus);
		licenseVO.setLicDesc(licDesc);
		licenseVO.setLicDue(licDue);
		dao.update(licenseVO);
		return licenseVO;
	}
	
	public LicenseVO getOneLic(String licNo) {
		return dao.findByPrimaryKey(licNo);
	}
	
	public List<QualifyVO> getAll() {
		return dao.getAll();
		
	}
	
	public void delete(String licNo) {
		dao.delete(licNo);
	}
	
	public List<QualifyVO> getChange(String licStatus){
		return dao.getChange(licStatus);
	}
	
	public LicenseVO changestatus(String licNo,String licStatus) {
		LicenseVO licenseVO = new LicenseVO();
		licenseVO.setLicNo(licNo);
		licenseVO.setLicStatus(licStatus);
		dao.changestatus(licNo,licStatus);
		return licenseVO;
	}
}
