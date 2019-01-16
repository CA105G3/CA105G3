package com.foodorder.controller;

import java.io.*;
import java.util.*;

import javax.servlet.*;
import javax.servlet.http.*;

import com.foodorder.model.*;

public class FoodOrderServlet extends HttpServlet {

	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		if ("getOrder_by_Orderno".equals(action)) { // 來自select_page.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String str = req.getParameter("orderno");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入訂單編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/foodorder/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				String orderno = null;
				try {
					orderno = new String(str);
				} catch (Exception e) {
					errorMsgs.add("訂單編號格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/foodorder/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************2.開始查詢資料*****************************************/
				//Servlet(設計師)呼叫Service(領班)
				FoodOrderService foodOrderSvc = new FoodOrderService();
				FoodOrderVO foodOrderVO = foodOrderSvc.findByOrderno(orderno);
				if (foodOrderVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/foodorder/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("foodOrderVO", foodOrderVO); // 資料庫取出的foodOrderVO物件,存入req
				String url = "/front-end/foodorder/listFoodOrderByOrderno.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/foodorder/select_page.jsp");
				failureView.forward(req, res);
			}
		}	
		
		if ("getOrders_by_memId".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String str = req.getParameter("memId");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入帳號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/foodorder/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				String memId = null;
				try {
					memId = new String(str);
				} catch (Exception e) {
					errorMsgs.add("帳號不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/foodorder/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************2.開始查詢資料*****************************************/
				FoodOrderService foodOrderSvc = new FoodOrderService();
				List<FoodOrderVO> foodOrderVOList = (List<FoodOrderVO>) foodOrderSvc.findBy_MemId(memId);
				if (foodOrderVOList == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/foodorder/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("foodOrderVOList", foodOrderVOList); // 資料庫取出的foodOrderVO物件,存入req
				String url = "/front-end/foodorder/listAllFoodOrdersByMemId.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
				successView.forward(req, res);
				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/foodorder/select_page.jsp");
				failureView.forward(req, res);
			}

		}
		
		if ("getOrders_by_email".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String str = req.getParameter("email");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入EMAIL查詢");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/foodorder/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				String email = null;
				try {
					email = new String(str);
				} catch (Exception e) {
					errorMsgs.add("EMAIL不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/foodorder/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************2.開始查詢資料*****************************************/
				FoodOrderService foodOrderSvc = new FoodOrderService();
				List<FoodOrderVO> foodOrderVOList = (List<FoodOrderVO>) foodOrderSvc.findBy_Email(email);
				if (foodOrderVOList == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/foodorder/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("foodOrderVOList", foodOrderVOList); // 資料庫取出的foodOrderVO物件,存入req
				String url = "/front-end/foodorder/listAllFoodOrdersByEmail.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
				successView.forward(req, res);
				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/foodorder/select_page.jsp");
				failureView.forward(req, res);
			}

		}
		
		if ("getOrders_by_memno".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
//			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String str = req.getParameter("memno");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入EMAIL查詢");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/foodorder/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				String memno = null;
				try {
					memno = new String(str);
				} catch (Exception e) {
					errorMsgs.add("會員編號不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/foodorder/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************2.開始查詢資料*****************************************/
				FoodOrderService foodOrderSvc = new FoodOrderService();
				List<FoodOrderVO> foodOrderVOList = (List<FoodOrderVO>) foodOrderSvc.findBy_Memno(memno);
				if (foodOrderVOList == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/foodorder/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("foodOrderVOList", foodOrderVOList); // 資料庫取出的foodOrderVO物件,存入req
				String url = "/front-end/foodorder/listAllFoodOrdersByMemno.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
				successView.forward(req, res);
				/***************************其他可能的錯誤處理*************************************/
//			} catch (Exception e) {
//				errorMsgs.add("無法取得資料:" + e.getMessage());
//				RequestDispatcher failureView = req
//						.getRequestDispatcher("/front-end/foodorder/select_page.jsp");
//				failureView.forward(req, res);
//			}

		}
		
		if ("update_Order_Status".equals(action)) { // 來自update_emp_input.jsp的請求
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
		
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String orderStatus = req.getParameter("orderStatus");
				String orderno = req.getParameter("orderno");

				FoodOrderVO foodOrderVO = new FoodOrderVO();
				foodOrderVO.setOrderStatus(orderStatus);
				foodOrderVO.setOrderno(orderno);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("foodOrderVO", foodOrderVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/listAllFoodOrdersByEmail.jsp");
					failureView.forward(req, res);
					return; //程式中斷
				}
				
				/***************************2.開始修改資料*****************************************/
				FoodOrderService foodOrderSvc = new FoodOrderService();
				foodOrderVO = foodOrderSvc.updateOrderStatus(orderStatus, orderno);
				
				/***************************3.修改完成,準備轉交(Send the Success view)*************/
				req.setAttribute("foodOrderVO", foodOrderVO); // 資料庫update成功後,正確的的empVO物件,存入req
				String url = "/front-end/foodorder/listAllFoodOrdersByEmail.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneEmp.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/foodorder/listAllFoodOrdersByEmail.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("insert".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				String memno = req.getParameter("memno");
				if(memno == null || memno.trim().length() == 0) {
					errorMsgs.add("會員編號不可空白");
				}
				String deliverAddr = req.getParameter("deliverAddr");
				String chefno = req.getParameter("chefno");
				String orderStatus = req.getParameter("orderStatus");
				java.sql.Date ordTime = null;
				try {
					ordTime = java.sql.Date.valueOf(req.getParameter("ordTime").trim());
				} catch(IllegalArgumentException e) {
					ordTime = new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("請輸入日期");
				}
				
				FoodOrderVO foodOrderVO = new FoodOrderVO();
				foodOrderVO.setMemno(memno);
				foodOrderVO.setDeliverAddr(deliverAddr);
				foodOrderVO.setChefno(chefno);
				foodOrderVO.setOrderStatus(orderStatus);
				foodOrderVO.setOrdTime(ordTime);
				
				if(!errorMsgs.isEmpty()) {
					req.setAttribute("foodOrderVO", foodOrderVO);
					RequestDispatcher failureView = req.getRequestDispatcher("/front-end/foodorder/addFoodOrder.jsp");
					failureView.forward(req, res);
					return;
				}
				/***************************2.開始新增資料***************************************/
				FoodOrderService foodOrderSvc = new FoodOrderService();
				foodOrderVO = foodOrderSvc.addFoodOrder(memno, deliverAddr, chefno, orderStatus, ordTime);
				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				String url = "/front-end/foodorder/listAllFoodOrders.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/foodorder/addFoodOrder.jsp");
				failureView.forward(req, res);
			}
		}
	}
}

