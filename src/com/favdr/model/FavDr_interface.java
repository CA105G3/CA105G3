package com.favdr.model;

import java.util.*;

public interface FavDr_interface {
	
	public void insert(FavDrVO favDrVO);
	public void update(FavDrVO favDrVO);
	public void delete(FavDrVO favDrVO);
	public List<FavDrVO> findByPrimaryKey(String memNo);
	public List<FavDrVO> getAll();

}
