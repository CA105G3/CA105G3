package com.favdr.model;

import java.util.*;

public interface FavDr_interface {
	
	public void insert(FavDrVO favDrVO);
//	public void update(FavDrVO favDrVO);	//追蹤表格的欄位只有雙主鍵，不用update方法
	public void delete(FavDrVO favDrVO);
	public List<FavDrVO> findByPrimaryKey(String memNo);
	public List<FavDrVO> getAll();

}
