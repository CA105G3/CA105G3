package com.impression.model;

import java.util.List;

import com.activity.model.ActivityVO;
import com.joinact.model.JoinActVO;

public interface ImpressionDAO_interface {
	public void insert(ImpressionVO impressionVO);
    public void update(ImpressionVO impressionVO);
    public void delete(String impno);
    public ImpressionVO findByPrimaryKey(String impNo);
    public List<ImpressionVO> getAll();
    public List<ImpressionVO> findmyimp(String memNo);
}
