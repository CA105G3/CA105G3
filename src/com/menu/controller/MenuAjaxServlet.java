package com.menu.controller;

import java.io.IOException;
import java.io.InputStream;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.menu.model.MenuService;

@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 500 * 6000 * 6000, maxRequestSize = 10 * 500 * 6000 * 6000)
public class MenuAjaxServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		if ("insert".equals(action)) { 
        	
        	Map<String,String> errorMsgs = new LinkedHashMap<String,String>();
			req.setAttribute("errorMsgs", errorMsgs);
			try {
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
				String chefNo = req.getParameter("chefNo");
				String mainCourse = req.getParameter("mainCourse");
				String unitPrice = req.getParameter("unitPrice");
				String deliverable = "true".equals(req.getParameter("deliverable")) ? "可送餐" : "不可送餐" ;
				String menuIntro = req.getParameter("menuIntro");

				byte[] menuPic = null;
				Part part = req.getPart("menuPic");
				String filename = part.getSubmittedFileName();

				if (filename != "") {
					InputStream in = part.getInputStream();
					menuPic = new byte[in.available()];
					in.read(menuPic);
					in.close();
				} else {
					InputStream inDefault = getServletContext().getResourceAsStream("/Imgs/Memberchef/noPhotoAvailable.jpg");
					menuPic = new byte[inDefault.available()];
					inDefault.read(menuPic);
					inDefault.close();
				}
				
				System.out.println(chefNo);
				System.out.println(mainCourse);
				System.out.println(unitPrice);
				System.out.println(deliverable);
				
				/***************************2.開始新增資料***************************************/
				MenuService menuSvc = new MenuService();
				menuSvc.addMenu(chefNo, Integer.parseInt(unitPrice), mainCourse, menuPic, deliverable, menuIntro);
				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				res.setContentType("text/plain");
				res.setCharacterEncoding("UTF-8");
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.put("Exception",e.getMessage());
			}
		}
		
//		=============================================================================
		
		if ("update".equals(action)) { 
        	
        	Map<String,String> errorMsgs = new LinkedHashMap<String,String>();
			req.setAttribute("errorMsgs", errorMsgs);
			try {
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
				String menuNo = req.getParameter("menuNo");
				String chefNo = req.getParameter("chefNo");
				String mainCourse = req.getParameter("mainCourse");
				String unitPrice = req.getParameter("unitPrice");
				String deliverable = "true".equals(req.getParameter("deliverable")) ? "可送餐" : "不可送餐" ;
				String menuIntro = req.getParameter("menuIntro");

				byte[] menuPic = null;
				Part part = req.getPart("menuPic");
				String filename = part.getSubmittedFileName();

				if (filename != "") {
					InputStream in = part.getInputStream();
					menuPic = new byte[in.available()];
					in.read(menuPic);
					in.close();
				} else {
					MenuService menuSvc = new MenuService();
					menuPic = menuSvc.getOneMenu(menuNo).getMenuPic();
				}
				
				System.out.println(menuNo);
				System.out.println(chefNo);
				System.out.println(mainCourse);
				System.out.println(unitPrice);
				System.out.println(deliverable);
				
				/***************************2.開始更新資料***************************************/
				MenuService menuSvc = new MenuService();
				menuSvc.updateMenu(Integer.parseInt(unitPrice), mainCourse, menuPic, deliverable, menuIntro, menuNo);
				
				/***************************3.更新完成,準備轉交(Send the Success view)***********/
				res.setContentType("text/plain");
				res.setCharacterEncoding("UTF-8");
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.put("Exception",e.getMessage());
			}
		}
		
//		=============================================================================
		
		if ("delete".equals(action)) { 
        	
        	Map<String,String> errorMsgs = new LinkedHashMap<String,String>();
			req.setAttribute("errorMsgs", errorMsgs);
			try {
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
				String menuNo = req.getParameter("menuNo");
				
				System.out.println(menuNo);
				System.out.println(action);
				/***************************2.開始刪除資料***************************************/
				MenuService menuSvc = new MenuService();
				System.out.println("1");
				menuSvc.deleteMenu(menuNo);
				System.out.println("2");
				/***************************3.刪除完成,準備轉交(Send the Success view)***********/
				res.setContentType("text/plain");
				res.setCharacterEncoding("UTF-8");
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.put("Exception",e.getMessage());
			}
		}
	}

}
