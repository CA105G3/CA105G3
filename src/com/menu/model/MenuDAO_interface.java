package com.menu.model;

import java.util.List;

public interface MenuDAO_interface {
	public void insert(MenuVO menuVO);
	public void update(MenuVO menuVO);
	public void delete(String menuNo);
	public MenuVO findByPrimaryKey(String menuNo);
	public List<MenuVO> findByChefNo(String chefNo);
	public List<MenuVO> getAll();
}
