package com.menulist.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.menulist.model.MenuListService;
import com.menulist.model.MenuListVO;

public class MenuListAjaxServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		if ("insert".equals(action)) { // 來自updateAllMenu.jsp的請求
        	
        	Map<String,String> errorMsgs = new LinkedHashMap<String,String>();
			req.setAttribute("errorMsgs", errorMsgs);
			try {
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
				String menuNo = req.getParameter("menuNo");
				String menuTimeSlot = req.getParameter("menuTimeSlot");
				String menuDay = ""; 
				if(req.getParameter("menuDay").length() == 1) {
					menuDay = "0" + req.getParameter("menuDay");
				} else {
					menuDay = req.getParameter("menuDay");
				}
				String menuMonth = "";
				if(req.getParameter("menuMonth").trim().length() == 1) {
					menuMonth = "0" + req.getParameter("menuMonth");
				} else {
					menuMonth = req.getParameter("menuMonth");
				}
				String menuYear = req.getParameter("menuYear");
				
				SimpleDateFormat format = new SimpleDateFormat("ddMMyyyy");
				java.sql.Date menuDate = new java.sql.Date(format.parse(menuDay + menuMonth + menuYear).getTime());
				
				/***************************2.開始新增資料***************************************/
				MenuListService menuListSvc = new MenuListService();
				MenuListVO menuListVO = menuListSvc.addMenuList(menuNo, menuDate, menuTimeSlot);
				String pk = menuListVO.getMenuListNo();
				System.out.println(pk);
				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				res.setContentType("text/plain");
				res.setCharacterEncoding("UTF-8");
				res.getWriter().write(pk);  
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.put("Exception",e.getMessage());
			}
		}
		
//		=============================================================================
		
		if ("update".equals(action)) { // 來自updateAllMenu.jsp的請求
        	
        	Map<String,String> errorMsgs = new LinkedHashMap<String,String>();
			req.setAttribute("errorMsgs", errorMsgs);
			try {
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
				String menuNo = req.getParameter("menuNo");
				String menuListNo = req.getParameter("menuListNo");
				String menuTimeSlot = req.getParameter("menuTimeSlot");
				String menuDay = ""; 
				if(req.getParameter("menuDay").length() == 1) {
					menuDay = "0" + req.getParameter("menuDay");
				} else {
					menuDay = req.getParameter("menuDay");
				}
				String menuMonth = "";
				if(req.getParameter("menuMonth").trim().length() == 1) {
					menuMonth = "0" + req.getParameter("menuMonth");
				} else {
					menuMonth = req.getParameter("menuMonth");
				}
				String menuYear = req.getParameter("menuYear");
				
				SimpleDateFormat format = new SimpleDateFormat("ddMMyyyy");
				java.sql.Date menuDate = new java.sql.Date(format.parse(menuDay + menuMonth + menuYear).getTime());
				
				/***************************2.開始新增資料***************************************/
				MenuListService menuListSvc = new MenuListService();
				menuListSvc.updateMenuList(menuListNo, menuNo, menuDate, menuTimeSlot);
				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
//				res.setContentType("text/plain");
//				res.setCharacterEncoding("UTF-8");
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.put("Exception",e.getMessage());
			}
		}
		
//		=============================================================================
		
		if ("delete".equals(action)) { // 來自updateAllMenu.jsp的請求
        	
        	Map<String,String> errorMsgs = new LinkedHashMap<String,String>();
			req.setAttribute("errorMsgs", errorMsgs);
			try {
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
				String menuListNo = req.getParameter("menuListNo");
				
				/***************************2.開始新增資料***************************************/
				MenuListService menuListSvc = new MenuListService();
				menuListSvc.deleteMenuList(menuListNo);
				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
//				res.setContentType("text/plain");
//				res.setCharacterEncoding("UTF-8");
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.put("Exception",e.getMessage());
			}
		}
	}

}
