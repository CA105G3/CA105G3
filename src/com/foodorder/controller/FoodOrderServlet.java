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
		
		if ("getOne_For_Display".equals(action)) { // 來自select_page.jsp的請求

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
							.getRequestDispatcher("/foodorder/select_page.jsp");
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
							.getRequestDispatcher("/foodorder/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************2.開始查詢資料*****************************************/
				//Servlet(設計師)呼叫Service(領班)
				FoodOrderService foodOrderSvc = new FoodOrderService();
				FoodOrderVO foodOrderVO = foodOrderSvc.getOneFoodOrder(orderno);
				if (foodOrderVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/foodorder/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("foodOrderVO", foodOrderVO); // 資料庫取出的empVO物件,存入req
				String url = "/foodorder/listOneFoodOrder.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/foodorder/select_page.jsp");
				failureView.forward(req, res);
			}
		}	
		
		if ("find_Order_By_Memno".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String memno = req.getParameter("memno");
				if ("請選擇".equals(memno)) {
					errorMsgs.add("請選擇會員編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/foodorder/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************2.開始查詢資料*****************************************/
				FoodOrderService foodOrderSvc = new FoodOrderService();
				List<FoodOrderVO> foodOrderVOList= (List<FoodOrderVO>) foodOrderSvc.findByMemno(memno);
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("foodOrderVOList", foodOrderVOList); // 資料庫取出的foodOrderVO物件,存入req
				String url = "/foodorder/listAllFoodOrdersByMemno.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
				successView.forward(req, res);
				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/foodorder/select_page.jsp");
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
					RequestDispatcher failureView = req.getRequestDispatcher("/foodorder/addFoodOrder.jsp");
					failureView.forward(req, res);
					return;
				}
				/***************************2.開始新增資料***************************************/
				FoodOrderService foodOrderSvc = new FoodOrderService();
				foodOrderVO = foodOrderSvc.addFoodOrder(memno, deliverAddr, chefno, orderStatus, ordTime);
				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				String url = "/foodorder/listAllFoodOrders.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/foodorder/addFoodOrder.jsp");
				failureView.forward(req, res);
			}
		}
	}
}

