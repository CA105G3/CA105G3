package com.menulist.model;

import java.util.List;

public interface MenuListDAO_interface {
	public String insert(MenuListVO menuListVO);
	public void update(MenuListVO menuListVO);
	public void delete(String menuListNo);
	public MenuListVO findByPrimaryKey(String menuListNo);
	public List<MenuListVO> findByMenuNo(String MenuNo);
	public List<MenuListVO> getAll();
}
