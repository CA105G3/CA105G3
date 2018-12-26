package com.activity.model;

import java.sql.Date;
import java.util.List;
import java.util.Set;

import com.impression.model.ImpressionVO;

public class ActivityService {
	
	private ActivityDAO_interface dao;
	
	public ActivityService(){
	dao = new ActivityJDBCDAO();
	}
	
	public ActivityVO addAct(String memNo,String actName,String actLoc,Date actTime,String actStatus,Integer actLimit,Integer timeCheck) {
		
		ActivityVO activityVO = new ActivityVO();
		activityVO.setMemNo(memNo);
		activityVO.setActName(actName);
		activityVO.setActLoc(actLoc);
		activityVO.setActTime(actTime);
		activityVO.setActStatus(actStatus);
		activityVO.setActLimit(actLimit);
		activityVO.setTimeCheck(timeCheck);
		dao.insert(activityVO);
		return activityVO;
	}
	
	public ActivityVO updateAct(String actNo,String memNo,String actName,String actLoc,Date actTime,String actStatus,Integer actLimit,Integer timeCheck) {
		ActivityVO activityVO = new ActivityVO();
		activityVO.setActNo(actNo);
		activityVO.setMemNo(memNo);
		activityVO.setActName(actName);
		activityVO.setActLoc(actLoc);
		activityVO.setActTime(actTime);
		activityVO.setActStatus(actStatus);
		activityVO.setActLimit(actLimit);
		activityVO.setTimeCheck(timeCheck);
		dao.insert(activityVO);
		return activityVO;
	}
	
	public ActivityVO getOneAct(String actNo) {
		return dao.findByPrimaryKey(actNo);
	}
	
	public List<ActivityVO> getAll() {
		return dao.getAll();
		
	}
	
	public void delete(String actNo) {
		dao.delete(actNo);
	}
	
	public Set<ImpressionVO> getmembyactno(String actNo){
		return dao.getmembyactno(actNo);
	}
	
	
	
	
	
	
	
}
