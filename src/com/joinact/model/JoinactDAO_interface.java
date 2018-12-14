package com.joinact.model;

import java.util.List;

import com.activity.model.ActivityVO;

public interface JoinactDAO_interface {
	public void insert(JoinactVO joinactVO);
    public void update(JoinactVO joinactVO);
    public void delete(String actNo);
    public JoinactVO findByPrimaryKey(String actNo);
    public List<JoinactVO> getAll();
}
