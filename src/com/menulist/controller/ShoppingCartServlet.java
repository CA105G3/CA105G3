package com.menulist.controller;

import java.io.*;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.websocket.Session;

import com.foodorder.model.FoodOrderService;
import com.foodorder.model.FoodOrderVO;
import com.menulist.model2.*;
import com.orderdetail.model.OrderDetailVO;

public class ShoppingCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req,res);
	}
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		HttpSession session = req.getSession();

		@SuppressWarnings("unchecked")
		List<MenuListVO> buylist = (Vector<MenuListVO>) session.getAttribute("shoppingcart");
		String action = req.getParameter("action");
		System.out.println("action==="+action);
		
		
		//以業者名稱查詢
		if ("getMenu_by_chefRep".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String str = req.getParameter("chefRep");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入業者名稱進行查詢");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/front-end/searchPage/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				String chefRep = null;
				try {
					chefRep = new String(str);
				} catch (Exception e) {
					errorMsgs.add("業者名稱不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/front-end/searchPage/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 2.開始查詢資料 *****************************************/
				MenuListService menuListSvc = new MenuListService();
				List<MenuListVO> menuListVOList = (List<MenuListVO>) menuListSvc.findByChefRep(chefRep);
				if (menuListVOList == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/front-end/searchPage/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				req.setAttribute("menuListVOList", menuListVOList); // 資料庫取出的foodOrderVO物件,存入req
				req.setAttribute("chefRep", chefRep); // 資料庫取出的foodOrderVO物件,存入req
				String url = "/front-end/searchPage/listAllMenuByChef.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
				successView.forward(req, res);
				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/searchPage/select_page.jsp");
				failureView.forward(req, res);
			}
		}
		
		// 新增餐點至購物車中
		if (action.equals("ADD")) {
			// 取得後來新增的書籍
			MenuListVO aMenu = getMenu(req);

			if (buylist == null) {
				buylist = new Vector<MenuListVO>();
				buylist.add(aMenu);
			} else {
				if (buylist.contains(aMenu)) {
					MenuListVO innerMenu = buylist.get(buylist.indexOf(aMenu));
					innerMenu.setAmount(innerMenu.getAmount() + aMenu.getAmount());
				} else {
					buylist.add(aMenu);
				}
			}
			session.setAttribute("shoppingcart", buylist);

//			String url = "/front-end/menulist/menulist.do?action=For_Display&"+req.getParameter("chefNo");
			String url = "/shoppingCart.do?action=getMenu_by_chefRep&"+req.getParameter("chefRep");
			RequestDispatcher successView = req.getRequestDispatcher(url); 
			successView.forward(req, res);

		}

		// 刪除購物車中的餐點
		if (action.equals("DELETE")) {
			String del = req.getParameter("del");
			int d = Integer.parseInt(del);
			buylist.remove(d);
			String url = "/front-end/searchPage/shoppingCart.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
			successView.forward(req, res);
		}

		// 結帳，計算購物車中訂餐價錢總數
		if (action.equals("CHECKOUT")) {
			String chefNo = req.getParameter("chefNo");
			String orderStatus = req.getParameter("orderStatus");
			String deliverAddr = req.getParameter("deliverAddr");
			String[] amountArray = req.getParameterValues("amount");
			double totalTemp = 0;
			for (int i = 0; i < buylist.size(); i++) {
				MenuListVO order = buylist.get(i);
				order.setAmount(Integer.parseInt(amountArray[i]));
				int unitPrice = order.getUnitPrice();
				int amount = order.getAmount();
				totalTemp += (unitPrice * amount);
			}
			
			
			String total = String.valueOf(totalTemp);
			System.out.println("total="+total);
			req.setAttribute("total", total);
			
			req.setAttribute("deliverAddr", deliverAddr);
			
			session.setAttribute("shoppingcart", buylist);
			
			String url2 = "/front-end/searchPage/checkOut.jsp";
			RequestDispatcher rd = req.getRequestDispatcher(url2);
			rd.forward(req, res);
			
		}
			
			
			
			
			if ("insert".equals(action)) {
				List<String> errorMsgs = new LinkedList<String>();
				req.setAttribute("errorMsgs", errorMsgs);
	System.out.println("action : "+ action);
				try {
					String memno = req.getParameter("memno");
					if(memno == null || memno.trim().length() == 0) {
						errorMsgs.add("會員編號不可空白");
					}
					String deliverAddr = req.getParameter("deliverAddr");
					String total = req.getParameter("total");
					System.out.println("-----" + total);
					String chefno = req.getParameter("chefNo");
//					String orderStatus = req.getParameter("orderStatus");
					java.sql.Date ordTime = null;
//					try {
//						ordTime = java.sql.Date.valueOf(req.getParameter("ordTime").trim());
//					} catch(IllegalArgumentException e) {
//						ordTime = new java.sql.Date(System.currentTimeMillis());
//						errorMsgs.add("請輸入日期");
//					}
					String orderStatus = req.getParameter("orderStatus");
					
					List<OrderDetailVO> odlist = new ArrayList<OrderDetailVO>();
					
					
					for (int i = 0; i < buylist.size(); i++) {
						OrderDetailVO orderDetailVO = new OrderDetailVO();
						MenuListVO menuListVO = buylist.get(i);
						orderDetailVO.setMenuListno(menuListVO.getMenuListNo());
						orderDetailVO.setUnitPrice(menuListVO.getUnitPrice());
						orderDetailVO.setAmount(menuListVO.getAmount());
						System.out.println(menuListVO.getUnitPrice());
						odlist.add(orderDetailVO);
					}
					
					
					FoodOrderVO foodOrderVO = new FoodOrderVO();
					foodOrderVO.setMemno(memno);
	System.out.println(memno);
					foodOrderVO.setDeliverAddr(deliverAddr);
					foodOrderVO.setChefno(chefno);
					foodOrderVO.setOrderStatus(orderStatus);
					
					req.setAttribute("foodOrderVO", foodOrderVO);
					req.setAttribute("total", total);
					
					if(!errorMsgs.isEmpty()) {
						req.setAttribute("foodOrderVO", foodOrderVO);
						RequestDispatcher failureView = req.getRequestDispatcher("/front-end/searchPage/checkOut.jsp");
						failureView.forward(req, res);
						return;
					}
					
					
					/***************************2.開始新增資料***************************************/
					FoodOrderService foodOrderSvc = new FoodOrderService();
					foodOrderSvc.insertWithOrderDetails(foodOrderVO, odlist);
					
					System.out.println("新增成功");
					
					
					/************************3.新增完成,準備轉交(Send the Success view)***********/
				
					String url = "/front-end/foodorder/listAllFoodOrders.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url);
					successView.forward(req, res);
					session.removeAttribute("shoppingcart");
					return;
				} catch (Exception e) {
					errorMsgs.add(e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/searchPage/checkOut.jsp");
					failureView.forward(req, res);
				}
			}
			
			
//		if ("getMenu_by_menuTimeSlot".equals(action)) {
//			List<String> errorMsgs = new LinkedList<String>();
//			req.setAttribute("errorMsgs", errorMsgs);
//
//			try {
//				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
//				String str = req.getParameter("menuTimeSlot");
//				if (str == null || (str.trim()).length() == 0) {
//					errorMsgs.add("請輸入供餐時段進行查詢");
//				}
//				// Send the use back to the form, if there were errors
//				if (!errorMsgs.isEmpty()) {
//					RequestDispatcher failureView = req
//							.getRequestDispatcher("/front-end/searchPage/select_page.jsp");
//					failureView.forward(req, res);
//					return;// 程式中斷
//				}
//
//				String menuTimeSlot = null;
//				try {
//					menuTimeSlot = new String(str);
//				} catch (Exception e) {
//					errorMsgs.add("輸入格式不正確");
//				}
//				// Send the use back to the form, if there were errors
//				if (!errorMsgs.isEmpty()) {
//					RequestDispatcher failureView = req
//							.getRequestDispatcher("/front-end/searchPage/select_page.jsp");
//					failureView.forward(req, res);
//					return;// 程式中斷
//				}
//
//				/*************************** 2.開始查詢資料 *****************************************/
//				MenuListService menuListSvc = new MenuListService();
//				List<MenuListVO> menuListVOList = (List<MenuListVO>) menuListSvc.findByMenuTimeSlot(menuTimeSlot);
//				if (menuListVOList == null) {
//					errorMsgs.add("查無資料");
//				}
//				// Send the use back to the form, if there were errors
//				if (!errorMsgs.isEmpty()) {
//					RequestDispatcher failureView = req
//							.getRequestDispatcher("/front-end/searchPage/select_page.jsp");
//					failureView.forward(req, res);
//					return;// 程式中斷
//				}
//
//				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
//				req.setAttribute("menuListVOList", menuListVOList); // 資料庫取出的foodOrderVO物件,存入req
//				String url = "/front-end/searchPage/listAllMenuByTime.jsp";
//				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
//				successView.forward(req, res);
//				/*************************** 其他可能的錯誤處理 *************************************/
//			} catch (Exception e) {
//				errorMsgs.add("無法取得資料:" + e.getMessage());
//				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/searchPage/select_page.jsp");
//				failureView.forward(req, res);
//			}
//
//		}

		
	}

	private MenuListVO getMenu(HttpServletRequest req) {
		String chefRep = req.getParameter("chefRep");
		String mainCourse = req.getParameter("mainCourse");
		String menuTimeSlot = req.getParameter("menuTimeSlot");
		int amount = 1;
//		int amount = Integer.valueOf(req.getParameter("amount"));
		int unitPrice = Integer.valueOf(req.getParameter("unitPrice"));
		String chefNo = req.getParameter("chefNo");
		String menuListNo = req.getParameter("menuListNo");
		
		MenuListVO menu = new MenuListVO();
		menu.setChefRep(chefRep);
		menu.setMainCourse(mainCourse);
		menu.setMenuTimeSlot(menuTimeSlot);
		menu.setAmount(amount);
		menu.setUnitPrice(unitPrice);
		menu.setChefNo(chefNo);
		menu.setMenuListNo(menuListNo);
		return menu;
	}
}
