package com.menulist.controller;

import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.menulist.model.MenuListService;
import com.menulist.model.MenuListVO;

public class MenuListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");

		
        if ("update".equals(action)) { // 來自updateAllMenuList.jsp的請求
			
			Map<String,String> errorMsgs = new LinkedHashMap<String,String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
				String menuListNo = req.getParameter("menuListNo");
				
				String menuNo = req.getParameter("menuNo");
				if (menuNo == null || menuNo.trim().length() == 0) {
					errorMsgs.put("menuNo","請輸入供餐內容");
				}
				
				java.sql.Date menuDate = (Date) new SimpleDateFormat("ddMMMyyyy").parse(
						req.getParameter("day") + req.getParameter("month") + req.getParameter("year"));					;
				
				String menuTimeSlot = req.getParameter("menuTimeSlot").trim();
				if (menuTimeSlot == null || menuTimeSlot.trim().length() == 0) {
					errorMsgs.put("menuTimeSlot","請輸入供餐時段");
				}
				
				MenuListVO menuListVO = new MenuListVO();
				menuListVO.setMenuListNo(menuListNo);
				menuListVO.setMenuNo(menuNo);
				menuListVO.setMenuDate(menuDate);
				menuListVO.setMenuTimeSlot(menuTimeSlot);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/menulist/updateAllMenuList.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始修改資料***************************************/
				MenuListService menuListSvc = new MenuListService();
				menuListSvc.updateMenuList(menuListNo, menuNo, menuDate, menuTimeSlot);
				
				/***************************3.修改完成,準備轉交(Send the Success view)***********/
				req.setAttribute("menuListVO", menuListVO);
				String url = "/menulist/getAllMenuList.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交getAllMenuList.jsp
				successView.forward(req, res);				
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.put("Exception",e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/menulist/updateAllMenu.jsp");
				failureView.forward(req, res);
			}
        }
        
//		=============================================================================
        
        if ("insert".equals(action)) { // 來自updateAllMenu.jsp的請求
			
			Map<String,String> errorMsgs = new LinkedHashMap<String,String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
				String menuNo = req.getParameter("menuNo");
				if (menuNo == null || menuNo.trim().length() == 0) {
					errorMsgs.put("menuNo","請輸入供餐內容");
				}
				
				java.sql.Date menuDate = (Date) new SimpleDateFormat("ddMMMyyyy").parse(
						req.getParameter("day") + req.getParameter("month") + req.getParameter("year"));					;
				
				String menuTimeSlot = req.getParameter("menuTimeSlot").trim();
				if (menuTimeSlot == null || menuTimeSlot.trim().length() == 0) {
					errorMsgs.put("menuTimeSlot","請輸入供餐時段");
				}

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/menulist/updateAllMenu.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始新增資料***************************************/
				MenuListService menuListSvc = new MenuListService();
				menuListSvc.addMenuList(menuNo, menuDate, menuTimeSlot);
				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				String url = "/menulist/getAllMenuList.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllMenuList.jsp
				successView.forward(req, res);				
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.put("Exception",e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/menulist/updateAllMenu.jsp");
				failureView.forward(req, res);
			}
		}
	}
}
