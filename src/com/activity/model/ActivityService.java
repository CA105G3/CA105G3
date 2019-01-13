package com.activity.model;

import java.sql.Date;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.impression.model.ImpressionVO;

public class ActivityService {
	
	private ActivityDAO_interface dao;
	
	public ActivityService(){
	dao = new ActivityDAO();
	}
	
	public ActivityVO addAct(String memNo,String actName,String actLoc,Date actTime,String actStatus,Integer actMax,Integer actLimit,Integer timeCheck,String actDesc,byte[] actPic,String latiTude,String longtiTude) {
		
		ActivityVO activityVO = new ActivityVO();
		activityVO.setMemNo(memNo);
		activityVO.setActName(actName);
		activityVO.setActLoc(actLoc);
		activityVO.setActTime(actTime);
		activityVO.setActStatus(actStatus);
		activityVO.setActMax(actMax);
		activityVO.setActLimit(actLimit);
		activityVO.setTimeCheck(timeCheck);
		activityVO.setActDesc(actDesc);
		activityVO.setActPic(actPic);
		activityVO.setLatiTude(latiTude);
		activityVO.setLongtiTude(longtiTude);
		dao.insert(activityVO);
		return activityVO;
	}
	
	public ActivityVO updateAct(String actNo,String memNo,String actName,String actLoc,Date actTime,String actStatus,Integer actMax,Integer actLimit,Integer timeCheck,String actDesc,byte[] actPic,String latiTude,String longtiTude) {
		ActivityVO activityVO = new ActivityVO();
		activityVO.setActNo(actNo);
		activityVO.setMemNo(memNo);
		activityVO.setActName(actName);
		activityVO.setActLoc(actLoc);
		activityVO.setActTime(actTime);
		activityVO.setActStatus(actStatus);
		activityVO.setActMax(actMax);
		activityVO.setActLimit(actLimit);
		activityVO.setTimeCheck(timeCheck);
		activityVO.setActDesc(actDesc);
		activityVO.setActPic(actPic);
		activityVO.setLatiTude(latiTude);
		activityVO.setLongtiTude(longtiTude);
		dao.update(activityVO);
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
	
	public List<ActivityVO> startact(String actStatus){
		return dao.getact(actStatus);
	}
	
	public List<ActivityVO> findmyact(String memNo){
		return dao.getmyact(memNo);
	}
	
	public List<ActivityVO> getactall(Map<String,String[]>map){
		return dao.getactall(map);
	}
	
	
	
}
