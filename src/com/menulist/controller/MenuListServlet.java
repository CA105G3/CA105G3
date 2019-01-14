package com.menulist.controller;

import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.menu.model.MenuService;
import com.menu.model.MenuVO;
import com.menulist.model.MenuListService;
import com.menulist.model.MenuListVO;

public class MenuListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	@SuppressWarnings("null")
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");

        if ("For_Display".equals(action)) { // 來自updateAllMenuList.jsp的請求
			
			Map<String,String> errorMsgs = new LinkedHashMap<String,String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
				String chefNo = req.getParameter("chefNo");
				String month = req.getParameter("month");
				String year = req.getParameter("year");
				
				/***************************2.開始修改資料***************************************/
				MenuService menuSvc = new MenuService();
				List<MenuVO> menu = menuSvc.getOneChefMenu(chefNo);
				
				MenuListService menuListSvc = new MenuListService();
				List<MenuListVO> menuList = new ArrayList<MenuListVO>();
				
				for(MenuVO amenuVO : menu){
//					System.out.print(amenuVO.getMenuNo() + " , ");
//					System.out.print(amenuVO.getChefNo() + " , ");
//					System.out.print(amenuVO.getUnitPrice() + " , ");
//					System.out.print(amenuVO.getMainCourse() + " , ");
//					System.out.println(amenuVO.getDeliverable());
//					System.out.println("--------------------------------");
					String menuNo = amenuVO.getMenuNo();
					List<MenuListVO> list = menuListSvc.getOneKindMenuList(menuNo);
					for(MenuListVO amenuListVO : list){
//						System.out.print(amenuListVO.getMenuListNo());
//						System.out.print(amenuListVO.getMenuNo());
//						System.out.print(amenuListVO.getMenuTimeSlot());
//						System.out.println(amenuListVO.getMenuDate());
//						System.out.println("--------------------------------");
						if(amenuListVO.getMenuTimeSlot().equals("早")) {
							menuList.add(amenuListVO);
						}
					}
					for(MenuListVO amenuListVO : list){
						if(amenuListVO.getMenuTimeSlot().equals("午")) {
							menuList.add(amenuListVO);
						}
					}
					for(MenuListVO amenuListVO : list){
						if(amenuListVO.getMenuTimeSlot().equals("晚")) {
							menuList.add(amenuListVO);
						}
					}
				};
				
				/***************************3.修改完成,準備轉交(Send the Success view)***********/
				req.setAttribute("menu", menu);
				req.setAttribute("menuList", menuList);
				req.setAttribute("month", month);
				req.setAttribute("year", year);
				req.setAttribute("chefNo", chefNo);
				String url = "/front-end/menulist/listOneChefMenuList.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交getAllMenuList.jsp
				successView.forward(req, res);				
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.put("Exception",e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/menulist/select_page.jsp");
				failureView.forward(req, res);
			}
        }
        
//		=============================================================================
        
        if ("For_Display_Test".equals(action)) { // 來自updateAllMenuList.jsp的請求
			
			Map<String,String> errorMsgs = new LinkedHashMap<String,String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
				String chefNo = req.getParameter("chefNo");
				
				/***************************2.開始修改資料***************************************/
				MenuService menuSvc = new MenuService();
				List<MenuVO> menu = menuSvc.getOneChefMenu(chefNo);
				
				MenuListService menuListSvc = new MenuListService();
				List<MenuListVO> menuList = new ArrayList<MenuListVO>();
				
				for(MenuVO amenuVO : menu){
//					System.out.print(amenuVO.getMenuNo() + " , ");
//					System.out.print(amenuVO.getChefNo() + " , ");
//					System.out.print(amenuVO.getUnitPrice() + " , ");
//					System.out.print(amenuVO.getMainCourse() + " , ");
//					System.out.println(amenuVO.getDeliverable());
//					System.out.println("--------------------------------");
					String menuNo = amenuVO.getMenuNo();
					List<MenuListVO> list = menuListSvc.getOneKindMenuList(menuNo);
					for(MenuListVO amenuListVO : list){
//						System.out.print(amenuListVO.getMenuListNo());
//						System.out.print(amenuListVO.getMenuNo());
//						System.out.print(amenuListVO.getMenuTimeSlot());
//						System.out.println(amenuListVO.getMenuDate());
//						System.out.println("--------------------------------");
						if(amenuListVO.getMenuTimeSlot().equals("早")) {
							menuList.add(amenuListVO);
						}
					}
					for(MenuListVO amenuListVO : list){
						if(amenuListVO.getMenuTimeSlot().equals("午")) {
							menuList.add(amenuListVO);
						}
					}
					for(MenuListVO amenuListVO : list){
						if(amenuListVO.getMenuTimeSlot().equals("晚")) {
							menuList.add(amenuListVO);
						}
					}
				};
				
				/***************************3.修改完成,準備轉交(Send the Success view)***********/
				req.setAttribute("menu", menu);
				req.setAttribute("menuList", menuList);
				req.setAttribute("chefNo", chefNo);
				String url = "/front-end/menulist/listOneChefMenuListTest.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交getAllMenuList.jsp
				successView.forward(req, res);				
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.put("Exception",e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/menulist/select_page.jsp");
				failureView.forward(req, res);
			}
        }
        
//		=============================================================================
        
        if ("For_Update".equals(action)) { // 來自updateAllMenuList.jsp的請求
			
			Map<String,String> errorMsgs = new LinkedHashMap<String,String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
				String chefNo = req.getParameter("chefNo");
				String month = req.getParameter("month");
				String year = req.getParameter("year");
				
				/***************************2.開始修改資料***************************************/
				MenuService menuSvc = new MenuService();
				List<MenuVO> menu = menuSvc.getOneChefMenu(chefNo);
				
				MenuListService menuListSvc = new MenuListService();
				List<MenuListVO> menuList = new ArrayList<MenuListVO>();
				
				for(MenuVO amenuVO : menu){
					String menuNo = amenuVO.getMenuNo();
					List<MenuListVO> list = menuListSvc.getOneKindMenuList(menuNo);
					for(MenuListVO amenuListVO : list){
						if(amenuListVO.getMenuTimeSlot().equals("早")) {
							menuList.add(amenuListVO);
						}
					}
					for(MenuListVO amenuListVO : list){
						if(amenuListVO.getMenuTimeSlot().equals("午")) {
							menuList.add(amenuListVO);
						}
					}
					for(MenuListVO amenuListVO : list){
						if(amenuListVO.getMenuTimeSlot().equals("晚")) {
							menuList.add(amenuListVO);
						}
					}
				};
				
				/***************************3.修改完成,準備轉交(Send the Success view)***********/
				req.setAttribute("menu", menu);
				req.setAttribute("menuList", menuList);
				req.setAttribute("month", month);
				req.setAttribute("year", year);
				req.setAttribute("chefNo", chefNo);
				String url = "/front-end/menulist/updateOneChefMenuList.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交getAllMenuList.jsp
				successView.forward(req, res);				
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.put("Exception",e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/menulist/select_page.jsp");
				failureView.forward(req, res);
			}
        }
	}
}
