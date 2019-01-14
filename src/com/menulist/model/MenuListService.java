package com.menulist.model;

import java.sql.Date;
import java.util.List;

public class MenuListService {
	
	private MenuListDAO_interface dao;
	
	public MenuListService() {
		dao = new MenuListDAO();
	}
	
	public MenuListVO addMenuList(String menuNo, Date menuDate, String menuTimeSlot) {
		MenuListVO menulistVO = new MenuListVO();
		menulistVO.setMenuNo(menuNo);
		menulistVO.setMenuDate(menuDate);
		menulistVO.setMenuTimeSlot(menuTimeSlot);
		menulistVO.setMenuListNo(dao.insert(menulistVO));
		
		return menulistVO;
	}
	
	public void addMenuList(MenuListVO menulistVO) {
		dao.insert(menulistVO);
	}
	
	public MenuListVO updateMenuList(String menuListNo, String menuNo, Date menuDate, String menuTimeSlot) {
		MenuListVO menulistVO = new MenuListVO();
		menulistVO.setMenuListNo(menuListNo);
		menulistVO.setMenuNo(menuNo);
		menulistVO.setMenuDate(menuDate);
		menulistVO.setMenuTimeSlot(menuTimeSlot);
		dao.update(menulistVO);
		
		return dao.findByPrimaryKey(menuListNo);
	}
	
	public void updateMenuList(MenuListVO menulistVO) {
		dao.update(menulistVO);
	}
	
	public void deleteMenuList(String menuListNo) {
		dao.delete(menuListNo);
	}

	public MenuListVO getOneMenuList(String menuListNo) {
		return dao.findByPrimaryKey(menuListNo);
	}
	
	public List<MenuListVO> getOneKindMenuList(String menuNo) {
		return dao.findByMenuNo(menuNo);
	}

	public List<MenuListVO> getAll() {
		return dao.getAll();
	}
}

