package com.administrator.model;

import java.util.*;

public interface Administrator_interface {

	public void insert(AdministratorVO administratorVO);
	public void update(AdministratorVO administratorVO);
	public void delete(String adminno);
	public AdministratorVO findByPrimaryKey(String adminNo);
	public List<AdministratorVO> getAll();
	
}
