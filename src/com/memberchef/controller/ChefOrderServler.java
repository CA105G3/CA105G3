package com.memberchef.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.foodorder2.model.*;
import com.member.model.MemberService;
import com.member.model.MemberVO;

@WebServlet("/ChefOrderServler")
public class ChefOrderServler extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		HttpSession session = req.getSession();
		String chefNo = (String)session.getAttribute("chefNo");
		String action = req.getParameter("action");
		
		if ("getOrder".equals(action)) { 
			

			try {
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
				
//				String chefNo = req.getParameter("chefNo");
				
				
				/***************************2.開始查詢資料***************************************/
				FoodOrderService FOsvc = new FoodOrderService();
				List<FoodOrderVO> FOlist = FOsvc.findByChefNo(chefNo);
				List<OrderDetailVO> ODlist = new ArrayList<OrderDetailVO>();
				for(FoodOrderVO FOVO: FOlist){
					String orderno = FOVO.getOrderno();
					Set<OrderDetailVO> ODset = FOsvc.getOrderDetailsByFoodOrder(orderno);
					for(OrderDetailVO ODVO : ODset){
						ODlist.add(ODVO);
					}
				}
				MenuListService menuListSvc = new MenuListService();
				List<MenuListVO> menuList = menuListSvc.getAll();
				MenuService MenuSvc = new MenuService();
				List<MenuVO> menu = MenuSvc.getAll();
				MemberService memSvc = new MemberService();
				List<MemberVO> member = memSvc.getAll();
				
				/***************************3.查詢完成,準備轉交(Send the Success view)***********/
//				req.setAttribute("chefNo", chefNo); 
				req.setAttribute("FOlist", FOlist); 
				req.setAttribute("ODlist", ODlist); 
				req.setAttribute("menu", menu); 
				req.setAttribute("menuList", menuList); 
				req.setAttribute("member", member); 
				String url = "/front\u002dend/memberchef/getOrder.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交memberchef.jsp
				successView.forward(req, res);				
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front\u002dend/memberchef/select_page.jsp");
				failureView.forward(req, res);
			}
		}
        
//				=============================================================================
	}

}
