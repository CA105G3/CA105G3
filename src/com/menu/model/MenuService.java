package com.menu.model;

import java.util.List;

public class MenuService {
	
	private MenuDAO_interface dao;
	
	public MenuService() {
		dao = new MenuDAO();
	}
	
	public MenuVO addMenu(String chefNo, int unitPrice, String mainCourse, byte[] menuPic,
			String deliverable) {
		MenuVO menuVO = new MenuVO();
		menuVO.setChefNo(chefNo);
		menuVO.setUnitPrice(unitPrice);
		menuVO.setMainCourse(mainCourse);
		menuVO.setMenuPic(menuPic);
		menuVO.setDeliverable(deliverable);
		dao.insert(menuVO);
		
		return menuVO;
	}
		
	public void addMenu(MenuVO menuVO) {
		dao.insert(menuVO);
	}
	
	public MenuVO updateMenu(int unitPrice, String mainCourse, byte[] menuPic,
			String deliverable, String menuNo) {
		MenuVO menuVO = new MenuVO();
		menuVO.setUnitPrice(unitPrice);
		menuVO.setMainCourse(mainCourse);
		menuVO.setMenuPic(menuPic);
		menuVO.setDeliverable(deliverable);
		menuVO.setMenuNo(menuNo);
		dao.update(menuVO);
		
		return menuVO;
	}
	
	public void updateMenu(MenuVO menuVO) {
		dao.update(menuVO);
	}
	
	public void deleteMenu(String menuNo) {
		dao.delete(menuNo);
	}

	public MenuVO getOneMenu(String menuNo) {
		return dao.findByPrimaryKey(menuNo);
	}
	
	public List<MenuVO> getOneChefMenu(String chefNo) {
		return dao.findByChefNo(chefNo);
	}

	public List<MenuVO> getAll() {
		return dao.getAll();
	}
}
