package com.menulist.model2;

import java.sql.Date;
import java.util.List;

public class MenuListService {
	
	private MenuListDAO_interface dao;
	
	public MenuListService() {
		dao = new MenuListDAO();
//		dao = new MenuListJDBCDAO();
	}
	
	public MenuListVO addMenuList(String menuNo, Date menuDate, String menuTimeSlot) {
		MenuListVO menulistVO = new MenuListVO();
		menulistVO.setMenuNo(menuNo);
		menulistVO.setMenuDate(menuDate);
		menulistVO.setMenuTimeSlot(menuTimeSlot);
		dao.insert(menulistVO);
		
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

	public List<MenuListVO> findByMemno(String memno){
		return dao.findByMemno(memno);
	}
	
	public List<MenuListVO> findByChefName(String chefName){
		return dao.findByChefName(chefName);
	}
	
	public List<MenuListVO> findByMenuTimeSlot(String menuTimeSlot){
		return dao.findByMenuTimeSlot(menuTimeSlot);
	}
	
	public MenuListVO getOneMenuList(String menuListNo) {
		return dao.findByPrimaryKey(menuListNo);
	}

	public List<MenuListVO> getAll() {
		return dao.getAll();
	}
}

