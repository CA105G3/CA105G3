package com.joinact.model;

import java.util.List;
import java.util.Set;

import com.activity.model.ActivityVO;

public interface JoinActDAO_interface {
	public void insert(JoinActVO joinactVO);
    public void update(JoinActVO joinactVO);
    public void delete(String actNo, String memNo);
    public List<JoinActVO> findByPrimaryKey(String actNo);
    public List<JoinActVO> getAll();
    public Set<PersonActVO> getAll(String memNo);
    public JoinActVO findrepeatact(String actNo,String memNo);
    public List<ChatRoomVO> chatroomall(String actNo);
    public List<PersonActVO> findoffact(String memNo);
    public void insert2 (JoinActVO joinActVO , java.sql.Connection con); 
}
