package com.favdr.controller;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.favdr.model.FavDrService;
import com.favdr.model.FavDrVO;


@WebServlet("/FavDrServlet")
public class FavDrServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req,res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		//新增一筆資料
		if ("insert".equals(action)) {

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
//			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				// 會員編號
				String memNo = req.getParameter("memNo");
				String memNoReq = "^[(M)(0-9)] {5}$";
				if (memNo == null || memNo.trim().length() == 0) {
					errorMsgs.add("會員編號請勿空白");
				}
//				else if(!memNo.trim().matches(memNoReq)) {
//					errorMsgs.add("會員編號請輸入大寫M開頭再加4個數字");
//				}
				// 醫療人員編號
				String drNo = req.getParameter("drNo");
				if (drNo == null || drNo.trim().length() == 0) {
					errorMsgs.add("醫生編號請勿空白");
				}
//				else if(!drNo.trim().matches(memNoReq)) {
//					errorMsgs.add("醫生編號請輸入大寫M開頭再加4個數字");
//				}				
				
				FavDrVO fdVO = new FavDrVO();
				fdVO.setMemNo(memNo);
				fdVO.setDrNo(drNo);


				if (!errorMsgs.isEmpty()) {
					req.setAttribute("fdVO", fdVO);
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/favDr/addfavDr.jsp");
					failureView.forward(req, res);
					return;
				}
				/*************************** 2.開始新增資料 ***************************************/
				FavDrService fdSvc = new FavDrService();
				fdVO = fdSvc.addFavDr(memNo, drNo);
				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
				req.setAttribute("fdVO", fdVO);
				String url = "/front-end/favDr/listAllFavDr.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
				successView.forward(req, res);
				/*************************** 其他可能的錯誤處理 **********************************/
//			} catch (Exception e) {
//				errorMsgs.add(e.getMessage());
//				RequestDispatcher failureData = req.getRequestDispatcher("/front-end/favDr/addFavDr.jsp");
//				failureData.forward(req, res);
//			}
		}
		
		
		
		
	}

}
