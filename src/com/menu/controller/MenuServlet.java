package com.menu.controller;

import java.io.IOException;
import java.io.InputStream;
import java.util.Collection;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.menu.model.MenuService;
import com.menu.model.MenuVO;


@WebServlet("/MenuServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 500 * 6000 * 6000, maxRequestSize = 10 * 500 * 6000 * 6000)
public class MenuServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		HttpSession session = req.getSession();
		

		if ("getOne_For_Display".equals(action)) { // 來自*.jsp的請求  
			
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
//				String chefNo = req.getParameter("chefNo");
				String chefNo = (String) session.getAttribute("chefNo");
				String chefNoReg = "^CHEF[0-9]{4}";
				if (chefNo == null || chefNo.trim().length() == 0) {
					errorMsgs.add("廚師編號: 請勿空白");
				} else if(!chefNo.trim().matches(chefNoReg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("廚師編號: 只能是CHEF加上4位數字的組合");
	            }

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					System.out.println("2");
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front\u002dend/menu/select_page.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始查詢資料***************************************/
				MenuService menuSvc = new MenuService();
				List<MenuVO> list = menuSvc.getOneChefMenu(chefNo);
				
				if (list == null) {
					String url = "/front\u002dend/menu/menu.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url);
					successView.forward(req, res);	
					return;
				}
				
				/***************************3.查詢完成,準備轉交(Send the Success view)***********/
				req.setAttribute("list", list); // 資料庫取出的List<menuVO>物件,存入req
				String url = "/front\u002dend/menu/menu.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交menu.jsp
				successView.forward(req, res);				
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				System.out.println(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front\u002dend/menu/select_page.jsp");
				failureView.forward(req, res);
			}
		}
        
//				=============================================================================
		
		if ("getOne_For_Update".equals(action)) { // 來自*menu.jsp的請求  
			
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
//				String chefNo = req.getParameter("chefNo");
				String chefNo = (String)session.getAttribute("chefNo");
				
				/***************************2.開始查詢資料***************************************/
				MenuService menuSvc = new MenuService();
				List<MenuVO> list = menuSvc.getOneChefMenu(chefNo);
				
				if (list == null) {
//					errorMsgs.add("查無資料");
					String url = "/front\u002dend/menu/updatemenu.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url); 
					successView.forward(req, res);	
					System.out.println("1");
					return;
				}
				
				/***************************3.查詢完成,準備轉交(Send the Success view)***********/
//				req.setAttribute("list", list); // 資料庫取出的List<menuVO>物件,存入req
				session.setAttribute("list", list); // 資料庫取出的List<menuVO>物件,存入req
				String url = "/front\u002dend/menu/updatemenu.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); 
				successView.forward(req, res);				
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				System.out.println(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front\u002dend/menu/menu.jsp");
				failureView.forward(req, res);
			}
		}
        
//				=============================================================================

//        if ("update".equals(action)) { // 來自updateAllMenu.jsp的請求
//			
//			Map<String,String> errorMsgs = new LinkedHashMap<String,String>();
//			req.setAttribute("errorMsgs", errorMsgs);
//			
//
//			try {
//				/***********************1.接收請求參數 & 新增修改資料******************************/
//				
//				MenuVO menuVO = new MenuVO();
//				MenuService menuSvc = new MenuService();
//				
//				String[] mainCourseList = req.getParameterValues("mainCourse");
//				String[] unitPriceList = req.getParameterValues("unitPrice");
//				String[] deliverableList = req.getParameterValues("deliverable");
//				String[] menuNoList = req.getParameterValues("menuNo");
//				String[] chefNoList = req.getParameterValues("chefNo");
//				Collection<Part> menuPicPart = req.getParts();
//				
//				for(Part part : menuPicPart) {
//					System.out.println(part);
//				}
//				
//				List<byte[]> menuPicList = new LinkedList<byte[]>();
//				int count = 0;
//				for(Part part : menuPicPart) {
//					
//					if("menuPic".equals(part.getName())) {
//						byte[] pic = null;
//						String filename = part.getSubmittedFileName();
//						if (filename != "") {
//							InputStream in = part.getInputStream();
//							pic = new byte[in.available()];
//							in.read(pic);
//							in.close();
//							menuPicList.add(pic);
//							count++;
//						} else {
//							pic = menuSvc.getOneMenu(menuNoList[count]).getMenuPic();
//							if(pic != null) {
//								menuPicList.add(pic);
//							} else {
//								InputStream inDefault = getServletContext().getResourceAsStream("/Imgs/Menu/nopic.jpg");
//								pic = new byte[inDefault.available()];
//								inDefault.read(pic);
//								inDefault.close();
//								menuPicList.add(pic);
//							}
//							count++;
//						}
//					}
//				}
//				
//				for(String a : mainCourseList) {
//					System.out.print(a + " ");
//				}
//				System.out.println("----------------------");
//				for(String a : unitPriceList) {
//					System.out.print(a + " ");
//				}
//				System.out.println("----------------------");
//				for(String a : deliverableList) {
//					System.out.print(a + " ");
//				}
//				System.out.println("----------------------");
//				for(String a : menuNoList) {
//					System.out.print(a + " ");
//				}
//				System.out.println("----------------------");
//				for(String a : chefNoList) {
//					System.out.print(a + " ");
//				}
//				System.out.println("----------------------");
//				
//				
//				
//				System.out.println(chefNoList[1]);
//				System.out.println(menuPicPart.size());
//				System.out.println(menuPicList.size());
//				System.out.println(mainCourseList.length);
//				System.out.println(unitPriceList.length);
//				System.out.println(deliverableList.length);
//				System.out.println(menuNoList.length);
//				System.out.println(chefNoList.length);
//
//				menuVO = menuSvc.getOneMenu(menuNoList[1]);
//				if(menuVO == null) {
//					System.out.println("1");
//				} else {
//					System.out.println("2");
//				}
//				
//				for(int i = 0; i < mainCourseList.length; i++) {
//					menuVO = menuSvc.getOneMenu(menuNoList[i]);
//					byte[] menuPic = menuSvc.getOneMenu(menuNoList[i]).getMenuPic();
//					
//					if(menuVO == null) {
//						if(mainCourseList[i] != "") {
//							menuSvc.addMenu(chefNoList[0], Integer.parseInt(unitPriceList[i].trim()), mainCourseList[i], menuPicList.get(i), "可送餐");
//							System.out.println("add");
//						}
//					} else {
//						menuSvc.updateMenu(Integer.parseInt(unitPriceList[i].trim()), mainCourseList[i], menuPicList.get(i), "可送餐", menuNoList[i]);
//						System.out.println("up");
//					}
//				}
//				
//				List<MenuVO> list = menuSvc.getOneChefMenu(chefNoList[0]);
//				
//				/***************************3.修改完成,準備轉交(Send the Success view)***********/
//				req.setAttribute("list", list);
//				String url = "/front\u002dend/menu/menu.jsp";
//				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交menu.jsp
//				successView.forward(req, res);				
//				
//				/***************************其他可能的錯誤處理**********************************/
//			} catch (Exception e) {
//				errorMsgs.put("Exception",e.getMessage());
//				RequestDispatcher failureView = req
//						.getRequestDispatcher("/front\u002dend/menu/select_page.jsp");
//				failureView.forward(req, res);
//			}
//        }
//        
//		=============================================================================
        
//        if ("insert".equals(action)) { // 來自updateAllMenu.jsp的請求
//			
//			Map<String,String> errorMsgs = new LinkedHashMap<String,String>();
//			req.setAttribute("errorMsgs", errorMsgs);
//
//			try {
//				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
//				String chefNo = req.getParameter("chefNo");
//				
//				int unitPrice = Integer.parseInt(req.getParameter("unitPrice")); 
//				if (unitPrice == 0) {
//					errorMsgs.put("unitPrice","請輸入餐點價格");
//				}
//				
//				String mainCourse = req.getParameter("mainCourse").trim();
//				if (mainCourse == null || mainCourse.trim().length() == 0) {
//					errorMsgs.put("mainCourse","請輸入餐點名稱");
//				}
//				
//				byte[] menuPic = null;
//				Part part = req.getPart("menuPic");
//				String filename = part.getSubmittedFileName();
//
//				if (filename != "") {
//					InputStream in = part.getInputStream();
//					menuPic = new byte[in.available()];
//					in.read(menuPic);
//					in.close();
//				} else {
//					InputStream inDefault = getServletContext().getResourceAsStream("/Imgs/Menu/noPhotoAvailable.jpg");
//					menuPic = new byte[inDefault.available()];
//					inDefault.read(menuPic);
//					inDefault.close();
//				}
//				
//				String deliverable = req.getParameter("deliverable").trim();
//				if (deliverable == null || deliverable.trim().length() == 0) {
//					errorMsgs.put("chefAddr","請選擇可否送餐");
//				}
//
//				// Send the use back to the form, if there were errors
//				if (!errorMsgs.isEmpty()) {
//					RequestDispatcher failureView = req
//							.getRequestDispatcher("/menu/updateAllMenu.jsp");
//					failureView.forward(req, res);
//					return;
//				}
//				
//				/***************************2.開始新增資料***************************************/
//				MenuService menuSvc = new MenuService();
//				menuSvc.addMenu(chefNo, unitPrice, mainCourse, menuPic, deliverable);
//				
//				/***************************3.新增完成,準備轉交(Send the Success view)***********/
//				String url = "/menu/getAllMenu.jsp";
//				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllMenuList.jsp
//				successView.forward(req, res);				
//				
//				/***************************其他可能的錯誤處理**********************************/
//			} catch (Exception e) {
//				errorMsgs.put("Exception",e.getMessage());
//				RequestDispatcher failureView = req
//						.getRequestDispatcher("/menu/updateAllMenu.jsp");
//				failureView.forward(req, res);
//			}
//		}
	}

}
