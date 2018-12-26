package com.impression.model;

import java.sql.Date;
import java.util.List;


public class ImpressionService {
	
	private ImpressionDAO_interface dao;
	
	public ImpressionService() {
		dao = new ImpressionJDBCDAO();
	}
	
	public ImpressionVO addImp(String actNo,String impName, String memNo,
			String impCon, byte[] recVideo, byte[] recPic,String impField) {

		ImpressionVO impressionVO = new ImpressionVO();

		
		impressionVO.setActNo(actNo);
		impressionVO.setImpName(impName);
		impressionVO.setMemNo(memNo);
		impressionVO.setImpCon(impCon);
		impressionVO.setRecVideo(recVideo);
		impressionVO.setRecPic(recPic);
		impressionVO.setImpField(impField);
		dao.insert(impressionVO);

		return impressionVO;
	}

	public ImpressionVO updateImp(String impNo,Date impTime,String impName,String actNo, String memNo,
			String impCon, byte[] recVideo, byte[] recPic,String impField) {

		ImpressionVO impressionVO = new ImpressionVO();

		impressionVO.setImpNo(impNo);
		impressionVO.setImpTime(impTime);
		impressionVO.setImpName(impName);		
		impressionVO.setActNo(actNo);
		impressionVO.setMemNo(memNo);
		impressionVO.setImpCon(impCon);
		impressionVO.setRecVideo(recVideo);
		impressionVO.setRecPic(recPic);
		impressionVO.setImpField(impField);
		dao.update(impressionVO);

		return impressionVO;
	}
	
	public ImpressionVO getOneImp(String impno) {
		return dao.findByPrimaryKey(impno);
	}
	public List<ImpressionVO> getAll() {
		return dao.getAll();
	}
	
	public void deleteImp(String impno) {
		dao.delete(impno);
	}
	
	
}
