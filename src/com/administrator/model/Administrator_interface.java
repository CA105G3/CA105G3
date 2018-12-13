package com.administrator.model;

import java.util.*;

public interface Administrator_interface {

	public void insert(AdministratorVO administratorVO);
	public void update_priority_status(AdministratorVO administratorVO);
	public void update_priority(AdministratorVO administratorVO);
	public void update_status(AdministratorVO administratorVO);
	public void delete(String adminno);
	public AdministratorVO findByPrimaryKey(String adminNo);
	public List<AdministratorVO> getAll();
	
}
