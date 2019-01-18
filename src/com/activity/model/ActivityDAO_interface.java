package com.activity.model;

import java.util.List;
import java.util.Map;
import java.util.Set;

import com.impression.model.ImpressionVO;
import com.joinact.model.JoinActVO;
import com.member.model.MemberVO;

public interface ActivityDAO_interface {
	public void insert(ActivityVO activityVO);
    public void update(ActivityVO activityVO);
    public void delete(String actNo);
    public ActivityVO findByPrimaryKey(String actNo);
    public List<ActivityVO> getAll();
    public Set<ImpressionVO> getmembyactno(String actNo);
    public List<ActivityVO> getact(String actStatus);
    public List<ActivityVO> getmyact(String memNo);
    public List<ActivityVO> getactall(Map<String,String[]>map);
    public void insertwithjoinact(ActivityVO activityVO);
}
