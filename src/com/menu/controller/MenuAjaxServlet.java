package com.menu.controller;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 500 * 6000 * 6000, maxRequestSize = 10 * 500 * 6000 * 6000)
public class MenuAjaxServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		if ("update".equals(action)) { // 來自updateAllMenu.jsp的請求
        	
        	Map<String,String> errorMsgs = new LinkedHashMap<String,String>();
			req.setAttribute("errorMsgs", errorMsgs);
			try {
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
				String menuNo = req.getParameter("menuNo");
				String chefNo = req.getParameter("chefNo");
				String mainCourse = req.getParameter("mainCourse");
				String unitPrice = req.getParameter("unitPrice");
				String deliverable = req.getParameter("deliverable");
				String menuPic = req.getParameter("menuPic");
				
				System.out.println(menuNo);
				System.out.println(chefNo);
				System.out.println(mainCourse);
				System.out.println(unitPrice);
				System.out.println(deliverable);
				System.out.println(menuPic);
				
				/***************************2.開始新增資料***************************************/
				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
//				res.setContentType("text/plain");
//				res.setCharacterEncoding("UTF-8");
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.put("Exception",e.getMessage());
			}
		}
		
//		=============================================================================
	}

}
