package com.menulist.model2;

import java.util.List;

public interface MenuListDAO_interface {
	public void insert(MenuListVO menuListVO);
	public void update(MenuListVO menuListVO);
	public void delete(String menuListNo);
	
	public List<MenuListVO> findByMemno(String memno);
	public List<MenuListVO> findByChefName(String chefName);
	public List<MenuListVO> findByMenuTimeSlot(String menuTimeSlot);
	
	public MenuListVO findByPrimaryKey(String menuListNo);
	public List<MenuListVO> getAll();
}
