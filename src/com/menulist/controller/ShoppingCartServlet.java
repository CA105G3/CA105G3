package com.menulist.controller;

import java.io.*;
import java.lang.management.MemoryNotificationInfo;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.websocket.Session;

import com.foodorder.model.FoodOrderService;
import com.foodorder.model.FoodOrderVO;
import com.member.model.MemberVO;
import com.memberchef.model.MemberChefService;
import com.memberchef.model.MemberChefVO;
import com.menulist.model2.MenuListService;
import com.menulist.model2.MenuListVO;
import com.orderdetail.model.OrderDetailVO;

public class ShoppingCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req,res);
	}
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		res.setContentType("text/html; charset=UTF-8");
	    PrintWriter out = res.getWriter();
	    
		HttpSession session = req.getSession();
		
		@SuppressWarnings("unchecked")
		List<MenuListVO> buylist = (Vector<MenuListVO>) session.getAttribute("shoppingcart");
		String action = req.getParameter("action");
		System.out.println("action==="+action);
		
		
		//以業者名稱查詢
		if ("getMenu_by_chefName".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String str = req.getParameter("chefName");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入業者名稱進行查詢");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/front-end/searchPage/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				String chefName = null;
				try {
					chefName = new String(str);
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
				List<MenuListVO> menuListVOList = (List<MenuListVO>) menuListSvc.findByChefName(chefName);
	System.out.println("menuListVOList.size()="+menuListVOList.size()); 
	System.out.println(chefName); 
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
				req.setAttribute("chefName", chefName); // 資料庫取出的foodOrderVO物件,存入req
				
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
			String url = "/shoppingCart.do?action=getMenu_by_chefName&"+req.getParameter("chefName");
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
			
		    String zone1 = req.getParameter("zone1");
		    if (zone1 == "請選擇") {
		    	zone1 = null;
		    } 
		    String zone2 = req.getParameter("zone2");
		    if (zone2 == "請選擇") {
		    	zone2 = null;
		    } 
		    String zipcode = req.getParameter("zipcode");
			String deliverAddr = req.getParameter("deliverAddr");
			
			deliverAddr = " " + zipcode + zone1+" "+zone2+ " "+ deliverAddr;
			
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
			
//			
			MemberVO memVO = (MemberVO)session.getAttribute("memVO");
			
			if (memVO!=null  && "insert".equals(action)) {
				String memNo = memVO.getMemNo();
				List<String> errorMsgs = new LinkedList<String>();
				req.setAttribute("errorMsgs", errorMsgs);
	System.out.println("action : "+ action);
				try {
//					String memno = req.getParameter("memno");
//					if(memno == null || memno.trim().length() == 0) {
//						errorMsgs.add("會員編號不可空白");
//					}
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
					foodOrderVO.setMemno(memNo);
					foodOrderVO.setDeliverAddr(deliverAddr);
					foodOrderVO.setChefno(chefno);
					System.out.println(chefno);
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
					
					System.out.println("2222222");
					/************************3.新增完成,準備轉交(Send the Success view)***********/
				
					String url = "/front-end/foodorder/listAllFoodOrders.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url);
					successView.forward(req, res);
					session.removeAttribute("shoppingcart");
					return;
				} catch (Exception e) {
					errorMsgs.add(e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/index.jsp");
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
		String chefName = req.getParameter("chefName");
		String mainCourse = req.getParameter("mainCourse");
		String menuTimeSlot = req.getParameter("menuTimeSlot");
		Date menuDate = java.sql.Date.valueOf(req.getParameter("menuDate"));
//		int amount = 1;
		int amount = Integer.valueOf(req.getParameter("amount"));
		int unitPrice = Integer.valueOf(req.getParameter("unitPrice"));
		String chefNo = req.getParameter("chefNo");
		String menuListNo = req.getParameter("menuListNo");
		
		MenuListVO menu = new MenuListVO();
		menu.setChefRep(chefRep);
		menu.setChefName(chefName);
		menu.setMainCourse(mainCourse);
		menu.setMenuDate(menuDate);
		menu.setMenuTimeSlot(menuTimeSlot);
		menu.setAmount(amount);
		menu.setUnitPrice(unitPrice);
		menu.setChefNo(chefNo);
		menu.setMenuListNo(menuListNo);
		return menu;
	}
}
