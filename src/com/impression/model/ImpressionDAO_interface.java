package com.impression.model;

import java.util.List;

import com.activity.model.ActivityVO;
import com.joinact.model.JoinactVO;

public interface ImpressionDAO_interface {
	public void insert(ImpressionVO impressionVO);
    public void update(ImpressionVO impressionVO);
    public void delete(String impNo);
    public ImpressionVO findByPrimaryKey(String impNo);
    public List<ImpressionVO> getAll();
}
