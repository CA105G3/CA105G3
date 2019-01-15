package com.ppttool.model;

import java.util.List;

public class PPTToolService {
	private PPTToolDAO_interface dao;
	
	public PPTToolService() {
		dao=new PPTToolDAO();
	}
	
	public PPTToolVO addPPT(String drno,byte[] ppt) {
		PPTToolVO pvo = new PPTToolVO();
		pvo.setDrno(drno);
		pvo.setPpt(ppt);
		dao.insert(pvo);
		return pvo;
	}
	
	public PPTToolVO update(String pptno,byte[] ppt,String drno) {
		PPTToolVO pvo = new PPTToolVO();
		pvo.setPptno(pptno);
		pvo.setPpt(ppt);
		pvo.setDrno(drno);
		dao.update(pvo);
		return pvo;
	}
	public void deletePPT(String pptno) {
		dao.delete(pptno);
	}
	public PPTToolVO getOnePPT(String pptno) {
		return dao.findByPK(pptno);
	}
	public List<PPTToolVO> getAll(){
		return dao.getAll();
	}
	
	public List<PPTToolVO> getPPTsByDrno(String drno){
		return dao.getPPTsByDrno(drno);
	}
}
