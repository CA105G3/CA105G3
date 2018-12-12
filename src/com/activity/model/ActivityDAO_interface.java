package com.activity.model;

import java.util.List;

import com.member.model.MemberVO;

public interface ActivityDAO_interface {
	public void insert(ActivityVO activityVO);
    public void update(ActivityVO activityVO);
    public void delete(String actno);
    public ActivityVO findByPrimaryKey(String actno);
    public List<ActivityVO> getAll();
}
