package com.joinact.model;

import java.sql.Date;
import java.util.List;
import java.util.Set;

public class JoinActService {

	private JoinActDAO_interface dao;
	
	public JoinActService(){
		dao = new JoinActDAO();
	}
	
	public JoinActVO addJoin(String actNo,String memNo) {
		
		JoinActVO joinActVO = new JoinActVO();
		joinActVO.setActNo(actNo);
		joinActVO.setMemNo(memNo);
		
		dao.insert(joinActVO);
		return joinActVO;
	}
	
	public JoinActVO updateAct(String actNo,String memNo) {
		JoinActVO joinActVO = new JoinActVO();
		joinActVO.setActNo(actNo);
		joinActVO.setMemNo(memNo);
		
		dao.update(joinActVO);
		return joinActVO;
	}
	
	public JoinActVO getOneAct(String actNo) {
		return dao.findByPrimaryKey(actNo);
	}
	
	public List<JoinActVO> getAll() {
		return dao.getAll();
		
	}
	
	public void delete(String actNo,String memNo) {
		dao.delete(actNo,memNo);
	}
	public Set<PersonActVO> getAll(String memNo){
		return dao.getAll(memNo);
	}
	
	public JoinActVO repeatact(String actNo,String memNo) {
		 return dao.findrepeatact(actNo, memNo);
	}
	
	public List<ChatRoomVO> getchatmember(String actNo) {
		return dao.chatroomall(actNo);
		
	}
}
